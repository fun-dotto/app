import 'package:dotto/data/campus_map_data_source.dart';
import 'package:dotto/domain/entity/campus_map.dart';
import 'package:dotto/domain/entity/campus_map_unit.dart';
import 'package:dotto/domain/entity/domain_error.dart';
import 'package:dotto/domain/entity/floor.dart';
import 'package:dotto/domain/entity/geo_coordinate.dart';
import 'package:dotto/domain/entity/geo_polygon.dart';
import 'package:dotto/domain/entity/restroom_type.dart';
import 'package:dotto/domain/entity/room_equipment.dart';
import 'package:dotto/domain/repository/campus_map_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'campus_map_repository_impl.g.dart';

@riverpod
CampusMapRepository campusMapRepository(Ref ref) =>
    CampusMapRepositoryImpl(ref.watch(campusMapDataSourceProvider));

typedef _Json = Map<String, Object?>;

/// IMDF からキャンパスマップを組み立てる。
///
/// unit の `dotto` プロパティはアプリ固有の以下の情報を持つ。
/// - `floor`: 階 ([Floor.label])
/// - `kind`: 区画の種類 ([CampusMapUnitKind] の名前)
/// - `roomId`, `label`: 部屋 ID と表示名 (任意)
/// - `border`: `top` / `right` / `bottom` / `left` / `outline` の枠線の太さ (任意)
/// - `equipment`: `food` / `drink` / `outlet` の設備状況 (任意)
/// - `restroomTypes`: トイレの種類の配列 (任意)
/// - `sourceId`: 元データ (campus-guide) の区画 ID (アプリでは使わない)
///
/// IMDF は `scripts/convert_campus_guide_to_imdf.py` で生成する。
final class CampusMapRepositoryImpl implements CampusMapRepository {
  const new(this._dataSource);
  final CampusMapDataSource _dataSource;

  @override
  Future<CampusMap> getCampusMap() async {
    final [footprint, level, unit] = await Future.wait([
      _dataSource.fetchFeatureCollection('footprint'),
      _dataSource.fetchFeatureCollection('level'),
      _dataSource.fetchFeatureCollection('unit'),
    ]);
    try {
      final levels = {
        for (final feature in _features(level))
          feature['id']! as String: _polygon(feature),
      };
      final units = [for (final feature in _features(unit)) _unit(feature)];
      final floors = <Floor, GeoPolygon>{};
      for (final (i, feature) in _features(unit).indexed) {
        final levelId = _properties(feature)['level_id']! as String;
        floors[units[i].floor] ??= levels[levelId] ?? (throw _invalid());
      }
      return CampusMap(
        buildings: [
          for (final feature in _features(footprint)) _polygon(feature),
        ],
        floors: Map.unmodifiable(floors),
        units: List.unmodifiable(units),
      );
    } on DomainError {
      rethrow;
    } on Object {
      throw _invalid();
    }
  }

  Iterable<_Json> _features(_Json collection) =>
      (collection['features']! as List).cast<_Json>();

  _Json _properties(_Json feature) => feature['properties']! as _Json;

  GeoPolygon _polygon(_Json feature) {
    final geometry = feature['geometry']! as _Json;
    if (geometry['type'] != 'Polygon') throw _invalid();
    return GeoPolygon(
      rings: List.unmodifiable([
        for (final ring in geometry['coordinates']! as List)
          List<GeoCoordinate>.unmodifiable([
            for (final p in (ring as List).cast<List<Object?>>())
              GeoCoordinate(
                longitude: (p[0]! as num).toDouble(),
                latitude: (p[1]! as num).toDouble(),
              ),
          ]),
      ]),
    );
  }

  CampusMapUnit _unit(_Json feature) {
    final p = _properties(feature)['dotto']! as _Json;
    final floorLabel = p['floor'];
    final border = (p['border'] as _Json?) ?? const {};
    return CampusMapUnit(
      id: feature['id']! as String,
      floor: Floor.values.firstWhere(
        (e) => e.label == floorLabel,
        orElse: () => throw _invalid(),
      ),
      kind: CampusMapUnitKind.values.byName(p['kind']! as String),
      polygon: _polygon(feature),
      hasBorder: border.values.any((e) => e is num && e > 0),
      roomId: p['roomId'] as String?,
      label: p['label'] as String?,
      equipment: _equipment(p['equipment']),
      restroomTypes: List.unmodifiable([
        for (final name in (p['restroomTypes'] as List?) ?? const <Object?>[])
          RestroomType.values.byName(name! as String),
      ]),
    );
  }

  RoomEquipment? _equipment(Object? json) {
    if (json is! _Json) return null;
    RoomEquipmentQuality quality(String key) =>
        RoomEquipmentQuality.values.asNameMap()[json[key]] ??
        RoomEquipmentQuality.unknown;
    return RoomEquipment(
      food: quality('food'),
      drink: quality('drink'),
      outlet: quality('outlet'),
    );
  }

  DomainError _invalid() => const DomainError(
    type: DomainErrorType.invalidResponse,
    message: 'Invalid campus map',
  );
}
