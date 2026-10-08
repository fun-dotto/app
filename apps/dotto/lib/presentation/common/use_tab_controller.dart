import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:material_ui/material_ui.dart';

/// 自動で破棄される [TabController] を生成する Hook。
///
/// `flutter_hooks` の `useTabController` は `flutter/material` の [TabController] を返し、
/// `material_ui` の [TabBar] などに渡せないため、`material_ui` 版として定義する。
TabController useTabController({
  required int initialLength,
  Duration? animationDuration = kTabScrollDuration,
  TickerProvider? vsync,
  int initialIndex = 0,
  List<Object?>? keys,
}) {
  return use(
    _TabControllerHook(
      vsync: vsync ?? useSingleTickerProvider(keys: keys),
      length: initialLength,
      initialIndex: initialIndex,
      animationDuration: animationDuration,
      keys: keys,
    ),
  );
}

final class _TabControllerHook extends Hook<TabController> {
  const new({
    required this.length,
    required this.vsync,
    required this.initialIndex,
    required this.animationDuration,
    super.keys,
  });

  final int length;
  final TickerProvider vsync;
  final int initialIndex;
  final Duration? animationDuration;

  @override
  HookState<TabController, Hook<TabController>> createState() =>
      _TabControllerHookState();
}

final class _TabControllerHookState
    extends HookState<TabController, _TabControllerHook> {
  late final TabController _controller = TabController(
    length: hook.length,
    initialIndex: hook.initialIndex,
    animationDuration: hook.animationDuration,
    vsync: hook.vsync,
  );

  @override
  TabController build(BuildContext context) => _controller;

  @override
  void dispose() => _controller.dispose();

  @override
  String get debugLabel => 'useTabController';
}
