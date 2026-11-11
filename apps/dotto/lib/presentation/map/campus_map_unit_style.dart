import 'package:dotto/domain/entity/campus_map_unit.dart';
import 'package:dotto/domain/entity/room_equipment.dart';
import 'package:dotto_design_system/style/map_colors.dart';
import 'package:material_ui/material_ui.dart';

/// 区画の種類ごとの配色。
extension CampusMapUnitKindStyle on CampusMapUnitKind {
  Color get backgroundColor => switch (this) {
    CampusMapUnitKind.classroom => MapColors.classroomTile,
    CampusMapUnitKind.facultyRoom => MapColors.facultyRoomTile,
    CampusMapUnitKind.subRoom => MapColors.subRoomTile,
    CampusMapUnitKind.otherRoom => MapColors.otherRoomTile,
    CampusMapUnitKind.restroom => MapColors.restroomTile,
    CampusMapUnitKind.stair => MapColors.stairTile,
    CampusMapUnitKind.elevator => MapColors.elevatorTile,
    CampusMapUnitKind.aisle => MapColors.aisleTile,
    CampusMapUnitKind.atrium => MapColors.transparent,
  };

  Color get foregroundColor => switch (this) {
    CampusMapUnitKind.classroom ||
    CampusMapUnitKind.facultyRoom ||
    CampusMapUnitKind.elevator => MapColors.invertedForeground,
    _ => MapColors.foreground,
  };
}

/// 区画に部屋名などがない場合に表示する記号。
extension CampusMapUnitSymbol on CampusMapUnit {
  String? get symbol => switch (kind) {
    CampusMapUnitKind.elevator => 'EV',
    CampusMapUnitKind.restroom when restroomTypes.isNotEmpty => 'WC',
    _ => null,
  };
}

extension RoomEquipmentQualityIcon on RoomEquipmentQuality {
  IconData get icon => switch (this) {
    RoomEquipmentQuality.unknown => Icons.help_outline,
    RoomEquipmentQuality.unavailable => Icons.close_outlined,
    RoomEquipmentQuality.limited => Icons.change_history_outlined,
    RoomEquipmentQuality.available => Icons.circle_outlined,
  };
}
