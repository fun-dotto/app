import 'package:dotto/presentation/common/vertical_bar_scope.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:material_ui/material_ui.dart';

/// アプリ共通の AppBar。
///
/// 縦バーが使われているとき ([VerticalBarScope] の配下) は、[actions] を
/// AppBar ではなく縦バーに表示する。戻るボタンも同様に縦バーへ移す。
final class DottoAppBar extends HookWidget implements PreferredSizeWidget {
  const new({
    required this.title,
    this.actions = const [],
    this.bottom,
    this.centerTitle,
    super.key,
  });

  final Widget title;
  final List<Widget> actions;
  final PreferredSizeWidget? bottom;
  final bool? centerTitle;

  @override
  Size get preferredSize =>
      Size.fromHeight(kToolbarHeight + (bottom?.preferredSize.height ?? 0));

  @override
  Widget build(BuildContext context) {
    final scope = VerticalBarScope.maybeOf(context);
    final canPop = Navigator.canPop(context);
    // 縦バーでは、戻るボタンをツールバーアイテムの先頭に置く。
    final barActions = [if (canPop) const _VerticalBarBackButton(), ...actions];
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
        (_) => notifier.value = barActions,
      );
      return () => WidgetsBinding.instance.addPostFrameCallback((_) {
        if (identical(notifier.value, barActions)) {
          notifier.value = const [];
        }
      });
    });
    return AppBar(
      title: title,
      centerTitle: centerTitle,
      automaticallyImplyLeading: scope == null,
      actions: scope == null ? actions : null,
      bottom: bottom,
    );
  }
}

final class _VerticalBarBackButton extends StatelessWidget {
  const new();

  @override
  Widget build(BuildContext context) => IconButton(
    icon: const BackButtonIcon(),
    tooltip: MaterialLocalizations.of(context).backButtonTooltip,
    onPressed: () => Navigator.maybePop(context),
  );
}
