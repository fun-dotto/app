"""campus-guide のフロア GeoJSON から dotto の IMDF を作り直す。

入力: funswift/campus-guide の public/ (main-N.geojson, research-N.geojson,
metadata.json)。座標は建物ごとのピクセル座標 (MapLibre でそのまま描画するため y 軸が上向き)。

既存 IMDF の footprint / building / venue / address はそのまま使い、
ピクセル座標を相似変換 (スケール・回転・平行移動) で footprint に合わせて
level / unit / relationship を作り直す。変換は footprint の角とピクセル図面の
角の対応点から最小二乗で求める。

区画の roomId (時間割 API の部屋 ID) と設備情報は、部屋名や番号で旧 IMDF の
区画と対応付けて引き継ぐ。

使い方:
    python3 scripts/convert_campus_guide_to_imdf.py <campus-guide/public>
"""

from __future__ import annotations

import datetime
import json
import math
import re
import sys
import uuid
from pathlib import Path

import numpy as np
from shapely.geometry import MultiPolygon, Polygon, mapping, shape
from shapely.ops import unary_union

IMDF = Path(__file__).resolve().parent.parent / "apps/dotto/assets/map/imdf"
NAMESPACE = uuid.UUID("6f1c3c38-0d6b-4b8e-9a59-1f6c0a3f2d11")

# 経緯度 <-> 局所平面 (m)
LON0, LAT0 = 140.767, 41.842
KX = 111320 * math.cos(math.radians(LAT0))
KY = 110574


def to_xy(lon: float, lat: float) -> tuple[float, float]:
    return ((lon - LON0) * KX, (lat - LAT0) * KY)


def to_lonlat(x: float, y: float) -> list[float]:
    return [round(LON0 + x / KX, 8), round(LAT0 + y / KY, 8)]


# 建物の軸 (footprint の辺の向き)。u: 北東方向, w: 南東方向
AXIS = math.radians(64.67)
U = np.array([math.cos(AXIS), math.sin(AXIS)])
W = np.array([math.cos(AXIS - math.pi / 2), math.sin(AXIS - math.pi / 2)])

# ピクセル座標 -> footprint 上の (u, w) [m] の対応点
CONTROL_POINTS = {
    # 本部棟: 本体の矩形 (x 0..1046, y 0..921) と北東の張り出し (x 1046..1162)
    "main": [
        ((0, 0), (-73.0, 58.8)),
        ((1046, 0), (43.3, 58.8)),
        ((0, 921), (-73.0, -44.2)),
        ((1046, 921), (43.3, -44.2)),
        ((1162, 577), (55.4, -4.0)),
        ((1162, 921), (55.3, -43.6)),
    ],
    # 研究棟: 本体の矩形 (x 69..509, y 329..792) と本部棟への連絡部の先端
    "research": [
        ((69, 329), (-65.2, -59.6)),
        ((509, 329), (-17.0, -59.6)),
        ((69, 792), (-65.4, -111.3)),
        ((509, 792), (-17.0, -111.3)),
        ((891, 471), (26.1, -75.6)),
    ],
}


def fit_similarity(src, dst):
    """src -> dst の相似変換を最小二乗で求める。"""
    p = np.array(src, dtype=float)
    q = np.array(dst, dtype=float)
    pm, qm = p.mean(0), q.mean(0)
    a, b = p - pm, q - qm
    s2 = (a**2).sum()
    c = (a[:, 0] * b[:, 0] + a[:, 1] * b[:, 1]).sum() / s2
    d = (a[:, 0] * b[:, 1] - a[:, 1] * b[:, 0]).sum() / s2
    r = np.array([[c, -d], [d, c]])
    t = qm - r @ pm
    res = np.linalg.norm((r @ p.T).T + t - q, axis=1)
    return r, t, res


