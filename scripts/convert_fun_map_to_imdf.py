"""fun_map.geojson (グリッド座標) を IMDF 1.0.0 に変換する。

本部棟 (1-5F) と研究棟 (R6, R7) は別の建物で、グリッドの向きも異なる。
各建物のグリッドの外接矩形を、実測ポリゴン (WGS84) から求めた建物の外接矩形に
アフィン変換で対応付ける。細かい凹凸は既存のグリッドに従う。

usage: python3 scripts/convert_fun_map_to_imdf.py <fun_map.geojson> <out_dir>
"""

import datetime
import json
import math
import os
import sys
import uuid
import zipfile

# キャンパスの外形 (緯度, 経度)。東側が本部棟、西側が研究棟で、細い通路で繋がる。
OUTLINE = [
    (41.8424685, 140.7672426), (41.8426205, 140.7668102), (41.8421250, 140.7664964),
    (41.8421495, 140.7664268), (41.8424079, 140.7665904), (41.8425060, 140.7663115),
    (41.8421555, 140.7660895), (41.8422926, 140.7656994), (41.8418972, 140.7654489),
    (41.8416985, 140.7660140), (41.8419995, 140.7662046), (41.8419642, 140.7663049),
    (41.8421213, 140.7664045), (41.8420976, 140.7664719), (41.8415749, 140.7661408),
    (41.8412598, 140.7670369), (41.8411813, 140.7672602), (41.8412900, 140.7673290),
    (41.8412563, 140.7674250), (41.8412891, 140.7674458), (41.8413219, 140.7673526),
    (41.8415955, 140.7675259), (41.8415609, 140.7676244), (41.8415937, 140.7676451),
    (41.8416279, 140.7675476), (41.8418350, 140.7676788), (41.8418153, 140.7677346),
    (41.8418503, 140.7677568), (41.8418695, 140.7677021), (41.8420753, 140.7678325),
    (41.8420380, 140.7679387), (41.8420704, 140.7679592), (41.8421071, 140.7678547),
    (41.8421264, 140.7678670), (41.8423682, 140.7671791), (41.8424685, 140.7672426),
]
MAIN_OUTLINE = [0, 1, 2, *range(13, 35)]  # 本部棟 (OUTLINE の添字)
LAB_OUTLINE = list(range(3, 13))  # 研究棟

LAT0, LON0 = OUTLINE[0]
EARTH_R = 6378137.0
COS0 = math.cos(math.radians(LAT0))


def to_enu(lat, lon):
    return (math.radians(lon - LON0) * EARTH_R * COS0, math.radians(lat - LAT0) * EARTH_R)


def to_lonlat(e, n):
    return (
        round(LON0 + math.degrees(e / (EARTH_R * COS0)), 8),
        round(LAT0 + math.degrees(n / EARTH_R), 8),
    )


# 建物の軸: 外形の辺の向きの平均 (u は北北東、v は東南東)
def _axis_angle():
    pts = [to_enu(*p) for p in OUTLINE]
    s = c = 0.0
    for (x1, y1), (x2, y2) in zip(pts, pts[1:]):
        a = math.atan2(y2 - y1, x2 - x1) * 4  # 90 度ごとの向きを同一視
        w = math.hypot(x2 - x1, y2 - y1)
        s += math.sin(a) * w
        c += math.cos(a) * w
    return math.atan2(s, c) / 4


THETA = _axis_angle()
if THETA < 0:
    THETA += math.pi / 2  # u 軸を北東寄りに
U = (math.cos(THETA), math.sin(THETA))
V = (math.cos(THETA - math.pi / 2), math.sin(THETA - math.pi / 2))


def to_uv(e, n):
    return (e * U[0] + n * U[1], e * V[0] + n * V[1])


def from_uv(u, v):
    return (u * U[0] + v * V[0], u * U[1] + v * V[1])


UV = [to_uv(*to_enu(*p)) for p in OUTLINE]


