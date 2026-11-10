import 'package:dotto/domain/entity/screen_layout.dart';
import 'package:dotto/domain/entity/vertical_bar_edge.dart';
import 'package:dotto/domain/service/vertical_tab_bar_service.dart';
import 'package:dotto/presentation/common/tab_item.dart';
import 'package:flutter/services.dart';
import 'package:material_ui/material_ui.dart';

// タブが収まらないほど低い範囲しか取れないときは、下部タブに戻す。
const _minimumVerticalBarHeight = 360.0;

// カメラなどの隠れる領域とタブバーが近づきすぎないようにする余白。
const _occlusionMargin = 8.0;

const _verticalTabBarService = VerticalTabBarService();

/// タブバーを備えたルートの Scaffold。
///
/// [screenLayout] が縦型バーを推奨し、かつ隠れる領域を避けて置けるときは
/// システムが縦バー用に確保した端の帯に縦並びで、それ以外は下部に横並びで
/// 表示する。
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

    // 縦型バーはシステムが端のセーフエリアとして確保した帯なので、
    // 本文はその内側に任せ、タブバーを帯に重ねて置く。
    final verticalBar = Positioned(
      left: placement.isLeft ? 0 : null,
      right: placement.isLeft ? null : 0,
      top: placement.span.top,
      bottom: MediaQuery.sizeOf(context).height - placement.span.bottom,
      width: placement.width,
      child: NavigationRail(
        backgroundColor: backgroundColor,
        minWidth: placement.width,
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
    );
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Positioned.fill(child: body),
          verticalBar,
        ],
      ),
    );
  }

  ({bool isLeft, double width, VerticalTabBarSpan span})? _verticalPlacement(
    BuildContext context,
  ) {
    final edge = screenLayout.verticalBarEdge;
    if (edge == null) return null;
    final isLeftToRight = Directionality.of(context) == TextDirection.ltr;
    final isLeft = (edge == VerticalBarEdge.leading) == isLeftToRight;
    final mediaQuery = MediaQuery.of(context);
    final size = mediaQuery.size;
    // システムが縦バー用に確保した帯の幅。
    final width = isLeft ? mediaQuery.padding.left : mediaQuery.padding.right;
    if (width <= 0) return null;
    final span = _verticalTabBarService.place(
      barLeft: isLeft ? 0 : size.width - width,
      barWidth: width,
      minTop: mediaQuery.padding.top,
      maxBottom: size.height - mediaQuery.padding.bottom,
      occlusions: screenLayout.occlusions,
      margin: _occlusionMargin,
    );
    if (span == null || span.bottom - span.top < _minimumVerticalBarHeight) {
      return null;
    }
    return (isLeft: isLeft, width: width, span: span);
  }
}
