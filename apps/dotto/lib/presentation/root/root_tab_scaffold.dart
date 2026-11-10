import 'package:dotto/domain/entity/screen_layout.dart';
import 'package:dotto/domain/entity/vertical_bar_edge.dart';
import 'package:dotto/domain/service/vertical_tab_bar_service.dart';
import 'package:dotto/presentation/common/tab_item.dart';
import 'package:dotto/presentation/common/vertical_bar_scope.dart';
import 'package:dotto/presentation/root/flavor_accent_color.dart';
import 'package:dotto/presentation/root/glass_surface.dart';
import 'package:dotto/presentation/root/glass_tab_bar.dart';
import 'package:dotto/presentation/root/vertical_bar_actions.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:material_ui/material_ui.dart';

// タブが収まらないほど低い範囲しか取れないときは、下部タブに戻す。
const _minimumVerticalBarHeight = 360.0;

// システムの縦バーがない帯は、タブバーだけが収まればよい。
const _minimumOutsideBarHeight = 280.0;

const _barMargin = 16.0;

// システムの縦バーがないときに、タブバーのために確保する帯の幅。
const double _outsideBarWidth = glassIconOnlyItemExtent + 8 + _barMargin;

// システムの縦バーに表示される時計などは帯の内側へ寄って見えるため、
// タブバーも画面端側の余白を広くして中心を揃える。
const _barOuterMargin = 14.0;
const _barInnerMargin = 2.0;
const _maxBarWidth = 420.0;

// カメラなどの隠れる領域とタブバーが近づきすぎないようにする余白。
const _occlusionMargin = 8.0;

const _verticalTabBarService = VerticalTabBarService();

/// タブバーを備えたルートの Scaffold。
///
/// [screenLayout] が縦型バーを推奨し、かつ隠れる領域を避けて置けるときは
/// システムが縦バー用に確保した端の帯に縦並びで(本文は帯の外)、それ以外は
/// 下部に横並びで表示する。
final class RootTabScaffold extends HookWidget {
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
    final accentColor = flavorAccentColor(appFlavor);
    final verticalBarActions = useMemoized(
      () => ValueNotifier<List<Widget>>(const []),
    );
    final placement = _verticalPlacement(context);
    if (placement == null) {
      // 下部のタブバーは本文の上に浮かべ、本文はその領域まで広げる。
      return Scaffold(
        extendBody: true,
        resizeToAvoidBottomInset: false,
        body: body,
        bottomNavigationBar: SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: _barMargin,
              vertical: _barMargin / 2,
            ),
            // bottomNavigationBar は高さが緩い制約で渡されるため、高さは中身に
            // 合わせないと全体に広がり、本文が潰れてしまう。
            child: Center(
              heightFactor: 1,
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: _maxBarWidth),
                child: GlassTabBar(
                  tabs: tabs,
                  selectedIndex: selectedIndex,
                  onSelected: onDestinationSelected,
                  accentColor: accentColor,
                ),
              ),
            ),
          ),
        ),
      );
    }

    // 縦型バーはシステムが確保した帯なので、そこに表示するのはタブバーのみ。
    // 本文は帯の幅を除いた領域に収め、帯へはみ出さないようにする。
    final verticalBar = SizedBox(
      width: placement.width,
      child: Padding(
        padding: EdgeInsets.only(
          left: placement.isLeft ? _barOuterMargin : _barInnerMargin,
          right: placement.isLeft ? _barInnerMargin : _barOuterMargin,
          top: placement.span.top,
          bottom: MediaQuery.sizeOf(context).height - placement.span.bottom,
        ),
        // カメラホールなどを避けた範囲の中で、ツールバーを上寄せ、タブバーを
        // 下寄せにする。
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // 範囲が低いときは、ツールバーを縮めてあふれないようにする。
            Flexible(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.topCenter,
                child: VerticalBarActions(actions: verticalBarActions),
              ),
            ),
            GlassTabBar(
              tabs: tabs,
              selectedIndex: selectedIndex,
              onSelected: onDestinationSelected,
              accentColor: accentColor,
              axis: Axis.vertical,
            ),
          ],
        ),
      ),
    );
    // 帯の幅は端のセーフエリアと同じなので、本文側ではその分を二重に引かない。
    final content = Expanded(
      child: MediaQuery.removePadding(
        context: context,
        removeLeft: placement.isLeft,
        removeRight: !placement.isLeft,
        child: VerticalBarScope(actions: verticalBarActions, child: body),
      ),
    );
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: placement.isLeft
            ? [verticalBar, content]
            : [content, verticalBar],
      ),
    );
  }

  ({bool isLeft, double width, VerticalTabBarSpan span})? _verticalPlacement(
    BuildContext context,
  ) {
    final edge = screenLayout.verticalBarEdge;
    final isLeftToRight = Directionality.of(context) == TextDirection.ltr;
    if (edge == null) {
      final mediaQuery = MediaQuery.of(context);
      // 横向きや分割表示では、下部だと本文が狭くなるため左側に置く。
      final isLandscape = mediaQuery.size.width > mediaQuery.size.height;
      return screenLayout.isPartialWindow || isLandscape
          ? _placementOutsideSystemBar(mediaQuery, isLeftToRight)
          : null;
    }
    final isLeft = (edge == VerticalBarEdge.leading) == isLeftToRight;
    final mediaQuery = MediaQuery.of(context);
    final size = mediaQuery.size;
    // システムが縦バー用に確保した帯の幅。
    final width = isLeft ? mediaQuery.padding.left : mediaQuery.padding.right;
    if (width <= 0) {
      return _placementOutsideSystemBar(mediaQuery, isLeftToRight);
    }
    final span = _verticalTabBarService.place(
      barLeft: isLeft ? 0 : size.width - width,
      barWidth: width,
      minTop: mediaQuery.padding.top,
      maxBottom: size.height - mediaQuery.padding.bottom,
      occlusions: screenLayout.occlusions,
      margin: _occlusionMargin,
      minHeight: _minimumVerticalBarHeight,
    );
    if (span == null) return null;
    return (isLeft: isLeft, width: width, span: span);
  }

  // システムの縦バーがないときは、ウィンドウの左側へタブバーだけの帯を設ける。
  // 帯はシステムのものではないので、カメラホールなどの隠れる領域は避ける。
  ({bool isLeft, double width, VerticalTabBarSpan span})?
  _placementOutsideSystemBar(MediaQueryData mediaQuery, bool isLeftToRight) {
    final span = _verticalTabBarService.place(
      barLeft: isLeftToRight ? 0 : mediaQuery.size.width - _outsideBarWidth,
      barWidth: _outsideBarWidth,
      minTop: mediaQuery.padding.top,
      maxBottom: mediaQuery.size.height - mediaQuery.padding.bottom,
      occlusions: screenLayout.occlusions,
      margin: _occlusionMargin,
      minHeight: _minimumOutsideBarHeight,
    );
    if (span == null) return null;
    return (isLeft: isLeftToRight, width: _outsideBarWidth, span: span);
  }
}
