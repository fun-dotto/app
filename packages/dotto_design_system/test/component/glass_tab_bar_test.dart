import 'package:dotto_design_system/component/glass_tab_bar.dart';
import 'package:dotto_design_system/style/semantic_color.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

const _course = GlassTabBarItem(
  label: '講義',
  icon: Icons.description_outlined,
  selectedIcon: Icons.description,
);
const _map = GlassTabBarItem(
  label: 'マップ',
  icon: Icons.map_outlined,
  selectedIcon: Icons.map,
);
const _bus = GlassTabBarItem(
  label: 'バス',
  icon: Icons.directions_bus_outlined,
  selectedIcon: Icons.directions_bus,
);
const List<GlassTabBarItem> _tabs = [_course, _map, _bus];

const _accent = Color(0xFF123456);

Widget _app({
  required int selectedIndex,
  ValueChanged<int>? onSelected,
  Axis axis = Axis.horizontal,
  Alignment alignment = Alignment.bottomCenter,
}) => MaterialApp(
  theme: ThemeData(extensions: [SemanticColor.light]),
  home: Scaffold(
    body: Align(
      alignment: alignment,
      child: GlassTabBar(
        tabs: _tabs,
        selectedIndex: selectedIndex,
        onSelected: onSelected ?? (_) {},
        accentColor: _accent,
        axis: axis,
      ),
    ),
  ),
);

Color? _iconColor(WidgetTester tester, IconData icon) =>
    tester.widget<Icon>(find.byIcon(icon)).color;

Color? _labelColor(WidgetTester tester, String label) =>
    tester.widget<Text>(find.text(label)).style?.color;

void main() {
  testWidgets('選択中のアイコンだけをアクセントカラーで塗る', (tester) async {
    await tester.pumpWidget(_app(selectedIndex: 0));

    expect(_iconColor(tester, _course.selectedIcon), _accent);
    expect(_iconColor(tester, _map.icon), isNot(_accent));
    expect(_iconColor(tester, _bus.icon), isNot(_accent));
  });

  testWidgets('選択中のラベルだけをアクセントカラーで塗る', (tester) async {
    await tester.pumpWidget(_app(selectedIndex: 0));

    expect(_labelColor(tester, _course.label), _accent);
    expect(_labelColor(tester, _map.label), isNot(_accent));
  });

  testWidgets('タブをタップすると選択された位置を通知する', (tester) async {
    int? selected;
    await tester.pumpWidget(
      _app(selectedIndex: 0, onSelected: (index) => selected = index),
    );

    await tester.tap(find.text(_bus.label));

    expect(selected, _tabs.indexOf(_bus));
  });

  testWidgets('縦並びではラベルを表示せず、長押しで表示する', (tester) async {
    await tester.pumpWidget(_app(selectedIndex: 0, axis: Axis.vertical));

    expect(find.text(_bus.label), findsNothing);

    await tester.longPress(find.byIcon(_bus.icon));
    await tester.pumpAndSettle();

    expect(find.text(_bus.label), findsOneWidget);
  });

  testWidgets('左端の縦バーではラベルを右側に表示する', (tester) async {
    await tester.pumpWidget(
      _app(
        selectedIndex: 0,
        axis: Axis.vertical,
        alignment: Alignment.bottomLeft,
      ),
    );
    final icon = find.byIcon(_bus.icon);
    final iconRect = tester.getRect(icon);

    await tester.longPress(icon);
    await tester.pumpAndSettle();

    final label = tester.getRect(find.text(_bus.label));
    expect(label.left, greaterThan(iconRect.right));
  });

  testWidgets('右端の縦バーではラベルを左側に表示する', (tester) async {
    await tester.pumpWidget(
      _app(
        selectedIndex: 0,
        axis: Axis.vertical,
        alignment: Alignment.bottomRight,
      ),
    );
    final icon = find.byIcon(_bus.icon);
    final iconRect = tester.getRect(icon);

    await tester.longPress(icon);
    await tester.pumpAndSettle();

    final label = tester.getRect(find.text(_bus.label));
    expect(label.right, lessThan(iconRect.left));
  });
}
