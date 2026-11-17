import 'package:dotto_design_system/style/layout.dart';
import 'package:material_ui/material_ui.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

/// 一覧と詳細を、幅に応じて左右に並べるか1画面ずつ見せるかを切り替える。
///
/// 自身が受け取った幅が [DottoLayout.listDetailBreakpoint] 以上のときは
/// 左に [list]、右に [detail] を並べる。未満のときは [detail] だけを表示し、
/// 一覧は [detail] 側 (ナビゲーションの最下層) で見せる想定とする。
///
/// 並べているかどうかは子孫から [DottoListDetail.isSplit] で参照できる。
/// 一覧の項目を選んだときに、右ペインを差し替えるか画面を積むかの判断に使う。
class DottoListDetail extends StatelessWidget {
  const new({required this.list, required this.detail, super.key});

  /// 左ペインに置く一覧。並べないときは表示しない。
  final Widget list;

  /// 右ペイン、または並べないときに全面に表示する中身。
  final Widget detail;

  /// 祖先の [DottoListDetail] が一覧と詳細を左右に並べているか。
  static bool isSplit(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<_ListDetailScope>()?.isSplit ??
      false;

  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (context, constraints) {
      final isSplit = DottoLayout.isListDetailSplit(constraints.maxWidth);
      return _ListDetailScope(
        isSplit: isSplit,
        child: isSplit
            ? Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(width: DottoLayout.listPaneWidth, child: list),
                  const VerticalDivider(width: 1),
                  Expanded(child: detail),
                ],
              )
            : detail,
      );
    },
  );
}

/// 一覧のルートに置き、左右に並べているときだけ [placeholder] に差し替える。
///
/// 並べているときの一覧は [DottoListDetail.list] が表示するため、
/// 右ペインの最下層には一覧を重ねず、未選択であることを示す。
class DottoListDetailRoot extends StatelessWidget {
  const new({required this.child, required this.placeholder, super.key});

  /// 並べていないときに表示する一覧。
  final Widget child;

  /// 並べているときに右ペインへ表示する、未選択の案内。
  final Widget placeholder;

  @override
  Widget build(BuildContext context) =>
      DottoListDetail.isSplit(context) ? placeholder : child;
}

/// 詳細が未選択であることを示す右ペインの中身。
class DottoListDetailPlaceholder extends StatelessWidget {
  const new({required this.icon, required this.message, super.key});

  /// 案内のアイコン。
  final IconData icon;

  /// 案内の文言。
  final String message;

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.outline;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 8,
          children: [
            Icon(icon, size: 48, color: color),
            Text(
              message,
              style: Theme.of(context).textTheme.bodyMedium
                  ?.copyWith(color: color),
            ),
          ],
        ),
      ),
    );
  }
}

final class _ListDetailScope extends InheritedWidget {
  const new({required this.isSplit, required super.child});

  final bool isSplit;

  @override
  bool updateShouldNotify(_ListDetailScope oldWidget) =>
      isSplit != oldWidget.isSplit;
}

@widgetbook.UseCase(name: 'Default', type: DottoListDetail)
Widget listDetail(BuildContext context) => DottoListDetail(
  list: ListView(
    children: [for (var i = 1; i <= 20; i++) ListTile(title: Text('項目 $i'))],
  ),
  detail: const DottoListDetailPlaceholder(
    icon: Icons.touch_app,
    message: '項目を選択してください',
  ),
);
