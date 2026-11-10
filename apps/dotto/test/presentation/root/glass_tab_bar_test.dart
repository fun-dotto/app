import 'package:dotto/presentation/common/tab_item.dart';
import 'package:dotto/presentation/root/glass_tab_bar.dart';
import 'package:dotto_design_system/style/semantic_color.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

const _accent = Color(0xFF123456);

Widget _app({required int selectedIndex, ValueChanged<int>? onSelected}) =>
    MaterialApp(
      theme: ThemeData(extensions: [SemanticColor.light]),
      home: Scaffold(
        body: Align(
          alignment: Alignment.bottomCenter,
          child: GlassTabBar(
            tabs: TabItem.v2,
            selectedIndex: selectedIndex,
            onSelected: onSelected ?? (_) {},
            accentColor: _accent,
          ),
        ),
      ),
    );

Color? _iconColor(WidgetTester tester, IconData icon) =>
    tester.widget<Icon>(find.byIcon(icon)).color;

void main() {
  testWidgets('選択中のアイコンだけをアクセントカラーで塗る', (tester) async {
    await tester.pumpWidget(_app(selectedIndex: 0));

    expect(_iconColor(tester, TabItem.course.selectedIcon), _accent);
    expect(_iconColor(tester, TabItem.map.icon), isNot(_accent));
    expect(_iconColor(tester, TabItem.bus.icon), isNot(_accent));
  });

  testWidgets('タブをタップすると選択された位置を通知する', (tester) async {
    int? selected;
    await tester.pumpWidget(
      _app(selectedIndex: 0, onSelected: (index) => selected = index),
    );

    await tester.tap(find.text(TabItem.bus.label));

    expect(selected, TabItem.v2.indexOf(TabItem.bus));
  });
}
