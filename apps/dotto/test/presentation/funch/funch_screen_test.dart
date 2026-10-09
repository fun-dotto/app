import 'package:dotto/data/funch_data_source.dart';
import 'package:dotto/helper/date_formatter.dart';
import 'package:dotto/presentation/common/error_view.dart';
import 'package:dotto/presentation/funch/funch_screen.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:material_ui/material_ui.dart';

import '../../helpers/fake_funch_data_source.dart';

final DateTime _today = () {
  final now = DateTime.now();
  return DateTime(now.year, now.month, now.day);
}();

Future<void> _pump(WidgetTester tester, FakeFunchDataSource dataSource) async {
  await tester.pumpWidget(
    ProviderScope(
      retry: (_, _) => null,
      overrides: [funchDataSourceProvider.overrideWithValue(dataSource)],
      child: const MaterialApp(home: FunchScreen()),
    ),
  );
  await tester.pumpAndSettle();
}

/// テストの [MaterialApp] は既定の英語ロケールで日付を表示する。
String _dateLabel(DateTime date) =>
    DateFormatter.dateWithDayOfWeek(date, locale: 'en_US');

Future<void> _selectCategory(WidgetTester tester, String label) async {
  await tester.tap(find.text(label));
  await tester.pumpAndSettle();
}

void main() {
  setUpAll(() => initializeDateFormatting('ja'));

  testWidgets('今日のセットメニューを価格とカロリー付きで表示する', (tester) async {
    await _pump(tester, FakeFunchDataSource(days: [_today]));

    expect(find.text('月次メニュー'), findsOneWidget);
    expect(find.text('¥400'), findsOneWidget);
    expect(find.text('500kcal'), findsOneWidget);
  });

  testWidgets('麺類はサイズごとの価格を表示する', (tester) async {
    await _pump(tester, FakeFunchDataSource(days: [_today]));

    await _selectCategory(tester, '麺');

    expect(find.text('日次メニュー'), findsOneWidget);
    expect(find.text('大'), findsOneWidget);
    expect(find.text('¥400'), findsOneWidget);
    expect(find.text('中'), findsOneWidget);
    expect(find.text('¥300'), findsOneWidget);
    expect(find.text('小'), findsNothing);
  });

  testWidgets('オリジナルメニューもカテゴリーに表示する', (tester) async {
    await _pump(tester, FakeFunchDataSource(days: [_today]));

    await _selectCategory(tester, 'デザート');

    expect(find.text('オリジナル'), findsOneWidget);
  });

  testWidgets('カテゴリーにメニューがなければその旨を表示する', (tester) async {
    await _pump(tester, FakeFunchDataSource(days: [_today]));

    await _selectCategory(tester, '副菜');

    expect(find.text('このカテゴリーのメニューはありません。'), findsOneWidget);
  });

  testWidgets('その日のメニューがなければその旨を表示する', (tester) async {
    await _pump(tester, FakeFunchDataSource(days: []));

    expect(find.text('情報が見つかりません'), findsOneWidget);
  });

  testWidgets('日付を選ぶとその日のメニューを表示する', (tester) async {
    final tomorrow = _today.add(const Duration(days: 1));
    await _pump(tester, FakeFunchDataSource(days: [_today, tomorrow]));
    await _selectCategory(tester, '麺');

    await tester.tap(find.text(_dateLabel(_today)));
    await tester.pumpAndSettle();
    await tester.tap(find.text(_dateLabel(tomorrow)));
    await tester.pumpAndSettle();

    expect(find.text(_dateLabel(tomorrow)), findsOneWidget);
    expect(find.text('日次メニュー'), findsOneWidget);
  });

  testWidgets('メニューの取得に失敗したらエラーを表示する', (tester) async {
    await _pump(tester, FakeFunchDataSource(days: [_today], shouldFail: true));

    expect(find.byType(ErrorView), findsOneWidget);
  });
}
