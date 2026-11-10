import 'package:dotto_design_system/component/vertical_bar_actions.dart';
import 'package:dotto_design_system/component/vertical_bar_scope.dart';
import 'package:dotto_design_system/story/glass_backdrop.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:material_ui/material_ui.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

/// アプリ共通の AppBar。
///
/// 縦バーが使われているとき ([VerticalBarScope] の配下) は、[actions] を
/// AppBar ではなく縦バーに表示する。戻るボタンも同様に縦バーへ移す。
/// [leading] を指定した場合は、戻るボタンの代わりにそれを表示する。
final class DottoAppBar extends HookWidget implements PreferredSizeWidget {
  const new({
    required this.title,
    this.leading,
    this.actions = const [],
    this.bottom,
    this.centerTitle,
    super.key,
  });

  final Widget title;
  final Widget? leading;
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
    final barActions = [
      ?leading ?? (canPop ? const _VerticalBarBackButton() : null),
      ...actions,
    ];
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
      leading: scope == null ? leading : null,
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

@widgetbook.UseCase(name: 'Default', type: DottoAppBar)
Widget dottoAppBarDefault(BuildContext context) => const Scaffold(
  appBar: DottoAppBar(
    title: Text('講義'),
    actions: [Icon(Icons.tune), SizedBox(width: 16)],
  ),
);

@widgetbook.UseCase(name: 'With Leading', type: DottoAppBar)
Widget dottoAppBarWithLeading(BuildContext context) => Scaffold(
  appBar: DottoAppBar(
    title: const Text('レビュー投稿'),
    leading: IconButton(icon: const Icon(Icons.close), onPressed: () {}),
  ),
);

/// 縦バーの配下では、アクションが AppBar ではなく縦バーに表示される。
@widgetbook.UseCase(name: 'In Vertical Bar', type: DottoAppBar)
Widget dottoAppBarInVerticalBar(BuildContext context) =>
    const _VerticalBarDemo();

final class _VerticalBarDemo extends HookWidget {
  const new();

  @override
  Widget build(BuildContext context) {
    final actions = useMemoized(() => ValueNotifier<List<Widget>>(const []));
    useEffect(() => actions.dispose, [actions]);
    return VerticalBarScope(
      actions: actions,
      child: GlassBackdrop(
        alignment: Alignment.centerRight,
        child: Row(
          children: [
            const Expanded(
              child: Scaffold(
                appBar: DottoAppBar(
                  title: Text('講義'),
                  actions: [Icon(Icons.tune), Icon(Icons.add)],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: VerticalBarActions(actions: actions),
            ),
          ],
        ),
      ),
    );
  }
}
