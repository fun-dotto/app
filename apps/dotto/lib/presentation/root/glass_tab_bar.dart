import 'dart:ui';

import 'package:dotto/presentation/common/tab_item.dart';
import 'package:dotto_design_system/style/theme_extension.dart';
import 'package:material_ui/material_ui.dart';

const _itemExtent = 64.0;
const _surfacePadding = 4.0;
const _surfaceRadius = 36.0;
const _surfaceBlurSigma = 24.0;
const _iconSize = 26.0;
const _iconLabelSpacing = 2.0;

/// Liquid Glass 風のタブバー。
///
/// すりガラス状の面に、色を付けずアイコンとラベルだけを並べる。選択中の
/// アイコンだけを [accentColor] で塗る。[axis] で横並び (下部) と縦並び
/// (縦バー) を切り替える。
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
    final colors = Theme.of(context).semanticColors;
    const radius = BorderRadius.all(Radius.circular(_surfaceRadius));
    // 白を重ねて光の反射を表し、色味は足さない。
    final highlight = colors.backgroundSecondary;
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: radius,
        boxShadow: [
          BoxShadow(
            color: colors.labelPrimary.withValues(alpha: 0.12),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: radius,
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: _surfaceBlurSigma,
            sigmaY: _surfaceBlurSigma,
          ),
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: radius,
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  highlight.withValues(alpha: 0.7),
                  highlight.withValues(alpha: 0.3),
                ],
              ),
              border: Border.all(color: highlight.withValues(alpha: 0.8)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(_surfacePadding),
              child: Flex(
                direction: axis,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: axis == Axis.vertical
                    ? CrossAxisAlignment.stretch
                    : CrossAxisAlignment.center,
                children: [
                  for (final (index, tab) in tabs.indexed)
                    _wrap(
                      _GlassTabItem(
                        tab: tab,
                        isSelected: index == selectedIndex,
                        accentColor: accentColor,
                        onTap: () => onSelected(index),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _wrap(Widget item) {
    final sized = SizedBox(height: _itemExtent, child: item);
    return axis == Axis.horizontal ? Expanded(child: sized) : sized;
  }
}

final class _GlassTabItem extends StatelessWidget {
  const new({
    required this.tab,
    required this.isSelected,
    required this.accentColor,
    required this.onTap,
  });

  final TabItem tab;
  final bool isSelected;
  final Color accentColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).semanticColors;
    return Semantics(
      button: true,
      selected: isSelected,
      child: InkResponse(
        onTap: onTap,
        radius: _itemExtent / 2,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: _iconLabelSpacing,
          children: [
            Icon(
              isSelected ? tab.selectedIcon : tab.icon,
              size: _iconSize,
              color: isSelected ? accentColor : colors.labelPrimary,
            ),
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
  }
}
