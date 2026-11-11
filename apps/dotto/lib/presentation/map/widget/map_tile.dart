import 'package:dotto/domain/entity/room.dart';
import 'package:dotto/presentation/map/map_stair_type.dart';
import 'package:dotto/presentation/map/map_tile_props.dart';
import 'package:dotto/presentation/map/restroom_type.dart';
import 'package:dotto_design_system/style/map_colors.dart';
import 'package:material_ui/material_ui.dart';

final class MapTile extends StatelessWidget {
  const new({
    required this.props,
    required this.isFocused,
    required this.dateTime,
    this.room,
    this.onTapped,
    super.key,
  });

  final MapTileProps props;
  final Room? room;
  final bool isFocused;
  final DateTime dateTime;
  final void Function(MapTileProps, Room?)? onTapped;

  Color get tileColor {
    return isFocused
        ? MapColors.focusedTile
        : room?.isInUse(dateTime) ?? false
        ? MapColors.roomInUseTile
        : props.backgroundColor;
  }

  Color get labelColor {
    return isFocused
        ? MapColors.invertedForeground
        : room?.isInUse(dateTime) ?? false
        ? MapColors.foreground
        : props.foregroundColor;
  }

  String get labelText => room?.shortName ?? props.label ?? '';

  double get fontSize {
    if (props.width == 1) return 3;
    if (props.width >= 6 && labelText.length <= 4) return 8;
    if (props.width >= 6) return 6;
    return 4;
  }

  double get iconSize {
    final length = (props is RestroomMapTileProps
        ? (props as RestroomMapTileProps).types.length
        : 0);
    if (props.width == 1) return 6;
    if (props.width * props.height / length <= 2) return 6;
    return 8;
  }

  EdgeInsets get padding {
    return EdgeInsets.only(
      top: (props.top > 0 || isFocused) ? 0 : 1,
      right: (props.right > 0 || isFocused) ? 0 : 1,
      bottom: (props.bottom > 0 || isFocused) ? 0 : 1,
      left: (props.left > 0 || isFocused) ? 0 : 1,
    );
  }

  Border get border {
    return Border(
      top: isFocused
          ? const BorderSide(color: MapColors.focusedTile)
          : props.top > 0
          ? BorderSide(width: props.top.toDouble())
          : BorderSide.none,
      right: isFocused
          ? const BorderSide(color: MapColors.focusedTile)
          : props.right > 0
          ? BorderSide(width: props.right.toDouble())
          : BorderSide.none,
      bottom: isFocused
          ? const BorderSide(color: MapColors.focusedTile)
          : props.bottom > 0
          ? BorderSide(width: props.bottom.toDouble())
          : BorderSide.none,
      left: isFocused
          ? const BorderSide(color: MapColors.focusedTile)
          : props.left > 0
          ? BorderSide(width: props.left.toDouble())
          : BorderSide.none,
    );
  }

  /// 部屋名やアイコンなど、タイルの中心に置く要素。
  List<Widget> get _labels => [
    Padding(
      padding: const EdgeInsets.all(2),
      child: _MapTileLabel(
        text: labelText,
        fontSize: fontSize,
        color: labelColor,
      ),
    ),
    if (props case RestroomMapTileProps(:final types))
      _RestroomIcons(types: types, iconSize: iconSize),
    if (props is ElevatorMapTileProps) const _MapElevator(),
  ];

  @override
  Widget build(BuildContext context) {
    final shape = props.shape;
    final tile = GestureDetector(
      onTap: () => onTapped?.call(props, room),
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          if (shape == null)
            _MapTileSurface(
              props: props,
              tileColor: tileColor,
              padding: padding,
              border: border,
            )
          else
            SizedBox.expand(
              child: CustomPaint(
                painter: _MapShapePainter(
                  props: props,
                  shape: shape,
                  tileColor: tileColor,
                  isFocused: isFocused,
                ),
              ),
            ),
          if (shape == null)
            ..._labels
          else
            _AnchoredToShape(props: props, children: _labels),
          if (props case StairMapTileProps(:final type))
            _MapStair(props: props, type: type),
        ],
      ),
    );
    if (shape == null) return tile;
    // 形の外側 (外接矩形の余白) は描画もタップもさせない。
    return ClipPath(
      clipper: _MapShapeClipper(props: props, shape: shape),
      child: tile,
    );
  }
}

/// 矩形でないタイルで、ラベル類を [MapTileProps.labelAnchor] を中心に置く。
final class _AnchoredToShape extends StatelessWidget {
  const new({required this.props, required this.children});
  final MapTileProps props;
  final List<Widget> children;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final anchor = props.labelAnchor;
        return Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              left: anchor.dx * constraints.maxWidth / props.width,
              top: anchor.dy * constraints.maxHeight / props.height,
              child: FractionalTranslation(
                translation: const Offset(-0.5, -0.5),
                child: Stack(alignment: Alignment.center, children: children),
              ),
            ),
          ],
        );
      },
    );
  }
}

