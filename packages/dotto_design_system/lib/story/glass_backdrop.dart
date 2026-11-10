import 'package:material_ui/material_ui.dart';

/// Story 用の背景。
///
/// すりガラスの透け感が分かるよう、色のついたグラデーションを敷く。
final class GlassBackdrop extends StatelessWidget {
  const new({
    required this.child,
    this.alignment = Alignment.center,
    super.key,
  });

  final Widget child;
  final AlignmentGeometry alignment;

  @override
  Widget build(BuildContext context) => DecoratedBox(
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.orange, Colors.pink, Colors.indigo],
      ),
    ),
    child: Align(alignment: alignment, child: child),
  );
}
