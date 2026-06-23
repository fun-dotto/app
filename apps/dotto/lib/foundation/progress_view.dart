import 'dart:math' as math;

import 'package:flutter/widgets.dart';

/// ローディング中に画面全体を覆うインジケーター。
///
/// Material / Cupertino に依存せず、`flutter/widgets` のみで実装している。
final class ProgressView extends StatefulWidget {
  const ProgressView({super.key});

  @override
  State<ProgressView> createState() => _ProgressViewState();
}

class _ProgressViewState extends State<ProgressView>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1200),
  )..repeat();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: const Color(0x66000000),
      child: Center(
        child: RepaintBoundary(
          child: RotationTransition(
            turns: _controller,
            child: const SizedBox.square(
              dimension: 36,
              child: CustomPaint(
                painter: _SpinnerPainter(
                  color: Color(0xFFFFFFFF),
                  strokeWidth: 4,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SpinnerPainter extends CustomPainter {
  const _SpinnerPainter({required this.color, required this.strokeWidth});

  final Color color;
  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final center = rect.center;
    final radius = (size.shortestSide - strokeWidth) / 2;

    // 円弧の濃淡で回転方向を示すため、SweepGradient を使用する。
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..shader = SweepGradient(
        colors: [color.withAlpha(0), color],
      ).createShader(Rect.fromCircle(center: center, radius: radius));

    // 全周ではなく約 300 度だけ描いて、先頭が分かるようにする。
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      0,
      math.pi * 2 * 0.83,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(_SpinnerPainter oldDelegate) =>
      oldDelegate.color != color || oldDelegate.strokeWidth != strokeWidth;
}
