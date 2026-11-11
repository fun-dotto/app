import 'package:dotto/domain/entity/floor.dart';
import 'package:dotto/presentation/map/map_stair_type.dart';
import 'package:dotto/presentation/map/restroom_type.dart';
import 'package:dotto/presentation/map/room_equipment.dart';
import 'package:dotto_design_system/style/map_colors.dart';
import 'package:material_ui/material_ui.dart';

abstract class MapTileProps {
  new({
    required this.floor,
    required this.x,
    required this.y,
    required this.width,
    required this.height,
    required this.top,
    required this.right,
    required this.bottom,
    required this.left,
    this.shape,
    this.outline = 0,
    this.id,
    this.label,
  });

  final Floor floor;

  /// マップ座標系での左上の位置 (グリッド単位)。
  final int x;
  final int y;
  final int width;
  final int height;
  final int top;
  final int right;
  final int bottom;
  final int left;

  /// 矩形以外の形 (L 字など) のタイルの輪郭。
  ///
  /// 各要素が 1 つのリング (外周または穴) で、座標は [x], [y] を原点とした
  /// グリッド単位。`null` の場合は [width] x [height] の矩形として描画する。
  final List<List<Offset>>? shape;

  /// [shape] の輪郭線の太さ。矩形の場合は [top] などの各辺の太さを使う。
  final int outline;

  final String? id;
  final String? label;

  Color get foregroundColor => MapColors.foreground;
  Color get backgroundColor => MapColors.transparent;

  /// ラベルを置く位置 ([x], [y] を原点としたグリッド単位)。
  ///
  /// 矩形なら中心。L 字などの場合は、形の内側のマスのうち外接矩形の中心に
  /// 最も近いマスの中心を使う (中心が形の外や角に来ることがあるため)。
  Offset get labelAnchor {
    final center = Offset(width / 2, height / 2);
    if (shape == null) return center;
    Offset? best;
    for (var cx = 0; cx < width; cx++) {
      for (var cy = 0; cy < height; cy++) {
        if (!containsCell(x + cx, y + cy)) continue;
        final c = Offset(cx + 0.5, cy + 0.5);
        if (best == null || (c - center).distance < (best - center).distance) {
          best = c;
        }
      }
    }
    return best ?? center;
  }

  /// マップ座標 ([cellX], [cellY]) の 1x1 のマスの中心がタイル内にあるか。
  bool containsCell(int cellX, int cellY) {
    final local = Offset(cellX - x + 0.5, cellY - y + 0.5);
    if (local.dx < 0 || local.dy < 0 || local.dx > width || local.dy > height) {
      return false;
    }
    final shape = this.shape;
    if (shape == null) return true;
    final path = Path()..fillType = PathFillType.evenOdd;
    for (final ring in shape) {
      path.addPolygon(ring, true);
    }
    return path.contains(local);
  }
}

final class ClassroomMapTileProps extends MapTileProps {
  new({
    required super.floor,
    required super.x,
    required super.y,
    required super.width,
    required super.height,
    required super.top,
    required super.right,
    required super.bottom,
    required super.left,
    required this.equipment,
    required super.id,
    super.label,
    super.shape,
    super.outline,
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
    required super.x,
    required super.y,
    required super.width,
    required super.height,
    required super.top,
    required super.right,
    required super.bottom,
    required super.left,
    required super.id,
    super.label,
    super.shape,
    super.outline,
  });

  @override
  Color get foregroundColor => MapColors.invertedForeground;
  @override
  Color get backgroundColor => MapColors.facultyRoomTile;
}

final class SubRoomMapTileProps extends MapTileProps {
  new({
    required super.floor,
    required super.x,
    required super.y,
    required super.width,
    required super.height,
    required super.top,
    required super.right,
    required super.bottom,
    required super.left,
    required super.id,
    super.label,
    this.equipment,
    super.shape,
    super.outline,
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
    required super.x,
    required super.y,
    required super.width,
    required super.height,
    required super.top,
    required super.right,
    required super.bottom,
    required super.left,
    required super.id,
    super.label,
    super.shape,
    super.outline,
  });

  @override
  Color get foregroundColor => MapColors.foreground;
  @override
  Color get backgroundColor => MapColors.otherRoomTile;
}

final class RestroomMapTileProps extends MapTileProps {
  new({
    required super.floor,
    required super.x,
    required super.y,
    required super.width,
    required super.height,
    required super.top,
    required super.right,
    required super.bottom,
    required super.left,
    required this.types,
    super.shape,
    super.outline,
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
    required super.x,
    required super.y,
    required super.width,
    required super.height,
    required super.top,
    required super.right,
    required super.bottom,
    required super.left,
    required this.type,
    super.shape,
    super.outline,
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
    required super.x,
    required super.y,
    required super.width,
    required super.height,
    required super.top,
    required super.right,
    required super.bottom,
    required super.left,
    super.shape,
    super.outline,
  });

  @override
  Color get foregroundColor => MapColors.invertedForeground;
  @override
  Color get backgroundColor => MapColors.elevatorTile;
}

final class AisleMapTileProps extends MapTileProps {
  new({
    required super.floor,
    required super.x,
    required super.y,
    required super.width,
    required super.height,
    required super.top,
    required super.right,
    required super.bottom,
    required super.left,
    super.label,
    super.shape,
    super.outline,
  });

  @override
  Color get foregroundColor => MapColors.foreground;
  @override
  Color get backgroundColor => MapColors.aisleTile;
}

final class AtriumMapTileProps extends MapTileProps {
  new({
    required super.floor,
    required super.x,
    required super.y,
    required super.width,
    required super.height,
    required super.top,
    required super.right,
    required super.bottom,
    required super.left,
    super.shape,
    super.outline,
  });

  @override
  Color get foregroundColor => MapColors.foreground;
  @override
  Color get backgroundColor => MapColors.transparent;
}
