import 'package:dotto/domain/entity/screen_layout.dart';
import 'package:dotto/domain/entity/vertical_bar_edge.dart';
import 'package:dotto/presentation/common/tab_item.dart';
import 'package:dotto/presentation/root/root_tab_scaffold.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

// システムが縦バー用に確保する端の帯は、セーフエリアとして渡される。
Widget _app(ScreenLayout layout, {EdgeInsets padding = EdgeInsets.zero}) =>
    MaterialApp(
      builder: (context, child) => MediaQuery(
        data: MediaQueryData(size: const Size(800, 1000), padding: padding),
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

void main() {
  testWidgets('縦型バーの指定がなければ下部にタブバーを表示する', (tester) async {
    await tester.pumpWidget(_app(ScreenLayout.standard));

    expect(find.byType(NavigationBar), findsOneWidget);
    expect(find.byType(NavigationRail), findsNothing);
  });

  testWidgets('leading 指定のときは左端の帯に縦型タブバーを表示する', (tester) async {
    await tester.pumpWidget(
      _app(
        const ScreenLayout(
          verticalBarEdge: VerticalBarEdge.leading,
          occlusions: [],
        ),
        padding: const EdgeInsets.only(left: 80),
      ),
    );

    final rail = tester.getRect(find.byType(NavigationRail));
    expect(find.byType(NavigationBar), findsNothing);
    expect(rail.left, 0);
    expect(rail.width, 80);
  });

  testWidgets('trailing 指定のときは右端の帯に縦型タブバーを表示する', (tester) async {
    await tester.pumpWidget(
      _app(
        const ScreenLayout(
          verticalBarEdge: VerticalBarEdge.trailing,
          occlusions: [],
        ),
        padding: const EdgeInsets.only(right: 80),
      ),
    );

    final rail = tester.getRect(find.byType(NavigationRail));
    expect(rail.right, 800);
    expect(rail.width, 80);
  });

  testWidgets('帯が確保されていなければ縦型バーでも下部に表示する', (tester) async {
    await tester.pumpWidget(
      _app(
        const ScreenLayout(
          verticalBarEdge: VerticalBarEdge.trailing,
          occlusions: [],
        ),
      ),
    );

    expect(find.byType(NavigationBar), findsOneWidget);
  });
}
