import 'package:material_ui/material_ui.dart';

/// 縦バーが使われているときに、画面のツールバーアイテムを縦バーへ渡す窓口。
///
/// このスコープの配下にある `DottoAppBar` は、アクションを自身に表示せず
/// [actions] へ登録する。スコープがなければ (下部タブバーのとき) 通常どおり
/// AppBar に表示する。
final class VerticalBarScope extends InheritedWidget {
  const new({required this.actions, required super.child, super.key});

  /// 縦バーに表示するアクション。最前面の画面が登録する。
  final ValueNotifier<List<Widget>> actions;

  static VerticalBarScope? maybeOf(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<VerticalBarScope>();

  @override
  bool updateShouldNotify(VerticalBarScope oldWidget) =>
      !identical(actions, oldWidget.actions);
}