/// [MapTileProps.shape] をウィジェットのサイズに合わせたパスにする。
Path _shapePath(MapTileProps props, List<List<Offset>> shape, Size size) {
  final sx = size.width / props.width;
  final sy = size.height / props.height;
  final path = Path()..fillType = PathFillType.evenOdd;
  for (final ring in shape) {
    path.addPolygon([for (final p in ring) Offset(p.dx * sx, p.dy * sy)], true);
  }
  return path;
}

final class _MapShapeClipper extends CustomClipper<Path> {
  const new({required this.props, required this.shape});
  final MapTileProps props;
  final List<List<Offset>> shape;
  @override
  Path getClip(Size size) => _shapePath(props, shape, size);
  @override
  bool shouldReclip(_MapShapeClipper oldClipper) =>
      oldClipper.props != props || oldClipper.shape != shape;
}

final class _MapShapePainter extends CustomPainter {
  const new({
    required this.props,
    required this.shape,
    required this.tileColor,
    required this.isFocused,
  });
  final MapTileProps props;
  final List<List<Offset>> shape;
  final Color tileColor;
  final bool isFocused;

  @override
  void paint(Canvas canvas, Size size) {
    final path = _shapePath(props, shape, size);
    canvas.drawPath(path, Paint()..color = tileColor);
    // クリップされるため線の内側半分だけが見える。矩形タイルと見た目を
    // 揃えるため、枠線なしの場合も通路色で 1 の隙間を空ける。
    final (color, width) = isFocused
        ? (MapColors.focusedTile, 2.0)
        : props.outline > 0
        ? (MapColors.foreground, props.outline * 2.0)
        : (MapColors.aisleTile, 2.0);
    canvas.drawPath(
      path,
      Paint()
        ..style = PaintingStyle.stroke
        ..color = color
        ..strokeWidth = width,
    );
  }

  @override
  bool shouldRepaint(_MapShapePainter oldDelegate) =>
      oldDelegate.props != props ||
      oldDelegate.shape != shape ||
      oldDelegate.tileColor != tileColor ||
      oldDelegate.isFocused != isFocused;
}

final class _MapTileSurface extends StatelessWidget {
  const new({
    required this.props,
    required this.tileColor,
    required this.padding,
    required this.border,
  });
  final MapTileProps props;
  final Color tileColor;
  final EdgeInsets padding;
  final Border border;
  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Container(
        padding: padding,
        decoration: BoxDecoration(
          border: border,
          color: (props is AtriumMapTileProps)
              ? tileColor
              : MapColors.aisleTile,
        ),
        child: SizedBox.expand(
          child: Container(padding: EdgeInsets.zero, color: tileColor),
        ),
      ),
    );
  }
}

final class _MapTileLabel extends StatelessWidget {
  const new({required this.text, required this.fontSize, required this.color});
  final String text;
  final double fontSize;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.labelSmall
          ?.copyWith(fontSize: fontSize, color: color),
    );
  }
}

final class _RestroomIcons extends StatelessWidget {
  const new({required this.types, required this.iconSize});
  final List<RestroomType> types;
  final double iconSize;
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: types
          .map((type) => Icon(type.icon, size: iconSize, color: type.color))
          .toList(),
    );
  }
}

final class _MapStair extends StatelessWidget {
  const new({required this.props, required this.type});
  final MapTileProps props;
  final MapStairType type;
  @override
  Widget build(BuildContext context) {
    final stairWidth = props.width * 2.5;
    final stairHeight = props.height * 2.5;
    return Stack(
      children: [
        SizedBox.expand(
          child: Flex(
            direction: type.getDirection(),
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              if (type.direction == Axis.horizontal)
                for (int i = 0; i < stairWidth.toInt(); i++) ...{
                  const Expanded(
                    child: VerticalDivider(
                      thickness: 0.3,
                      color: MapColors.foreground,
                    ),
                  ),
                }
              else
                for (int i = 0; i < stairHeight.toInt(); i++) ...{
                  const Expanded(
                    child: Divider(thickness: 0.3, color: MapColors.foreground),
                  ),
                },
            ],
          ),
        ),
        if (type.up && !type.down)
          const SizedBox.expand(
            child: Center(
              child: Icon(
                Icons.arrow_upward_rounded,
                size: 12,
                color: MapColors.stairArrow,
              ),
            ),
          ),
        if (!type.up && (type.down))
          const SizedBox.expand(
            child: Center(
              child: Icon(
                Icons.arrow_downward_rounded,
                size: 12,
                color: MapColors.stairArrow,
              ),
            ),
          ),
        if ((type.up) && (type.down)) const SizedBox.expand(),
      ],
    );
  }
}

final class _MapElevator extends StatelessWidget {
  const new();
  @override
  Widget build(BuildContext context) {
    return const Icon(
      Icons.elevator_outlined,
      size: 12,
      color: MapColors.invertedForeground,
      weight: 100,
    );
  }
}