def make_transform(building: str):
    src = [s for s, _ in CONTROL_POINTS[building]]
    dst = [u * U + w * W for _, (u, w) in CONTROL_POINTS[building]]
    r, t, res = fit_similarity(src, dst)
    scale = math.hypot(r[0, 0], r[1, 0])
    angle = math.degrees(math.atan2(r[1, 0], r[0, 0]))
    print(
        f"{building}: {scale:.5f} m/px, rotation {angle:.2f} deg, "
        f"residual max {res.max():.2f} m",
        file=sys.stderr,
    )

    def apply(x: float, y: float) -> tuple[float, float]:
        v = r @ np.array([x, y]) + t
        return (float(v[0]), float(v[1]))

    return apply


# campus-guide のフロア -> dotto の階
FLOORS = [
    # (building, n, Floor.label, ordinal, 名前)
    ("main", 1, "1", 0, "本部棟 1F"),
    ("main", 2, "2", 1, "本部棟 2F"),
    ("main", 3, "3", 2, "本部棟 3F"),
    ("main", 4, "4", 3, "本部棟 4F"),
    ("main", 5, "5", 4, "本部棟 5F"),
    # 研究棟 7F (research-2) が本部棟 3F と連絡通路でつながっている
    ("research", 1, "R6", 1, "研究棟 6F"),
    ("research", 2, "R7", 2, "研究棟 7F"),
]

# metadata の category -> (IMDF unit category, dotto kind, restroomTypes)
CATEGORIES = {
    "faculty": ("office", "facultyRoom", None),
    "facility": ("room", "otherRoom", None),
    "classroom": ("classroom", "classroom", None),
    "other": ("room", "otherRoom", None),
    "stairs": ("stairs", "stair", None),
    "elevator": ("elevator", "elevator", None),
    "mens_restroom": ("restroom.male", "restroom", ["men"]),
    "womens_restroom": ("restroom.female", "restroom", ["women"]),
    "barrier_free_restroom": (
        "restroom.unisex.wheelchair",
        "restroom",
        ["multipurpose"],
    ),
    "shower": ("shower", "otherRoom", None),
    "mens_shower": ("shower", "otherRoom", None),
    "womens_shower": ("shower", "otherRoom", None),
}


def to_geo(poly: Polygon, f) -> Polygon:
    return Polygon(
        [f(x, y) for x, y in poly.exterior.coords],
        [[f(x, y) for x, y in r.coords] for r in poly.interiors],
    )


def geo_geometry(poly: Polygon) -> dict:
    return {
        "type": "Polygon",
        "coordinates": [
            [to_lonlat(x, y) for x, y in poly.exterior.coords],
            *[[to_lonlat(x, y) for x, y in r.coords] for r in poly.interiors],
        ],
    }


def geo_point(poly: Polygon) -> dict:
    p = poly.representative_point()
    return {"type": "Point", "coordinates": to_lonlat(p.x, p.y)}


def polygons(geom) -> list[Polygon]:
    if isinstance(geom, Polygon):
        return [geom] if not geom.is_empty else []
    if isinstance(geom, MultiPolygon):
        return list(geom.geoms)
    return [g for g in getattr(geom, "geoms", []) if isinstance(g, Polygon)]


def uid(*parts: str) -> str:
    return str(uuid.uuid5(NAMESPACE, "/".join(parts)))


def load_old_rooms() -> dict[tuple[str, str], dict]:
    """旧 IMDF の (階, roomId または label) -> dotto プロパティ。"""
    rooms = {}
    for feature in json.loads((IMDF / "unit.geojson").read_text())["features"]:
        d = feature["properties"]["dotto"]
        for key in ("roomId",):
            if key in d:
                rooms[(d["floor"], d[key])] = d
    return rooms


# 名前や番号では対応が取れない部屋の roomId
ROOM_ID_OVERRIDES = {
    "M-1-facility-001": "食堂",
    "M-2-facility-002": "購買",
    "M-3-facility-006": "社会連携センター",
    "M-3-facility-008": "ライブラリ",
    "M-4-classroom-494": "494C&D",
    "M-4-classroom-495": "495C&D",
    "M-4-facility-003": "特別応接室",
    "M-5-facility-021": "M501",
}


