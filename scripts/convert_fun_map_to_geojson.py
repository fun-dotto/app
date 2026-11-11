"""旧 `fun_map.dart` (StaggeredGrid 前提のタイル列) を GeoJSON に変換する一回限りのスクリプト。

StaggeredGrid.count (crossAxisCount=48) の配置アルゴリズムを再現して、
各タイルの絶対座標 (グリッド単位、原点は左上、y 軸は下向き) を求める。

usage: python3 scripts/convert_fun_map_to_geojson.py <fun_map.dart> <out.geojson>
"""

import json
import re
import sys

CROSS_AXIS_COUNT = 48

KINDS = {
    "ClassroomMapTileProps": "classroom",
    "FacultyRoomMapTileProps": "facultyRoom",
    "SubRoomMapTileProps": "subRoom",
    "OtherRoomMapTileProps": "otherRoom",
    "RestroomMapTileProps": "restroom",
    "StairMapTileProps": "stair",
    "ElevatorMapTileProps": "elevator",
    "AisleMapTileProps": "aisle",
    "AtriumMapTileProps": "atrium",
}
FLOORS = {
    "first": "1",
    "second": "2",
    "third": "3",
    "fourth": "4",
    "fifth": "5",
    "sixth": "R6",
    "seventh": "R7",
}


def parse_tiles(source):
    lines = source.splitlines()
    tiles = []
    comment = None
    i = 0
    while i < len(lines):
        line = lines[i].strip()
        m = re.match(r"^(\w+MapTileProps)\($", line)
        if line.startswith("///"):
            comment = None
        elif line.startswith("//"):
            comment = line[2:].strip()
        elif m:
            depth = 1
            body = []
            i += 1
            while depth > 0:
                text = lines[i]
                depth += text.count("(") - text.count(")")
                body.append(text)
                i += 1
            tiles.append(parse_body(m.group(1), "\n".join(body), comment))
            continue
        i += 1
    return tiles


def parse_body(cls, body, comment):
    def field(name):
        m = re.search(rf"^\s*{name}: (.+?),?$", body, re.M)
        return m.group(1) if m else None

    tile = {
        "class": cls,
        "floor": FLOORS[field("floor").split(".")[1]],
        **{k: int(field(k)) for k in ("width", "height", "top", "right", "bottom", "left")},
    }
    if (v := field("id")) and v != "null":
        tile["id"] = v.strip("'")
    if v := field("label"):
        tile["label"] = v.strip("'")
    if "equipment:" in body:
        tile["equipment"] = {
            k: re.search(rf"{k}: \w+\(quality: RoomEquipmentQuality\.(\w+)\)", body).group(1)
            for k in ("food", "drink", "outlet")
        }
    if v := field("types"):
        tile["types"] = re.findall(r"RestroomType\.(\w+)", v)
    if m := re.search(r"MapStairType\(Axis\.(\w+), up: (\w+), down: (\w+)\)", body):
        tile["stair"] = {
            "direction": m.group(1),
            "up": m.group(2) == "true",
            "down": m.group(3) == "true",
        }
    if comment:
        tile["comment"] = comment
    return tile


def find_best_candidate(offsets, span):
    """flutter_staggered_grid_view の `_findBestCandidate` と同じ処理。"""
    best_index, best_offset = 0, float("inf")
    n = len(offsets)
    for offset in offsets:
        if best_offset <= offset:
            continue
        start = 0
        count = 0
        j = 0
        while count < span and j < n and n - j >= span - count:
            if offsets[j] <= offset:
                count += 1
                if count == 1:
                    start = j
            else:
                start = 0
                count = 0
            j += 1
        if count == span:
            best_index, best_offset = start, offset
    return best_index, best_offset


def layout(tiles):
    offsets_by_floor = {}
    for tile in tiles:
        offsets = offsets_by_floor.setdefault(tile["floor"], [0] * CROSS_AXIS_COUNT)
        x, y = find_best_candidate(offsets, tile["width"])
        for c in range(x, x + tile["width"]):
            offsets[c] = y + tile["height"]
        tile["x"], tile["y"] = x, y


def to_feature(tile):
    x, y, w, h = tile["x"], tile["y"], tile["width"], tile["height"]
    props = {"floor": tile["floor"], "kind": KINDS[tile["class"]]}
    for key in ("id", "label", "comment", "equipment", "stair"):
        if key in tile:
            props[{"id": "roomId", "comment": "description"}.get(key, key)] = tile[key]
    if "types" in tile:
        props["restroomTypes"] = tile["types"]
    border = {k: tile[k] for k in ("top", "right", "bottom", "left") if tile[k]}
    if border:
        props["border"] = border
    return {
        "type": "Feature",
        "geometry": {
            "type": "Polygon",
            "coordinates": [[[x, y], [x + w, y], [x + w, y + h], [x, y + h], [x, y]]],
        },
        "properties": props,
    }


def dump(collection):
    """1 Feature 1 行で出力して差分を見やすくする。"""
    header = {k: v for k, v in collection.items() if k != "features"}
    lines = [json.dumps(f, ensure_ascii=False, separators=(",", ":")) for f in collection["features"]]
    head = json.dumps(header, ensure_ascii=False, indent=2)[:-2]
    return head + ',\n  "features": [\n    ' + ",\n    ".join(lines) + "\n  ]\n}\n"


def main():
    src, out = sys.argv[1], sys.argv[2]
    with open(src, encoding="utf-8") as f:
        tiles = parse_tiles(f.read())
    layout(tiles)
    collection = {
        "type": "FeatureCollection",
        "name": "fun_map",
        "crs": {"type": "name", "properties": {"name": "dotto:grid"}},
        "bbox": [0, 0, CROSS_AXIS_COUNT, max(t["y"] + t["height"] for t in tiles)],
        "features": [to_feature(t) for t in tiles],
    }
    with open(out, "w", encoding="utf-8") as f:
        f.write(dump(collection))
    print(f"{len(tiles)} features -> {out}")


if __name__ == "__main__":
    main()
