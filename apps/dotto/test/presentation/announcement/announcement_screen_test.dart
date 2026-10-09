import 'package:dotto/data/api_client.dart';
import 'package:dotto/foundation/log/logger.dart';
import 'package:dotto/presentation/announcement/announcement_detail_screen.dart';
import 'package:dotto/presentation/announcement/announcement_screen.dart';
import 'package:dotto/presentation/common/error_view.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:material_ui/material_ui.dart';
import 'package:openapi/openapi.dart';

import '../../helpers/fake_http_client_adapter.dart';
import '../../helpers/fake_logger.dart';
import '../../helpers/fake_url_launcher.dart';

FakeHttpClientAdapter _adapter() => FakeHttpClientAdapter()
  ..on(
    'GET',
    '/v1/announcements',
    (_) => const FakeResponse(200, {
      'announcements': [
        {
          'id': '1',
          'title': '休講のお知らせ',
          'date': '2026-04-01T00:00:00Z',
          'url': 'https://example.com/1',
        },
      ],
    }),
  );

Future<FakeUrlLauncher> _pump(
  WidgetTester tester,
  Widget screen, {
  FakeHttpClientAdapter? adapter,
}) async {
  final launcher = FakeUrlLauncher()..install(addTearDown);
  await tester.pumpWidget(
    ProviderScope(
      retry: (_, _) => null,
      overrides: [
        apiClientProvider.overrideWithValue(
          Openapi(dio: fakeDio(adapter ?? _adapter())),
        ),
        loggerProvider.overrideWithValue(FakeLogger()),
      ],
      child: MaterialApp(home: screen),
    ),
  );
  await tester.pumpAndSettle();
  return launcher;
}

void main() {
  setUpAll(() => initializeDateFormatting('en_US'));

  testWidgets('お知らせを一覧し、選ぶと本文を開く', (tester) async {
    final launcher = await _pump(tester, const AnnouncementScreen());

    await tester.tap(find.text('休講のお知らせ'));
    await tester.pumpAndSettle();

    expect(launcher.openedUrls, ['https://example.com/1']);
  });

  testWidgets('お知らせ一覧の取得に失敗したらエラーを表示する', (tester) async {
    await _pump(
      tester,
      const AnnouncementScreen(),
      adapter: FakeHttpClientAdapter(),
    );

    expect(find.byType(ErrorView), findsOneWidget);
  });

  testWidgets('お知らせの詳細から本文を開く', (tester) async {
    final launcher = await _pump(
      tester,
      const AnnouncementDetailScreen(id: '1'),
    );
    expect(find.text('休講のお知らせ'), findsOneWidget);

    await tester.tap(find.text('お知らせを開く'));
    await tester.pumpAndSettle();

    expect(launcher.openedUrls, ['https://example.com/1']);
  });

  testWidgets('存在しないお知らせはその旨を表示する', (tester) async {
    await _pump(tester, const AnnouncementDetailScreen(id: 'missing'));

    expect(find.text('お知らせが見つかりませんでした。'), findsOneWidget);
  });

  testWidgets('お知らせ詳細の取得に失敗したらエラーを表示する', (tester) async {
    await _pump(
      tester,
      const AnnouncementDetailScreen(id: '1'),
      adapter: FakeHttpClientAdapter(),
    );

    expect(find.byType(ErrorView), findsOneWidget);
  });
}
