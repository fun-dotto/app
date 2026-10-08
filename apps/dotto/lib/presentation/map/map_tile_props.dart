import 'package:dotto/domain/entity/floor.dart';
import 'package:dotto/presentation/map/map_stair_type.dart';
import 'package:dotto/presentation/map/restroom_type.dart';
import 'package:dotto/presentation/map/room_equipment.dart';
import 'package:dotto_design_system/style/map_colors.dart';
import 'package:material_ui/material_ui.dart';

abstract class MapTileProps {
  new({
    required this.floor,
    required this.width,
    required this.height,
    required this.top,
    required this.right,
    required this.bottom,
    required this.left,
    this.id,
    this.label,
  });

  final Floor floor;

  final int width;
  final int height;
  final int top;
  final int right;
  final int bottom;
  final int left;

  final String? id;
  final String? label;

  Color get foregroundColor => MapColors.foreground;
  Color get backgroundColor => MapColors.transparent;
}

final class ClassroomMapTileProps extends MapTileProps {
  new({
    required super.floor,
    required super.width,
    required super.height,
    required super.top,
    required super.right,
    required super.bottom,
    required super.left,
    required this.equipment,
    required super.id,
    super.label,
  });

  final RoomEquipmentStatus equipment;

  @override
  Color get foregroundColor => MapColors.invertedForeground;
  @override
  Color get backgroundColor => MapColors.classroomTile;
}

final class FacultyRoomMapTileProps extends MapTileProps {
  new({
    required super.floor,
    required super.width,
    required super.height,
    required super.top,
    required super.right,
    required super.bottom,
    required super.left,
    required super.id,
    super.label,
  });

  @override
  Color get foregroundColor => MapColors.invertedForeground;
  @override
  Color get backgroundColor => MapColors.facultyRoomTile;
}

final class SubRoomMapTileProps extends MapTileProps {
  new({
    required super.floor,
    required super.width,
    required super.height,
    required super.top,
    required super.right,
    required super.bottom,
    required super.left,
    required super.id,
    super.label,
    this.equipment,
  });

  final RoomEquipmentStatus? equipment;

  @override
  Color get foregroundColor => MapColors.foreground;
  @override
  Color get backgroundColor => MapColors.subRoomTile;
}

final class OtherRoomMapTileProps extends MapTileProps {
  new({
    required super.floor,
    required super.width,
    required super.height,
    required super.top,
    required super.right,
    required super.bottom,
    required super.left,
    required super.id,
    super.label,
  });

  @override
  Color get foregroundColor => MapColors.foreground;
  @override
  Color get backgroundColor => MapColors.otherRoomTile;
}

final class RestroomMapTileProps extends MapTileProps {
  new({
    required super.floor,
    required super.width,
    required super.height,
    required super.top,
    required super.right,
    required super.bottom,
    required super.left,
    required this.types,
  });

  final List<RestroomType> types;

  @override
  Color get foregroundColor => MapColors.foreground;
  @override
  Color get backgroundColor => MapColors.restroomTile;
}

final class StairMapTileProps extends MapTileProps {
  new({
    required super.floor,
    required super.width,
    required super.height,
    required super.top,
    required super.right,
    required super.bottom,
    required super.left,
    required this.type,
  });

  final MapStairType type;

  @override
  Color get foregroundColor => MapColors.foreground;
  @override
  Color get backgroundColor => MapColors.stairTile;
}

final class ElevatorMapTileProps extends MapTileProps {
  new({
    required super.floor,
    required super.width,
    required super.height,
    required super.top,
    required super.right,
    required super.bottom,
    required super.left,
  });

  @override
  Color get foregroundColor => MapColors.invertedForeground;
  @override
  Color get backgroundColor => MapColors.elevatorTile;
}

final class AisleMapTileProps extends MapTileProps {
  new({
    required super.floor,
    required super.width,
    required super.height,
    required super.top,
    required super.right,
    required super.bottom,
    required super.left,
    super.label,
  });

  @override
  Color get foregroundColor => MapColors.foreground;
  @override
  Color get backgroundColor => MapColors.aisleTile;
}

final class AtriumMapTileProps extends MapTileProps {
  new({
    required super.floor,
    required super.width,
    required super.height,
    required super.top,
    required super.right,
    required super.bottom,
    required super.left,
  });

  @override
  Color get foregroundColor => MapColors.foreground;
  @override
  Color get backgroundColor => MapColors.transparent;
}
