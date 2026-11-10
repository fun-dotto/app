import 'package:dotto/domain/entity/screen_layout.dart';
import 'package:dotto/domain/entity/vertical_bar_edge.dart';
import 'package:dotto/presentation/common/tab_item.dart';
import 'package:dotto/presentation/root/root_tab_scaffold.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

Widget _app(ScreenLayout layout) => MaterialApp(
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

  testWidgets('leading 指定のときは左端に縦型タブバーを表示する', (tester) async {
    await tester.pumpWidget(
      _app(
        const ScreenLayout(
          verticalBarEdge: VerticalBarEdge.leading,
          occlusions: [],
        ),
      ),
    );

    expect(find.byType(NavigationBar), findsNothing);
    expect(tester.getTopLeft(find.byType(NavigationRail)).dx, 0);
  });

  testWidgets('trailing 指定のときは右端に縦型タブバーを表示する', (tester) async {
    await tester.pumpWidget(
      _app(
        const ScreenLayout(
          verticalBarEdge: VerticalBarEdge.trailing,
          occlusions: [],
        ),
      ),
    );

    final rail = tester.getRect(find.byType(NavigationRail));
    expect(
      rail.right,
      tester.view.physicalSize.width / tester.view.devicePixelRatio,
    );
  });
}
