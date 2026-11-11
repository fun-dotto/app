import 'package:dotto/domain/entity/floor.dart';
import 'package:dotto/presentation/map/geo_json.dart';
import 'package:dotto/presentation/map/imdf.dart';
import 'package:dotto/presentation/map/map_stair_type.dart';
import 'package:dotto/presentation/map/map_tile_props.dart';
import 'package:dotto/presentation/map/restroom_type.dart';
import 'package:dotto/presentation/map/room_equipment.dart';
import 'package:material_ui/material_ui.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'fun_map.g.dart';

/// IMDF の unit から復元したキャンパスマップのタイル。
///
/// unit の `dotto` プロパティは以下を持つ。
/// - `grid`: グリッド上の形 (GeoJSON の Polygon / MultiPolygon、原点左上・y 軸下向き)
/// - `floor`: 階 ([Floor.label])
/// - `kind`: タイルの種類 ([MapTileKind] の名前)
/// - `roomId`, `label`: 部屋 ID と表示名 (任意)
/// - `border`: `top` / `right` / `bottom` / `left` の枠線の太さ (任意)。
///   矩形以外の Polygon / MultiPolygon は `outline` で輪郭線の太さを指定する
/// - `equipment`: `food` / `drink` / `outlet` の設備状況 (任意)
/// - `restroomTypes`: トイレの種類の配列 (`kind` が `restroom` の場合)
/// - `stair`: `direction` / `up` / `down` (`kind` が `stair` の場合)
final class FUNMap {
  const new({required this.tileProps});

  final List<MapTileProps> tileProps;

  /// 指定した階のタイル。
  Iterable<MapTileProps> tilePropsOf(Floor floor) =>
      tileProps.where((e) => e.floor == floor);
}

@Riverpod(keepAlive: true)
Future<FUNMap> funMap(Ref ref) async =>
    (await ref.watch(imdfProvider.future)).funMap;

enum MapTileKind {
  classroom,
  facultyRoom,
  subRoom,
  otherRoom,
  restroom,
  stair,
  elevator,
  aisle,
  atrium,
}

