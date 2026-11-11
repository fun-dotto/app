import 'package:collection/collection.dart';
import 'package:dotto/domain/entity/room.dart';
import 'package:dotto/presentation/map/map_tile_props.dart';
import 'package:dotto/presentation/map/widget/map_tile.dart';
import 'package:material_ui/material_ui.dart';

/// GeoJSON から読み込んだタイルを、各タイルの座標に従って配置する。
///
/// 横幅いっぱいにマップの幅を合わせ、1 グリッド単位を正方形として描画する。
final class MapGridScreen extends StatelessWidget {
  const new({
    required this.tileProps,
    required this.rooms,
    required this.focusedMapTileProps,
    required this.dateTime,
    required this.onTapped,
    this.bounds,
    super.key,
  });

  final List<MapTileProps> tileProps;

  /// 描画するマップ座標の範囲 (グリッド単位)。
  ///
  /// 階をまたいで同じ範囲を渡すと、階を切り替えても同じ位置が同じ場所に
  /// 表示される。省略した場合は [tileProps] 全体を囲む範囲を使う。
  final Rect? bounds;
  final List<Room> rooms;
  final MapTileProps? focusedMapTileProps;
  final DateTime dateTime;
  final void Function(MapTileProps, Room?)? onTapped;

  @override
  Widget build(BuildContext context) {
    if (tileProps.isEmpty) return const SizedBox.shrink();
    final area = bounds ?? tilePropsBounds(tileProps);
    final minX = area.left;
    final minY = area.top;
    final columns = area.width;
    final rows = area.height;
    return LayoutBuilder(
      builder: (context, constraints) {
        final cell = constraints.maxWidth / columns;
        return SizedBox(
          width: constraints.maxWidth,
          height: cell * rows,
          child: Stack(
            children: [
              for (final e in tileProps)
                Positioned(
                  left: (e.x - minX) * cell,
                  top: (e.y - minY) * cell,
                  width: e.width * cell,
                  height: e.height * cell,
                  child: MapTile(
                    props: e,
                    room: rooms.firstWhereOrNull((room) => room.id == e.id),
                    isFocused: e.id != null && focusedMapTileProps?.id == e.id,
                    dateTime: dateTime,
                    onTapped: onTapped,
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}

/// タイル全体を囲む範囲 (グリッド単位)。
Rect tilePropsBounds(Iterable<MapTileProps> tileProps) => Rect.fromLTRB(
  tileProps.map((e) => e.x).min.toDouble(),
  tileProps.map((e) => e.y).min.toDouble(),
  tileProps.map((e) => e.x + e.width).max.toDouble(),
  tileProps.map((e) => e.y + e.height).max.toDouble(),
);
