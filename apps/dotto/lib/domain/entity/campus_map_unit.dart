import 'package:dotto/domain/entity/floor.dart';
import 'package:dotto/domain/entity/geo_polygon.dart';
import 'package:dotto/domain/entity/restroom_type.dart';
import 'package:dotto/domain/entity/room_equipment.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'campus_map_unit.freezed.dart';

/// キャンパスマップの区画の種類。
enum CampusMapUnitKind {
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

/// キャンパスマップの 1 つの区画 (部屋・通路・階段など)。
@freezed
abstract class CampusMapUnit with _$CampusMapUnit {
  const factory({
    required String id,
    required Floor floor,
    required CampusMapUnitKind kind,
    required GeoPolygon polygon,

    /// 区画を囲む壁を強調して描画するか。
    required bool hasBorder,
    String? roomId,
    String? label,
    RoomEquipment? equipment,
    @Default(<RestroomType>[]) List<RestroomType> restroomTypes,
  }) = _CampusMapUnit;
}
