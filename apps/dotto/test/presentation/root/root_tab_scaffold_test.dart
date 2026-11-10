import 'package:dotto/domain/entity/occlusion_region.dart';
import 'package:dotto/domain/entity/screen_layout.dart';
import 'package:dotto/domain/entity/vertical_bar_edge.dart';
import 'package:dotto/presentation/common/tab_item.dart';
import 'package:dotto/presentation/root/glass_tab_bar.dart';
import 'package:dotto/presentation/root/root_tab_scaffold.dart';
import 'package:dotto_design_system/style/semantic_color.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

// システムが縦バー用に確保する端の帯は、セーフエリアとして渡される。
Widget _app(ScreenLayout layout, {EdgeInsets padding = EdgeInsets.zero}) =>
    MaterialApp(
      theme: ThemeData(extensions: [SemanticColor.light]),
      builder: (context, child) => MediaQuery(
        data: MediaQuery.of(context).copyWith(padding: padding),
        child: child ?? const SizedBox.shrink(),
      ),
      home: RootTabScaffold(
        body: const SizedBox.expand(key: Key('body')),
        tabs: TabItem.v2,
        selectedIndex: 0,
        onDestinationSelected: (_) {},
        screenLayout: layout,
      ),
    );

void _useLargeScreen(WidgetTester tester) {
  tester.view
    ..physicalSize = const Size(800, 1000)
    ..devicePixelRatio = 1;
  addTearDown(tester.view.reset);
}

Axis _barAxis(WidgetTester tester) =>
    tester.widget<GlassTabBar>(find.byType(GlassTabBar)).axis;

void main() {
  testWidgets('縦型バーの指定がなければ下部に横並びで表示する', (tester) async {
    _useLargeScreen(tester);
    await tester.pumpWidget(_app(ScreenLayout.standard));

    expect(_barAxis(tester), Axis.horizontal);
    expect(tester.getRect(find.byType(GlassTabBar)).bottom, lessThan(1000));
    expect(
      tester.getRect(find.byKey(const Key('body'))).bottom,
      lessThan(1000),
    );
  });

  testWidgets('leading 指定のときは左端の帯に縦並びで表示する', (tester) async {
    _useLargeScreen(tester);
    await tester.pumpWidget(
      _app(
        const ScreenLayout(
          verticalBarEdge: VerticalBarEdge.leading,
          occlusions: [],
        ),
        padding: const EdgeInsets.only(left: 80),
      ),
    );

    final bar = tester.getRect(find.byType(GlassTabBar));
    expect(_barAxis(tester), Axis.vertical);
    expect(bar.left, greaterThanOrEqualTo(0));
    expect(bar.right, lessThanOrEqualTo(80));
    expect(tester.getRect(find.byKey(const Key('body'))).left, 80);
    // 下寄せで表示する。
    expect(bar.bottom, 1000);
  });

  testWidgets('カメラホールと重なる帯では、ホールを避けた範囲の下寄せに表示する', (tester) async {
    _useLargeScreen(tester);
    await tester.pumpWidget(
      _app(
        const ScreenLayout(
          verticalBarEdge: VerticalBarEdge.leading,
          occlusions: [
            OcclusionRegion(left: 0, top: 100, width: 80, height: 40),
          ],
        ),
        padding: const EdgeInsets.only(left: 80),
      ),
    );

    final bar = tester.getRect(find.byType(GlassTabBar));
    // ホールの下側(148〜1000)の下寄せに置かれ、ホールと重ならない。
    expect(bar.top, greaterThanOrEqualTo(148));
    expect(bar.bottom, 1000);
  });

  testWidgets('trailing 指定のときは右端の帯に縦並びで表示する', (tester) async {
    _useLargeScreen(tester);
    await tester.pumpWidget(
      _app(
        const ScreenLayout(
          verticalBarEdge: VerticalBarEdge.trailing,
          occlusions: [],
        ),
        padding: const EdgeInsets.only(right: 80),
      ),
    );

    final bar = tester.getRect(find.byType(GlassTabBar));
    expect(_barAxis(tester), Axis.vertical);
    expect(bar.left, greaterThanOrEqualTo(720));
    expect(bar.right, lessThanOrEqualTo(800));
    // 本文は帯にはみ出さない。
    expect(tester.getRect(find.byKey(const Key('body'))).right, 720);
  });

  testWidgets('このウィンドウの端に縦バーがなければ、左側にタブバーの帯を設ける', (tester) async {
    _useLargeScreen(tester);
    await tester.pumpWidget(
      _app(
        const ScreenLayout(
          verticalBarEdge: VerticalBarEdge.trailing,
          occlusions: [],
        ),
      ),
    );

    final bar = tester.getRect(find.byType(GlassTabBar));
    expect(_barAxis(tester), Axis.vertical);
    expect(bar.left, greaterThanOrEqualTo(0));
    expect(
      tester.getRect(find.byKey(const Key('body'))).left,
      greaterThanOrEqualTo(bar.right),
    );
  });

  testWidgets('縦バーがなくても、分割表示のウィンドウなら左側にタブバーの帯を設ける', (tester) async {
    _useLargeScreen(tester);
    await tester.pumpWidget(
      _app(
        const ScreenLayout(
          verticalBarEdge: null,
          occlusions: [],
          isPartialWindow: true,
        ),
      ),
    );

    final bar = tester.getRect(find.byType(GlassTabBar));
    expect(_barAxis(tester), Axis.vertical);
    expect(
      tester.getRect(find.byKey(const Key('body'))).left,
      greaterThanOrEqualTo(bar.right),
    );
  });
}
