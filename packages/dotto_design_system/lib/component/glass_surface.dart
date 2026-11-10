import 'dart:ui';

import 'package:dotto_design_system/story/glass_backdrop.dart';
import 'package:dotto_design_system/style/theme_extension.dart';
import 'package:material_ui/material_ui.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

/// アイコンのみの項目の一辺。縦バーのタブとアクションで揃える。
const glassIconOnlyItemExtent = 52.0;

const _surfacePadding = 4.0;
const _surfaceRadius = 36.0;
const _surfaceBlurSigma = 24.0;

/// Liquid Glass 風のすりガラスの面。色は付けない。
final class GlassSurface extends StatelessWidget {
  const new({required this.child, super.key});

  final Widget child;

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
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}

@widgetbook.UseCase(name: 'Default', type: GlassSurface)
Widget glassSurfaceDefault(BuildContext context) => const GlassBackdrop(
  child: GlassSurface(
    child: Padding(padding: EdgeInsets.all(16), child: Text('Glass surface')),
  ),
);