def extent(indices):
    us = [UV[i][0] for i in indices]
    vs = [UV[i][1] for i in indices]
    return min(us), max(us), min(vs), max(vs)


class Building:
    def __init__(self, key, name, floors, outline, grid_to_uv):
        self.key = key
        self.name = name
        self.floors = floors
        self.outline = outline
        self.grid_to_uv = grid_to_uv
        self.id = uid("building", key)

    def lonlat(self, x, y):
        return to_lonlat(*from_uv(*self.grid_to_uv(x, y)))


def main_grid_to_uv():
    # x: 西 (通路側) → 東、y: 北北東 → 南南西
    umin, umax, vmin, _ = extent(MAIN_OUTLINE)
    vmax = UV[29][1]  # 東側の外壁 (外側の小さな出っ張りは除く)
    return lambda x, y: (umax - (umax - umin) * y / 63, vmin + (vmax - vmin) * x / 48)


LAB_ROTATION = int(os.environ.get("LAB_ROTATION", "0"))


def lab_grid_to_uv(rotation=None):
    """研究棟のグリッドを外接矩形に対応付ける。rotation は 90 度単位の回転。"""
    r = LAB_ROTATION if rotation is None else rotation
    umin, umax, vmin, vmax = extent(LAB_OUTLINE)
    lu = lambda t: umin + (umax - umin) * t  # noqa: E731
    lv = lambda t: vmin + (vmax - vmin) * t  # noqa: E731
    return {
        # x: 南南西 → 北北東、y: 西 → 東 (通路側)
        0: lambda x, y: (lu(x / 48), lv(y / 30)),
        # x: 西 → 東、y: 北北東 → 南南西 (本部棟と同じ向き)
        1: lambda x, y: (lu(1 - y / 30), lv(x / 48)),
        2: lambda x, y: (lu(1 - x / 48), lv(1 - y / 30)),
        3: lambda x, y: (lu(y / 30), lv(1 - x / 48)),
    }[r]


NS = uuid.UUID("6f1d3c3e-5a2b-4c1e-9a3d-2f6b8e0d1a77")


def uid(*parts):
    return str(uuid.uuid5(NS, "/".join(map(str, parts))))


def ring(points):
    pts = list(points)
    if pts[0] != pts[-1]:
        pts.append(pts[0])
    return pts


def polygon(points):
    return {"type": "Polygon", "coordinates": [ring(points)]}


def point(lonlat):
    return {"type": "Point", "coordinates": list(lonlat)}


def label(text):
    return {"ja": text} if text else None


def unit_category(p):
    kind = p["kind"]
    if kind == "restroom":
        types = set(p.get("restroomTypes", []))
        if types == {"kitchenette"}:
            return "kitchen"
        gender = types & {"men", "women"}
        wheel = "multipurpose" in types
        if gender == {"men"}:
            return "restroom.male.wheelchair" if wheel else "restroom.male"
        if gender == {"women"}:
            return "restroom.female.wheelchair" if wheel else "restroom.female"
        if not gender and wheel:
            return "restroom.unisex.wheelchair"
        return "restroom"
    return {
        "classroom": "classroom",
        "facultyRoom": "office",
        "subRoom": "room",
        "otherRoom": "room",
        "stair": "stairs",
        "elevator": "elevator",
        "aisle": "walkway",
        "atrium": "opentobelow",
    }[kind]


def label_anchor(ring_xy):
    """map_tile_props.dart の labelAnchor と同じ: 外接矩形の中心、
    矩形でなければ中心に最も近い内部セルの中心。"""
    xs = [p[0] for p in ring_xy]
    ys = [p[1] for p in ring_xy]
    cx, cy = (min(xs) + max(xs)) / 2, (min(ys) + max(ys)) / 2
    if len(set(map(tuple, ring_xy))) == 4:
        return cx, cy

    def inside(px, py):
        hit = False
        for (x1, y1), (x2, y2) in zip(ring_xy, ring_xy[1:]):
            if (y1 > py) != (y2 > py) and px < x1 + (py - y1) * (x2 - x1) / (y2 - y1):
                hit = not hit
        return hit

    cells = [
        (x + 0.5, y + 0.5)
        for x in range(int(min(xs)), int(max(xs)))
        for y in range(int(min(ys)), int(max(ys)))
        if inside(x + 0.5, y + 0.5)
    ]
    return min(cells, key=lambda c: (c[0] - cx) ** 2 + (c[1] - cy) ** 2)