def room_id_candidates(meta: dict, building: str) -> list[str]:
    name = meta["name_japanese"].strip()
    out = [ROOM_ID_OVERRIDES[meta["id"]]] if meta["id"] in ROOM_ID_OVERRIDES else []
    out.append(name)
    m = re.search(r"([A-Z]?)(\d{3})$", name)
    if m:
        out += [m.group(1) + m.group(2), m.group(2)]
    alias = str(meta.get("name_aliases") or "")
    if alias:
        out.append(alias)
        if building == "research" and alias.isdigit():
            out.append("R" + alias)
    return out


def main(src: Path) -> None:
    meta = {m["id"]: m for m in json.loads((src / "metadata.json").read_text())}
    old_rooms = load_old_rooms()
    used_room_ids: set[tuple[str, str]] = set()
    building_ids = {
        f["properties"]["name"]["ja"]: f["id"]
        for f in json.loads((IMDF / "building.geojson").read_text())["features"]
    }
    bid = {"main": building_ids["本部棟"], "research": building_ids["研究棟"]}
    transforms = {b: make_transform(b) for b in CONTROL_POINTS}

    levels, units = [], []
    vertical: list[tuple[str, str, int, str, Polygon]] = []
    for building, n, label, ordinal, name in FLOORS:
        f = transforms[building]
        level_id = uid("level", building, str(n))
        features = json.loads((src / f"{building}-{n}.geojson").read_text())[
            "features"
        ]
        bases, rooms, voids = [], [], []
        for x in features:
            if x["geometry"]["type"] != "Polygon":
                continue
            p = x["properties"]
            fid = p["id"]
            geom = to_geo(shape(x["geometry"]).buffer(0), f)
            if fid == "base":
                bases.append(geom)
            elif fid == "void":
                voids.append(geom)
            elif p.get("shapeType") == "STAR" or fid == "semicircle":
                continue  # ラベル位置・装飾
            elif fid in meta:
                rooms.append((fid, meta[fid], geom))
            # それ以外 (階段の矢印など) は描画用の図形なので使わない

        floor_shape = unary_union(bases)
        level_poly = max(polygons(floor_shape), key=lambda g: g.area)
        levels.append(
            {
                "id": level_id,
                "type": "Feature",
                "feature_type": "level",
                "geometry": geo_geometry(Polygon(level_poly.exterior)),
                "properties": {
                    "category": "unspecified",
                    "restriction": None,
                    "outdoor": False,
                    "ordinal": ordinal,
                    "name": {"ja": name},
                    "short_name": {"ja": name.split()[-1]},
                    "display_point": geo_point(level_poly),
                    "address_id": None,
                    "building_ids": [bid[building]],
                },
            }
        )

        def add_unit(key, geom, category, dotto, name=None, alt=None, point=True):
            for i, g in enumerate(polygons(geom)):
                if g.area < 0.05:
                    continue
                unit_id = uid("unit", building, str(n), key, str(i))
                units.append(
                    {
                        "id": unit_id,
                        "type": "Feature",
                        "feature_type": "unit",
                        "geometry": geo_geometry(g),
                        "properties": {
                            "category": category,
                            "restriction": None,
                            "accessibility": None,
                            "name": name,
                            "alt_name": alt,
                            "level_id": level_id,
                            "display_point": geo_point(g) if point else None,
                            "dotto": {"floor": label, **dotto},
                        },
                    }
                )
                if dotto["kind"] in ("stair", "elevator"):
                    vertical.append((dotto["kind"], building, n, unit_id, g))

        for fid, m, geom in rooms:
            category, kind, restroom = CATEGORIES[m["category"]]
            dotto: dict = {"kind": kind, "sourceId": fid}
            if kind not in ("stair", "elevator"):
                dotto["border"] = {"outline": 1}
            for cand in room_id_candidates(m, building):
                if (label, cand) in old_rooms:
                    old = old_rooms[(label, cand)]
                    used_room_ids.add((label, cand))
                    dotto["roomId"] = cand
                    if old.get("kind") == "classroom" and kind == "otherRoom":
                        dotto["kind"] = "classroom"
                    if "equipment" in old:
                        dotto["equipment"] = old["equipment"]
                    break
            if (
                "roomId" not in dotto
                and dotto["kind"] in ("classroom", "facultyRoom", "otherRoom")
                and not m.get("suppress_label")
            ):
                dotto["label"] = m["name_japanese"]
            if restroom:
                dotto["restroomTypes"] = restroom
            if m.get("note"):
                dotto["description"] = m["note"]
            names = {"ja": m["name_japanese"]}
            if m.get("name_english"):
                names["en"] = m["name_english"]
            add_unit(fid, geom, category, dotto, name=names)

        occupied = unary_union([g for *_, g in rooms] + voids)
        add_unit(
            "void",
            unary_union(voids).intersection(floor_shape),
            "opentobelow",
            {"kind": "atrium"},
            point=False,
        )
        add_unit(
            "walkway",
            floor_shape.difference(occupied),
            "walkway",
            {"kind": "aisle"},
            point=False,
        )

    # 縦の移動 (同じ棟の隣り合う階で重なる階段・エレベーター)
    relationships = []
    for kind in ("stair", "elevator"):
        items = [v for v in vertical if v[0] == kind]
        if kind == "elevator":
            groups: list[list] = []
            for v in sorted(items, key=lambda v: (v[1], v[2])):
                for g in groups:
                    last = g[-1]
                    if (
                        last[1] == v[1]
                        and last[2] == v[2] - 1
                        and last[4].centroid.distance(v[4].centroid) < 2.0
                    ):
                        g.append(v)
                        break
                else:
                    groups.append([v])
            pairs = [g for g in groups if len(g) > 1]
        else:
            pairs = []
            for a in items:
                for b in items:
                    if (
                        a[1] == b[1]
                        and b[2] == a[2] + 1
                        and a[4].intersection(b[4]).area > 0.3 * min(a[4].area, b[4].area)
                    ):
                        pairs.append([a, b])
        for g in pairs:
            ids = [v[3] for v in g]
            relationships.append(
                {
                    "id": uid("relationship", *ids),
                    "type": "Feature",
                    "feature_type": "relationship",
                    "geometry": None,
                    "properties": {
                        "category": "elevator" if kind == "elevator" else "stairs",
                        "direction": "undirected",
                        "origin": None,
                        "intermediary": [
                            {"id": i, "feature_type": "unit"} for i in ids
                        ],
                        "destination": None,
                        "hours": None,
                    },
                }
            )

    def write(name: str, features: list) -> None:
        text = json.dumps(
            {"type": "FeatureCollection", "features": features},
            ensure_ascii=False,
            indent=2,
        )
        (IMDF / f"{name}.geojson").write_text(text + "\n")

    write("level", levels)
    write("unit", units)
    write("relationship", relationships)
    manifest = json.loads((IMDF / "manifest.json").read_text())
    manifest["created"] = datetime.datetime.now(datetime.UTC).strftime(
        "%Y-%m-%dT%H:%M:%SZ"
    )
    manifest["generated_by"] = "scripts/convert_campus_guide_to_imdf.py"
    (IMDF / "manifest.json").write_text(
        json.dumps(manifest, ensure_ascii=False, indent=2) + "\n"
    )

    missing = sorted(set(old_rooms) - used_room_ids)
    print(
        f"levels {len(levels)}, units {len(units)}, "
        f"relationships {len(relationships)}",
        file=sys.stderr,
    )
    print(f"旧 IMDF にあって対応が見つからない roomId: {missing}", file=sys.stderr)


if __name__ == "__main__":
    main(Path(sys.argv[1]))
