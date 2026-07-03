import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

final class DottoProgressIndicator extends HookWidget {
  const DottoProgressIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    final animationController = useAnimationController(
      duration: const Duration(milliseconds: 1200),
    );
    unawaited(animationController.repeat());

    return DecoratedBox(
      decoration: BoxDecoration(
        color: const Color(0x66000000),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: RepaintBoundary(
          child: RotationTransition(
            turns: animationController,
            child: const SizedBox.square(
              dimension: 36,
              child: CustomPaint(
                painter: _SpinnerPainter(
                  color: Colors.white,
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

final class _Demo extends StatelessWidget {
  const _Demo({
    //
    // ignore: unused_element_parameter
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: DottoProgressIndicator()),
    );
  }
}

@widgetbook.UseCase(name: 'ProgressIndicator', type: DottoProgressIndicator)
Widget progressIndicator(BuildContext context) {
  return const _Demo();
}