def feature(fid, ftype, geometry, props):
    return {"id": fid, "type": "Feature", "feature_type": ftype, "geometry": geometry, "properties": props}


def collection(features):
    return {"type": "FeatureCollection", "features": features}


def convert(src):
    buildings = [
        Building("main", "本部棟", ["1", "2", "3", "4", "5"], MAIN_OUTLINE, main_grid_to_uv()),
        Building("lab", "研究棟", ["R6", "R7"], LAB_OUTLINE, lab_grid_to_uv()),
    ]
    by_floor = {f: b for b in buildings for f in b.floors}
    # 研究棟の R6, R7 は本部棟の 1F, 2F と同じ高さ
    ordinals = {"1": 0, "2": 1, "3": 2, "4": 3, "5": 4, "R6": 0, "R7": 1}

    address_id = uid("address", "fun")
    venue_id = uid("venue", "fun")
    outline_ll = [(lon, lat) for lat, lon in OUTLINE]
    c = to_lonlat(*from_uv(*[sum(v) / len(UV) for v in zip(*UV)]))

    out = {
        "address": [feature(address_id, "address", None, {
            "address": "亀田中野町116番地2", "unit": None, "locality": "函館市",
            "province": "JP-01", "country": "JP", "postal_code": "041-8655",
            "postal_code_ext": None, "postal_code_vanity": None,
        })],
        "venue": [feature(venue_id, "venue", polygon(outline_ll), {
            "category": "university", "restriction": None,
            "name": {"ja": "公立はこだて未来大学", "en": "Future University Hakodate"},
            "alt_name": None, "hours": None, "phone": None,
            "website": "https://www.fun.ac.jp/", "display_point": point(c),
            "address_id": address_id,
        })],
        "building": [], "footprint": [], "level": [], "unit": [], "relationship": [],
    }

    for b in buildings:
        pts = [outline_ll[i] for i in b.outline]
        out["building"].append(feature(b.id, "building", None, {
            "name": label(b.name), "alt_name": None, "category": "unspecified",
            "restriction": None, "display_point": None, "address_id": address_id,
        }))
        out["footprint"].append(feature(uid("footprint", b.key), "footprint", polygon(pts), {
            "category": "ground", "name": None, "building_ids": [b.id],
        }))

    with open(src, encoding="utf-8") as f:
        features = json.load(f)["features"]

    units = {}  # id(tile) -> unit id
    for floor, b in by_floor.items():
        tiles = [f for f in features if f["properties"]["floor"] == floor]
        xs = [x for t in tiles for x, _ in t["geometry"]["coordinates"][0]]
        ys = [y for t in tiles for _, y in t["geometry"]["coordinates"][0]]
        x0, x1, y0, y1 = min(xs), max(xs), min(ys), max(ys)
        level_id = uid("level", floor)
        name = f"{floor[1:]}F" if floor.startswith("R") else f"{floor}F"
        out["level"].append(feature(level_id, "level", polygon(
            [b.lonlat(x0, y0), b.lonlat(x1, y0), b.lonlat(x1, y1), b.lonlat(x0, y1)]
        ), {
            "category": "unspecified", "restriction": None, "outdoor": False,
            "ordinal": ordinals[floor],
            "name": label(f"{b.name} {name}"), "short_name": label(name),
            "display_point": point(b.lonlat((x0 + x1) / 2, (y0 + y1) / 2)),
            "address_id": None, "building_ids": [b.id],
        }))
        for t in tiles:
            p = t["properties"]
            r = t["geometry"]["coordinates"][0]
            key = p.get("roomId") or f"{r[0][0]},{r[0][1]}"
            units[id(t)] = uid("unit", floor, p["kind"], key)
            out["unit"].append(feature(units[id(t)], "unit", polygon(
                [b.lonlat(x, y) for x, y in r]
            ), {
                "category": unit_category(p), "restriction": None, "accessibility": None,
                "name": label(p.get("label")), "alt_name": None, "level_id": level_id,
                "display_point": point(b.lonlat(*label_anchor(r))) if p.get("label") else None,
            }))
    out["relationship"] = relationships(buildings, features, units)
    return out


