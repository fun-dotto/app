import 'dart:convert';
import 'dart:math' as math;

import 'package:dotto/domain/entity/floor.dart';
import 'package:dotto/presentation/map/fun_map.dart';
import 'package:dotto/presentation/map/geo_json.dart';
import 'package:dotto/presentation/map/map_tile_props.dart';
import 'package:flutter/services.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'imdf.g.dart';

/// キャンパスマップの IMDF (経度・緯度)。
///
/// 描画に使う footprint / level / unit だけを読み込む。unit の `dotto`
/// プロパティにはアプリ固有の情報 (部屋 ID・設備・グリッド上の形など) を持つ。
final class Imdf {
  const new({
    required this.footprints,
    required this.levels,
    required this.units,
    required this.funMap,
    required this._unitIds,
    required this._levelIds,
  });

  factory fromJson({
    required Map<String, Object?> footprint,
    required Map<String, Object?> level,
    required Map<String, Object?> unit,
  }) {
    Map<String, Map<String, Object?>> byId(Map<String, Object?> collection) => {
      for (final f
          in (collection['features']! as List).cast<Map<String, Object?>>())
        f['id']! as String: f,
    };
    final units = byId(unit);
    final unitIds = Map<MapTileProps, String>.identity();
    final levelIds = <Floor, String>{};
    for (final MapEntry(key: id, value: feature) in units.entries) {
      final properties = feature['properties']! as Map<String, Object?>;
      final dotto = Map<String, Object?>.of(
        properties['dotto']! as Map<String, Object?>,
      );
      final grid = dotto.remove('grid')! as Map<String, Object?>;
      final tile = mapTilePropsFromGeoJsonFeature(
        GeoJsonFeature(
          geometry: GeoJsonGeometry.fromJson(grid),
          properties: dotto,
        ),
      );
      unitIds[tile] = id;
      levelIds[tile.floor] = properties['level_id']! as String;
    }
    return Imdf(
      footprints: footprint,
      levels: byId(level),
      units: units,
      funMap: FUNMap(tileProps: List.unmodifiable(unitIds.keys)),
      unitIds: unitIds,
      levelIds: levelIds,
    );
  }

  /// 建物の外形の FeatureCollection。
  final Map<String, Object?> footprints;

  /// level の Feature (ID ごと)。
  final Map<String, Map<String, Object?>> levels;

  /// unit の Feature (ID ごと)。
  final Map<String, Map<String, Object?>> units;

  /// unit から復元したタイル。
  final FUNMap funMap;

  final Map<MapTileProps, String> _unitIds;
  final Map<Floor, String> _levelIds;

  /// [tile] に対応する unit の Feature。
  Map<String, Object?>? unitOf(MapTileProps tile) => units[_unitIds[tile]];

  /// [floor] の level の ID。
  String? levelIdOf(Floor floor) => _levelIds[floor];

  /// [floor] の level の外形。
  List<ImdfPosition> levelOutline(Floor floor) {
    final geometry =
        levels[_levelIds[floor]]?['geometry'] as Map<String, Object?>?;
    if (geometry == null) return const [];
    return imdfRing(geometry);
  }
}

/// JSON オブジェクト。
typedef Json = Map<String, Object?>;

typedef ImdfPosition = ({double lng, double lat});

/// Polygon の外周。
List<ImdfPosition> imdfRing(Map<String, Object?> polygon) {
  final rings = polygon['coordinates']! as List;
  return [
    for (final p in (rings.first as List).cast<List<Object?>>())
      (lng: (p[0]! as num).toDouble(), lat: (p[1]! as num).toDouble()),
  ];
}

/// 建物の軸の向き (北から時計回りの角度)。
///
/// グリッドの上方向がこの向きになるように地図を回転して表示する。
const imdfBuildingBearing = 25.3;

/// [positions] を [bearing] だけ回転した画面上で囲む範囲 (メートル)。
({ImdfPosition center, double width, double height}) imdfExtent(
  List<ImdfPosition> positions, {
  double bearing = imdfBuildingBearing,
}) {
  const earthRadius = 6378137.0;
  final lat0 = positions.first.lat;
  final lng0 = positions.first.lng;
  final cosLat = math.cos(lat0 * math.pi / 180);
  final theta = bearing * math.pi / 180;
  var minX = double.infinity;
  var minY = double.infinity;
  var maxX = double.negativeInfinity;
  var maxY = double.negativeInfinity;
  for (final p in positions) {
    final e = (p.lng - lng0) * math.pi / 180 * earthRadius * cosLat;
    final n = (p.lat - lat0) * math.pi / 180 * earthRadius;
    // 画面の右 (x) と上 (y) の向きに射影する。
    final x = e * math.cos(theta) - n * math.sin(theta);
    final y = e * math.sin(theta) + n * math.cos(theta);
    minX = math.min(minX, x);
    maxX = math.max(maxX, x);
    minY = math.min(minY, y);
    maxY = math.max(maxY, y);
  }
  final cx = (minX + maxX) / 2;
  final cy = (minY + maxY) / 2;
  final e = cx * math.cos(theta) + cy * math.sin(theta);
  final n = -cx * math.sin(theta) + cy * math.cos(theta);
  return (
    center: (
      lng: lng0 + e / (earthRadius * cosLat) * 180 / math.pi,
      lat: lat0 + n / earthRadius * 180 / math.pi,
    ),
    width: maxX - minX,
    height: maxY - minY,
  );
}

@Riverpod(keepAlive: true)
Future<Imdf> imdf(Ref ref) async {
  Future<Map<String, Object?>> load(String name) async =>
      jsonDecode(await rootBundle.loadString('assets/map/imdf/$name.geojson'))
          as Map<String, Object?>;
  return Imdf.fromJson(
    footprint: await load('footprint'),
    level: await load('level'),
    unit: await load('unit'),
  );
}
