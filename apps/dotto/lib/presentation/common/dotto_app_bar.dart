import 'package:dotto/presentation/common/vertical_bar_scope.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:material_ui/material_ui.dart';

/// アプリ共通の AppBar。
///
/// 縦バーが使われているとき ([VerticalBarScope] の配下) は、[actions] を
/// AppBar ではなく縦バーに表示する。
final class DottoAppBar extends HookWidget implements PreferredSizeWidget {
  const new({
    required this.title,
    this.actions = const [],
    this.bottom,
    super.key,
  });

  final Widget title;
  final List<Widget> actions;
  final PreferredSizeWidget? bottom;

  @override
  Size get preferredSize =>
      Size.fromHeight(kToolbarHeight + (bottom?.preferredSize.height ?? 0));

  @override
  Widget build(BuildContext context) {
    final scope = VerticalBarScope.maybeOf(context);
    // 他の画面が重なっている間や、タブ切り替えで裏に回っている間
    // (TickerMode が無効) は、表示中の画面にアクションの表示を譲る。
    final isCurrent =
        (ModalRoute.isCurrentOf(context) ?? true) &&
        TickerMode.valuesOf(context).enabled;
    useEffect(() {
      if (scope == null || !isCurrent) return null;
      final notifier = scope.actions;
      // ビルド中に縦バーを再構築しないよう、フレーム後に反映する。
      WidgetsBinding.instance.addPostFrameCallback(
        (_) => notifier.value = actions,
      );
      return () => WidgetsBinding.instance.addPostFrameCallback((_) {
        if (identical(notifier.value, actions)) {
          notifier.value = const [];
        }
      });
    });
    return AppBar(
      title: title,
      centerTitle: false,
      actions: scope == null ? actions : null,
      bottom: bottom,
    );
  }
}
