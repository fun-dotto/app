import 'package:dotto/domain/entity/campus_map_unit.dart';
import 'package:dotto/domain/entity/floor.dart';
import 'package:dotto/domain/entity/geo_polygon.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'campus_map.freezed.dart';

/// キャンパスの建物と各階の区画。
@freezed
abstract class CampusMap with _$CampusMap {
  const factory({
    /// 建物の外形。
    required List<GeoPolygon> buildings,

    /// 各階の外形。
    required Map<Floor, GeoPolygon> floors,
    required List<CampusMapUnit> units,
  }) = _CampusMap;

  const new _();

  /// [floor] の区画。
  Iterable<CampusMapUnit> unitsOf(Floor floor) =>
      units.where((e) => e.floor == floor);

  /// [roomId] の部屋の区画。
  CampusMapUnit? unitOfRoom(String roomId) {
    for (final unit in units) {
      if (unit.roomId == roomId) return unit;
    }
    return null;
  }
}