def rect(tile):
    r = tile["geometry"]["coordinates"][0]
    xs = [x for x, _ in r]
    ys = [y for _, y in r]
    return min(xs), min(ys), max(xs), max(ys)


def overlaps(a, b):
    return a[0] < b[2] and b[0] < a[2] and a[1] < b[3] and b[1] < a[3]


def relationships(buildings, features, units):
    """階段は上下の階で重なる段同士 (下の階が up、上の階が down か同じ位置) を、
    エレベーターは同じ位置で連続する階をまとめて 1 つのシャフトとして結ぶ。"""
    def ref(t):
        return {"id": units[id(t)], "feature_type": "unit"}

    def rel(category, tiles):
        return feature(uid("relationship", category, *(units[id(t)] for t in tiles)), "relationship", None, {
            "category": category, "direction": "undirected", "origin": None,
            "intermediary": [ref(t) for t in tiles], "destination": None, "hours": None,
        })

    out = []
    for b in buildings:
        of = {f: [t for t in features if t["properties"]["floor"] == f] for f in b.floors}
        for lower, upper in zip(b.floors, b.floors[1:]):
            for s in of[lower]:
                if s["properties"]["kind"] != "stair" or not s["properties"]["stair"]["up"]:
                    continue
                for t in of[upper]:
                    # 途中階の段は up しか付いていないことがあるので、同じ位置なら繋がっているとみなす
                    if t["properties"]["kind"] == "stair" and (
                        rect(s) == rect(t) or t["properties"]["stair"]["down"] and overlaps(rect(s), rect(t))
                    ):
                        out.append(rel("stairs", [s, t]))
        shafts = []
        for f in b.floors:
            for e in (t for t in of[f] if t["properties"]["kind"] == "elevator"):
                shaft = next((sh for sh in shafts if rect(sh[-1]) == rect(e)
                              and b.floors.index(sh[-1]["properties"]["floor"]) == b.floors.index(f) - 1), None)
                if shaft:
                    shaft.append(e)
                else:
                    shafts.append([e])
        out += [rel("elevator", sh) for sh in shafts if len(sh) > 1]
    return out


def main():
    src, out_dir = sys.argv[1], sys.argv[2]
    data = convert(src)
    os.makedirs(out_dir, exist_ok=True)
    manifest = {
        "version": "1.0.0",
        "created": datetime.datetime.now(datetime.timezone.utc).strftime("%Y-%m-%dT%H:%M:%SZ"),
        "generated_by": "scripts/convert_fun_map_to_imdf.py",
        "language": "ja",
        "extensions": None,
    }
    files = {"manifest.json": manifest}
    files.update({f"{k}.geojson": collection(v) for k, v in data.items()})
    with zipfile.ZipFile(os.path.join(out_dir, "imdf.zip"), "w", zipfile.ZIP_DEFLATED) as z:
        for name, obj in files.items():
            text = json.dumps(obj, ensure_ascii=False, indent=2) + "\n"
            with open(os.path.join(out_dir, name), "w", encoding="utf-8") as f:
                f.write(text)
            z.writestr(name, text)
    for k, v in data.items():
        print(f"{k}: {len(v)}")


if __name__ == "__main__":
    main()
