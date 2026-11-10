import 'dart:math' as math;

import 'package:dotto_design_system/style/layout.dart';
import 'package:material_ui/material_ui.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

/// ブレイクポイント未満で2カラムをどう1カラムにまとめるか。
enum DottoCollapse {
  /// primary の下に secondary を積む。
  stack,

  /// primary だけを表示する (secondary は別画面で見せる想定)。
  primaryOnly,
}

enum _Kind { single, twoColumn, flow }

/// 本文を [DottoLayout] のトークンに従って配置する。
///
/// 自身が受け取った幅を「本文に使える幅」として、ブレイクポイントの判定、
/// 左右の余白、最大幅、中央寄せをまとめて行う。スクロールは呼び出し側で行う。
class DottoContent extends StatelessWidget {
  /// 1カラムで表示する。
  ///
  /// [layout] は [DottoContentLayout.singleNarrow] か
  /// [DottoContentLayout.singleWide] を指定する。
  const new single({
    required Widget this.child,
    this.layout = DottoContentLayout.singleNarrow,
    super.key,
  }) : assert(
         layout != DottoContentLayout.twoColumn,
         '2カラムは DottoContent.twoColumn を使う',
       ),
       _kind = _Kind.single,
       primary = null,
       secondary = null,
       collapse = DottoCollapse.stack,
       sections = const [],
       spacing = 0;

  /// ブレイクポイント以上で [primary] を左、[secondary] を右に表示する。
  const new twoColumn({
    required Widget this.primary,
    required Widget this.secondary,
    this.collapse = DottoCollapse.stack,
    this.spacing = 16,
    super.key,
  }) : _kind = _Kind.twoColumn,
       layout = DottoContentLayout.twoColumn,
       child = null,
       sections = const [];

  /// [sections] を縦に並べ、ブレイクポイント以上では左右2列に交互に振り分ける。
  const new flow({required this.sections, this.spacing = 16, super.key})
    : _kind = _Kind.flow,
      layout = DottoContentLayout.twoColumn,
      child = null,
      primary = null,
      secondary = null,
      collapse = DottoCollapse.stack;

  final _Kind _kind;

  /// 本文の組み方。
  final DottoContentLayout layout;

  /// [DottoContent.single] の本文。
  final Widget? child;

  /// [DottoContent.twoColumn] の左カラム。
  final Widget? primary;

  /// [DottoContent.twoColumn] の右カラム。
  final Widget? secondary;

  /// ブレイクポイント未満での2カラムのまとめ方。
  final DottoCollapse collapse;

  /// [DottoContent.flow] のセクション。
  final List<Widget> sections;

  /// 縦に並べる要素どうしの間隔。
  final double spacing;

  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (context, constraints) {
      final width = constraints.maxWidth;
      final isExpanded = DottoLayout.isExpanded(width);
      final available = math
          .max(0, width - DottoLayout.horizontalMargin * 2)
          .toDouble();
      final narrowWidth = math.min(DottoLayout.narrowMaxWidth, available);

      switch (_kind) {
        case _Kind.single:
          final maxWidth = isExpanded && layout == DottoContentLayout.singleWide
              ? DottoLayout.wideMaxWidth
              : DottoLayout.narrowMaxWidth;
          return _Centered(width: math.min(maxWidth, available), child: child!);

        case _Kind.twoColumn:
          if (!isExpanded) {
            return _Centered(
              width: narrowWidth,
              child: switch (collapse) {
                DottoCollapse.stack => Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  spacing: spacing,
                  children: [primary!, secondary!],
                ),
                DottoCollapse.primaryOnly => primary!,
              },
            );
          }
          return _TwoColumns(
            columnWidth: _columnWidth(available),
            left: primary!,
            right: secondary!,
          );

        case _Kind.flow:
          if (!isExpanded) {
            return _Centered(width: narrowWidth, child: _stack(sections));
          }
          return _TwoColumns(
            columnWidth: _columnWidth(available),
            left: _stack([
              for (var i = 0; i < sections.length; i += 2) sections[i],
            ]),
            right: _stack([
              for (var i = 1; i < sections.length; i += 2) sections[i],
            ]),
          );
      }
    },
  );

  Widget _stack(List<Widget> children) => Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.stretch,
    spacing: spacing,
    children: children,
  );

  static double _columnWidth(double available) => math
      .max(
        0,
        math.min(
          DottoLayout.narrowMaxWidth,
          (available - DottoLayout.columnGutter) / 2,
        ),
      )
      .toDouble();
}

/// 左右に余白をとり、幅 [width] の本文を上端中央に置く。
class _Centered extends StatelessWidget {
  const new({required this.width, required this.child});

  final double width;
  final Widget child;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(
      horizontal: DottoLayout.horizontalMargin,
    ),
    child: Align(
      alignment: Alignment.topCenter,
      child: SizedBox(width: width, child: child),
    ),
  );
}

class _TwoColumns extends StatelessWidget {
  const new({
    required this.columnWidth,
    required this.left,
    required this.right,
  });

  final double columnWidth;
  final Widget left;
  final Widget right;

  @override
  Widget build(BuildContext context) => _Centered(
    width: columnWidth * 2 + DottoLayout.columnGutter,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: DottoLayout.columnGutter,
      children: [
        SizedBox(width: columnWidth, child: left),
        SizedBox(width: columnWidth, child: right),
      ],
    ),
  );
}

Widget _box(String label, {double height = 120}) => Container(
  height: height,
  alignment: Alignment.center,
  color: Colors.blueGrey.withValues(alpha: 0.2),
  child: Text(label),
);

@widgetbook.UseCase(name: 'Single Narrow', type: DottoContent)
Widget contentSingleNarrow(BuildContext context) => SingleChildScrollView(
  child: DottoContent.single(child: _box('本文 (最大 480)')),
);

@widgetbook.UseCase(name: 'Single Wide', type: DottoContent)
Widget contentSingleWide(BuildContext context) => SingleChildScrollView(
  child: DottoContent.single(
    layout: DottoContentLayout.singleWide,
    child: _box('本文 (640 以上で最大 960)'),
  ),
);

@widgetbook.UseCase(name: 'Two Column', type: DottoContent)
Widget contentTwoColumn(BuildContext context) => SingleChildScrollView(
  child: DottoContent.twoColumn(
    primary: _box('primary', height: 240),
    secondary: _box('secondary'),
  ),
);

@widgetbook.UseCase(name: 'Two Column (Primary Only)', type: DottoContent)
Widget contentTwoColumnPrimaryOnly(BuildContext context) =>
    SingleChildScrollView(
      child: DottoContent.twoColumn(
        primary: _box('primary', height: 240),
        secondary: _box('secondary'),
        collapse: DottoCollapse.primaryOnly,
      ),
    );

@widgetbook.UseCase(name: 'Flow', type: DottoContent)
Widget contentFlow(BuildContext context) => SingleChildScrollView(
  child: DottoContent.flow(
    sections: [
      for (var i = 1; i <= 5; i++) _box('セクション $i', height: 80.0 + i * 20),
    ],
  ),
);