MapTileProps mapTilePropsFromGeoJsonFeature(GeoJsonFeature feature) {
  final p = feature.properties;
  final bounds = feature.geometry.bounds;
  final floorLabel = p['floor'];
  final floor = Floor.values.firstWhere(
    (e) => e.label == floorLabel,
    orElse: () => throw FormatException('Unknown floor: $floorLabel'),
  );
  final border = (p['border'] as Map<String, Object?>?) ?? const {};
  final x = bounds.minX.round();
  final y = bounds.minY.round();
  final width = bounds.width.round();
  final height = bounds.height.round();
  final top = (border['top'] as int?) ?? 0;
  final right = (border['right'] as int?) ?? 0;
  final bottom = (border['bottom'] as int?) ?? 0;
  final left = (border['left'] as int?) ?? 0;
  final outline = (border['outline'] as int?) ?? 0;
  final shape = _shape(feature.geometry, bounds);
  final id = p['roomId'] as String?;
  final label = p['label'] as String?;
  final equipment = _equipment(p['equipment']);

  final kindName = p['kind'];
  final kind = MapTileKind.values.firstWhere(
    (e) => e.name == kindName,
    orElse: () => throw FormatException('Unknown kind: $kindName'),
  );
  return switch (kind) {
    MapTileKind.classroom => ClassroomMapTileProps(
      floor: floor,
      x: x,
      y: y,
      width: width,
      height: height,
      top: top,
      right: right,
      bottom: bottom,
      left: left,
      shape: shape,
      outline: outline,
      id: id,
      label: label,
      equipment:
          equipment ??
          (throw FormatException('Classroom $id has no equipment')),
    ),
    MapTileKind.facultyRoom => FacultyRoomMapTileProps(
      floor: floor,
      x: x,
      y: y,
      width: width,
      height: height,
      top: top,
      right: right,
      bottom: bottom,
      left: left,
      shape: shape,
      outline: outline,
      id: id,
      label: label,
    ),
    MapTileKind.subRoom => SubRoomMapTileProps(
      floor: floor,
      x: x,
      y: y,
      width: width,
      height: height,
      top: top,
      right: right,
      bottom: bottom,
      left: left,
      shape: shape,
      outline: outline,
      id: id,
      label: label,
      equipment: equipment,
    ),
    MapTileKind.otherRoom => OtherRoomMapTileProps(
      floor: floor,
      x: x,
      y: y,
      width: width,
      height: height,
      top: top,
      right: right,
      bottom: bottom,
      left: left,
      shape: shape,
      outline: outline,
      id: id,
      label: label,
    ),
    MapTileKind.restroom => RestroomMapTileProps(
      floor: floor,
      x: x,
      y: y,
      width: width,
      height: height,
      top: top,
      right: right,
      bottom: bottom,
      left: left,
      shape: shape,
      outline: outline,
      types: [
        for (final name
            in (p['restroomTypes'] as List<Object?>?) ?? const <Object?>[])
          RestroomType.values.byName(name! as String),
      ],
    ),
    MapTileKind.stair => StairMapTileProps(
      floor: floor,
      x: x,
      y: y,
      width: width,
      height: height,
      top: top,
      right: right,
      bottom: bottom,
      left: left,
      shape: shape,
      outline: outline,
      type: _stair(p['stair']),
    ),
    MapTileKind.elevator => ElevatorMapTileProps(
      floor: floor,
      x: x,
      y: y,
      width: width,
      height: height,
      top: top,
      right: right,
      bottom: bottom,
      left: left,
      shape: shape,
      outline: outline,
    ),
    MapTileKind.aisle => AisleMapTileProps(
      floor: floor,
      x: x,
      y: y,
      width: width,
      height: height,
      top: top,
      right: right,
      bottom: bottom,
      left: left,
      shape: shape,
      outline: outline,
      label: label,
    ),
    MapTileKind.atrium => AtriumMapTileProps(
      floor: floor,
      x: x,
      y: y,
      width: width,
      height: height,
      top: top,
      right: right,
      bottom: bottom,
      left: left,
      shape: shape,
      outline: outline,
    ),
  };
}

/// 外接矩形と一致しない形なら、外接矩形の左上を原点とした輪郭を返す。
List<List<Offset>>? _shape(GeoJsonGeometry geometry, GeoJsonBoundingBox b) {
  final rings = switch (geometry) {
    GeoJsonPolygon(:final rings) => rings,
    GeoJsonMultiPolygon(:final polygons) => [...polygons.expand((e) => e)],
    GeoJsonPoint() => const <List<GeoJsonPosition>>[],
  };
  if (rings.isEmpty) return null;
  bool isCorner(GeoJsonPosition p) =>
      (p.x == b.minX || p.x == b.maxX) && (p.y == b.minY || p.y == b.maxY);
  final isRectangle =
      rings.length == 1 &&
      rings.first.toSet().length == 4 &&
      rings.first.every(isCorner);
  if (isRectangle) return null;
  return [
    for (final ring in rings)
      [for (final p in ring) Offset(p.x - b.minX, p.y - b.minY)],
  ];
}

RoomEquipmentStatus? _equipment(Object? json) {
  if (json is! Map<String, Object?>) return null;
  RoomEquipmentQuality quality(String key) =>
      RoomEquipmentQuality.values.asNameMap()[json[key]] ??
      RoomEquipmentQuality.unknown;
  return RoomEquipmentStatus(
    food: RoomEquipmentFood(quality: quality('food')),
    drink: RoomEquipmentDrink(quality: quality('drink')),
    outlet: RoomEquipmentOutlet(quality: quality('outlet')),
  );
}

MapStairType _stair(Object? json) {
  final map = (json as Map<String, Object?>?) ?? const {};
  return MapStairType(
    map['direction'] == 'horizontal' ? Axis.horizontal : Axis.vertical,
    up: (map['up'] as bool?) ?? false,
    down: (map['down'] as bool?) ?? false,
  );
}
