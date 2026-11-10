import 'dart:math' as math;

import 'package:collection/collection.dart';
import 'package:dotto/domain/entity/occlusion_region.dart';

/// 縦型タブバーを置く縦方向の範囲。
typedef VerticalTabBarSpan = ({double top, double bottom});

/// 縦型タブバーの配置を決める Domain Service。
final class VerticalTabBarService {
  const new();

  /// 隠れる領域を避けて、縦型タブバーを置ける最も下の範囲を返す。
  ///
  /// [barLeft] と [barWidth] で表すバーの列と重なる [occlusions] の上下に
  /// [margin] を加えた範囲を除き、残った範囲のうち高さが [minHeight] 以上で
  /// 最も下にあるものを選ぶ。[minTop] から [maxBottom] の間に置ける範囲が
  /// なければ `null` を返す。
  VerticalTabBarSpan? place({
    required double barLeft,
    required double barWidth,
    required double minTop,
    required double maxBottom,
    required List<OcclusionRegion> occlusions,
    double margin = 0,
    double minHeight = 0,
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

    final spans = <VerticalTabBarSpan>[];
    var cursor = minTop;
    for (final region in blocked) {
      spans.add((top: cursor, bottom: region.top));
      cursor = math.max(cursor, region.bottom);
    }
    spans.add((top: cursor, bottom: maxBottom));

    // 下寄せで置くため、必要な高さを満たす範囲のうち最も下のものを選ぶ。
    return spans.lastWhereOrNull(
      (s) => s.bottom - s.top > 0 && s.bottom - s.top >= minHeight,
    );
  }
}
