import 'package:dotto/presentation/common/tab_item.dart';
import 'package:dotto/presentation/root/glass_surface.dart';
import 'package:dotto_design_system/style/theme_extension.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:material_ui/material_ui.dart';

const _itemExtent = 64.0;
const _iconSize = 26.0;
const _iconLabelSpacing = 2.0;
const _tooltipGap = 8.0;
const _bounceDuration = Duration(milliseconds: 450);

// いったん縮んでから大きく跳ね、元の大きさに戻る。
final _bounceTween = TweenSequence<double>([
  TweenSequenceItem(
    tween: Tween<double>(
      begin: 1,
      end: 0.78,
    ).chain(CurveTween(curve: Curves.easeOut)),
    weight: 20,
  ),
  TweenSequenceItem(
    tween: Tween<double>(
      begin: 0.78,
      end: 1.18,
    ).chain(CurveTween(curve: Curves.easeOut)),
    weight: 35,
  ),
  TweenSequenceItem(
    tween: Tween<double>(
      begin: 1.18,
      end: 1,
    ).chain(CurveTween(curve: Curves.bounceOut)),
    weight: 45,
  ),
]);

/// Liquid Glass 風のタブバー。
///
/// すりガラス状の面に、色を付けずアイコンとラベルだけを並べる。選択中の
/// アイコンだけを [accentColor] で塗る。[axis] で横並び (下部) と縦並び
/// (縦バー) を切り替える。
///
/// 縦並びは幅が限られるためアイコンのみとし、ラベルは長押しのツールチップで
/// 示す。
final class GlassTabBar extends StatelessWidget {
  const new({
    required this.tabs,
    required this.selectedIndex,
    required this.onSelected,
    required this.accentColor,
    this.axis = Axis.horizontal,
    super.key,
  });

  final List<TabItem> tabs;
  final int selectedIndex;
  final ValueChanged<int> onSelected;
  final Color accentColor;
  final Axis axis;

  @override
  Widget build(BuildContext context) {
    return GlassSurface(
      child: Flex(
        direction: axis,
        mainAxisSize: MainAxisSize.min,
        children: [
          for (final (index, tab) in tabs.indexed)
            _wrap(
              _GlassTabItem(
                tab: tab,
                isSelected: index == selectedIndex,
                accentColor: accentColor,
                showsLabel: axis == Axis.horizontal,
                onTap: () => onSelected(index),
              ),
            ),
        ],
      ),
    );
  }

  Widget _wrap(Widget item) {
    return switch (axis) {
      Axis.horizontal => Expanded(
        child: SizedBox(height: _itemExtent, child: item),
      ),
      Axis.vertical => SizedBox.square(
        dimension: glassIconOnlyItemExtent,
        child: item,
      ),
    };
  }
}

// 最も近い左右の壁の反対側へラベルを出す。縦バーは画面端にあるため、
// 画面の内側に向けて表示することになる。
Offset _positionAwayFromNearestWall(TooltipPositionContext context) {
  final isNearLeftWall = context.target.dx < context.overlaySize.width / 2;
  final halfWidth = context.targetSize.width / 2;
  final dx = isNearLeftWall
      ? context.target.dx + halfWidth + _tooltipGap
      : context.target.dx - halfWidth - _tooltipGap - context.tooltipSize.width;
  return Offset(dx, context.target.dy - context.tooltipSize.height / 2);
}

final class _GlassTabItem extends HookWidget {
  const new({
    required this.tab,
    required this.isSelected,
    required this.accentColor,
    required this.showsLabel,
    required this.onTap,
  });

  final TabItem tab;
  final bool isSelected;
  final Color accentColor;
  final bool showsLabel;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).semanticColors;
    final controller = useAnimationController(duration: _bounceDuration);
    final scale = useMemoized(() => _bounceTween.animate(controller), [
      controller,
    ]);
    final item = Semantics(
      button: true,
      selected: isSelected,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          // タップのたびに、アイコンを弾ませて反応を返す。
          controller.forward(from: 0);
          onTap();
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: _iconLabelSpacing,
          children: [
            ScaleTransition(
              scale: scale,
              child: Icon(
                isSelected ? tab.selectedIcon : tab.icon,
                size: _iconSize,
                color: isSelected ? accentColor : colors.labelPrimary,
              ),
            ),
            if (showsLabel)
              Text(
                tab.label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.labelSmall
                    ?.copyWith(color: colors.labelPrimary),
              ),
          ],
        ),
      ),
    );
    // ラベルを出さないときは、長押しで示し、読み上げにも使えるようにする。
    return showsLabel
        ? item
        : Tooltip(
            message: tab.label,
            positionDelegate: _positionAwayFromNearestWall,
            child: item,
          );
  }
}
