import 'package:dotto/domain/entity/screen_layout.dart';
import 'package:dotto/domain/entity/vertical_bar_edge.dart';
import 'package:dotto/domain/service/vertical_tab_bar_service.dart';
import 'package:dotto/presentation/common/tab_item.dart';
import 'package:flutter/services.dart';
import 'package:material_ui/material_ui.dart';

const _verticalBarWidth = 80.0;

// タブが収まらないほど低い範囲しか取れないときは、下部タブに戻す。
const _minimumVerticalBarHeight = 360.0;

// カメラなどの隠れる領域とタブバーが近づきすぎないようにする余白。
const _occlusionMargin = 8.0;

const _verticalTabBarService = VerticalTabBarService();

/// タブバーを備えたルートの Scaffold。
///
/// [screenLayout] が縦型バーを推奨し、かつ隠れる領域を避けて置けるときは
/// 画面の端に縦並びで、それ以外は下部に横並びで表示する。
final class RootTabScaffold extends StatelessWidget {
  const new({
    required this.body,
    required this.tabs,
    required this.selectedIndex,
    required this.onDestinationSelected,
    required this.screenLayout,
    super.key,
  });

  final Widget body;
  final List<TabItem> tabs;
  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;
  final ScreenLayout screenLayout;

  @override
  Widget build(BuildContext context) {
    final backgroundColor = switch (appFlavor) {
      'dev' => Colors.blue.withValues(alpha: 0.15),
      'stg' => Colors.orange.withValues(alpha: 0.15),
      _ => null,
    };
    final placement = _verticalPlacement(context);
    if (placement == null) {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        body: body,
        bottomNavigationBar: NavigationBar(
          backgroundColor: backgroundColor,
          onDestinationSelected: onDestinationSelected,
          selectedIndex: selectedIndex,
          destinations: [
            for (final tab in tabs)
              NavigationDestination(
                selectedIcon: Icon(tab.selectedIcon),
                icon: Icon(tab.icon),
                label: tab.label,
              ),
          ],
        ),
      );
    }

    final mediaQuery = MediaQuery.of(context);
    final isLeft = placement.isLeft;
    // タブバーが占める側の安全領域は、本体ではなくタブバー側で扱う。
    final verticalBar = SafeArea(
      top: false,
      bottom: false,
      left: isLeft,
      right: !isLeft,
      child: SizedBox(
        width: _verticalBarWidth,
        child: Padding(
          padding: EdgeInsets.only(
            top: placement.span.top,
            bottom: mediaQuery.size.height - placement.span.bottom,
          ),
          child: NavigationRail(
            backgroundColor: backgroundColor,
            minWidth: _verticalBarWidth,
            groupAlignment: 0,
            labelType: NavigationRailLabelType.all,
            selectedIndex: selectedIndex,
            onDestinationSelected: onDestinationSelected,
            destinations: [
              for (final tab in tabs)
                NavigationRailDestination(
                  selectedIcon: Icon(tab.selectedIcon),
                  icon: Icon(tab.icon),
                  label: Text(tab.label),
                ),
            ],
          ),
        ),
      ),
    );
    final content = Expanded(
      child: MediaQuery.removePadding(
        context: context,
        removeLeft: isLeft,
        removeRight: !isLeft,
        child: body,
      ),
    );
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Row(
        children: isLeft ? [verticalBar, content] : [content, verticalBar],
      ),
    );
  }

  ({bool isLeft, VerticalTabBarSpan span})? _verticalPlacement(
    BuildContext context,
  ) {
    final edge = screenLayout.verticalBarEdge;
    if (edge == null) return null;
    final isLeftToRight = Directionality.of(context) == TextDirection.ltr;
    final isLeft = (edge == VerticalBarEdge.leading) == isLeftToRight;
    final mediaQuery = MediaQuery.of(context);
    final size = mediaQuery.size;
    final span = _verticalTabBarService.place(
      barLeft: isLeft ? 0 : size.width - _verticalBarWidth,
      barWidth: _verticalBarWidth,
      minTop: mediaQuery.padding.top,
      maxBottom: size.height - mediaQuery.padding.bottom,
      occlusions: screenLayout.occlusions,
      margin: _occlusionMargin,
    );
    if (span == null || span.bottom - span.top < _minimumVerticalBarHeight) {
      return null;
    }
    return (isLeft: isLeft, span: span);
  }
}
