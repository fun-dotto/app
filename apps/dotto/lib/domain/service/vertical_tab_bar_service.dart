import 'dart:math' as math;

import 'package:dotto/domain/entity/occlusion_region.dart';

/// 縦型タブバーを置く縦方向の範囲。
typedef VerticalTabBarSpan = ({double top, double bottom});

/// 縦型タブバーの配置を決める Domain Service。
final class VerticalTabBarService {
  const new();

  /// 隠れる領域を避けて、縦型タブバーを置ける最も高い範囲を返す。
  ///
  /// [barLeft] と [barWidth] で表すバーの列と重なる [occlusions] の上下に
  /// [margin] を加えた範囲を除き、残った範囲のうち最も高いものを選ぶ。
  /// [minTop] から [maxBottom] の間に置ける範囲がなければ `null` を返す。
  VerticalTabBarSpan? place({
    required double barLeft,
    required double barWidth,
    required double minTop,
    required double maxBottom,
    required List<OcclusionRegion> occlusions,
    double margin = 0,
  }) {
    final barRight = barLeft + barWidth;
    final blocked =
        occlusions
            .where((o) => o.left < barRight && o.right > barLeft)
            .map(
              (o) => (
                top: math.max(o.top - margin, minTop),
                bottom: math.min(o.bottom + margin, maxBottom),
              ),
            )
            .toList()
          ..sort((a, b) => a.top.compareTo(b.top));

    VerticalTabBarSpan? best;
    var bestHeight = 0.0;
    void consider(double top, double bottom) {
      if (bottom - top <= bestHeight) return;
      bestHeight = bottom - top;
      best = (top: top, bottom: bottom);
    }

    var cursor = minTop;

    for (final region in blocked) {
      consider(cursor, region.top);
      cursor = math.max(cursor, region.bottom);
    }
    consider(cursor, maxBottom);
    return best;
  }
}
