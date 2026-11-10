import 'dart:math' as math;

import 'package:flutter/painting.dart';

/// 本文の組み方。
///
/// 本文に使える幅が [DottoLayout.breakpoint] 未満のときは、どれを選んでも
/// 本文の最大幅 [DottoLayout.narrowMaxWidth] の1カラムになる。
enum DottoContentLayout {
  /// ブレイクポイント以上で2カラム。各カラムの本文は最大
  /// [DottoLayout.narrowMaxWidth]、合計は最大 [DottoLayout.wideMaxWidth]。
  twoColumn,

  /// ブレイクポイント以上でも、本文の最大幅 [DottoLayout.narrowMaxWidth] の1カラム。
  singleNarrow,

  /// ブレイクポイント以上で、本文の最大幅 [DottoLayout.wideMaxWidth] の1カラム。
  singleWide,
}

/// 本文レイアウトのトークン。
///
/// 最大幅はいずれも本文そのものの幅で、左右の余白 [horizontalMargin] と
/// カラム間のガター [columnGutter] を含まない。
abstract final class DottoLayout {
  /// この幅以上で、[DottoContentLayout] の選択が反映される。
  ///
  /// 判定には画面幅ではなく、本文に使える幅 (縦型バーなどを除いた幅) を使う。
  static const double breakpoint = 640;

  /// 1カラムの本文、および2カラムの各カラムの最大幅。
  static const double narrowMaxWidth = 480;

  /// [DottoContentLayout.singleWide] の本文、および2カラムの本文合計の最大幅。
  static const double wideMaxWidth = 960;

  /// 本文の左右の余白。
  static const double horizontalMargin = 16;

  /// 2カラムのカラム間の余白。
  static const double columnGutter = 16;

  /// 本文に使える幅 [width] がブレイクポイント以上か。
  static bool isExpanded(double width) => width >= breakpoint;

  /// 本文に使える幅 [width] で、1カラムの本文がとる最大幅。
  static double singleMaxWidth(double width, DottoContentLayout layout) =>
      isExpanded(width) && layout == DottoContentLayout.singleWide
      ? wideMaxWidth
      : narrowMaxWidth;

  /// スクロールビューの左右に入れる余白。
  ///
  /// スクロールできる範囲は全幅のまま、中身だけを本文の最大幅に収めて
  /// 中央に寄せるために使う。余白は [horizontalMargin] 以上になる。
  ///
  /// `ListTile` のように中身が自前で左右の余白を持つときは [margin] を
  /// false にする。余白込みで本文の最大幅 + [horizontalMargin] * 2 に収め、
  /// 幅が足りなければ余白は 0 になる。
  static EdgeInsets horizontalInsets(
    double width, {
    DottoContentLayout layout = DottoContentLayout.singleNarrow,
    bool margin = true,
  }) {
    final maxWidth = singleMaxWidth(width, layout);
    final side = margin
        ? math.max(horizontalMargin, (width - maxWidth) / 2)
        : math.max(0, (width - maxWidth) / 2 - horizontalMargin).toDouble();
    return EdgeInsets.symmetric(horizontal: side);
  }
}
