import 'package:dotto/data/github_api_client.dart';
import 'package:dotto/foundation/log/logger.dart';
import 'package:dotto/presentation/common/error_view.dart';
import 'package:dotto/presentation/github_contributor/github_contributor_screen.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import '../../helpers/fake_http_client_adapter.dart';
import '../../helpers/fake_logger.dart';
import '../../helpers/fake_url_launcher.dart';

Future<FakeUrlLauncher> _pump(
  WidgetTester tester,
  FakeHttpClientAdapter adapter,
) async {
  final launcher = FakeUrlLauncher()..install(addTearDown);
  await tester.pumpWidget(
    ProviderScope(
      retry: (_, _) => null,
      overrides: [
        gitHubApiClientProvider.overrideWithValue(fakeDio(adapter)),
        loggerProvider.overrideWithValue(FakeLogger()),
      ],
      child: const MaterialApp(home: GitHubContributorScreen()),
    ),
  );
  await tester.pumpAndSettle();
  return launcher;
}

void main() {
  testWidgets('開発者を一覧し、選ぶとプロフィールを開く', (tester) async {
    final adapter = FakeHttpClientAdapter()
      ..on(
        'GET',
        '/repos/fun-dotto/dotto/contributors',
        (_) => const FakeResponse(200, [
          {
            'id': 1,
            'login': 'alice',
            'avatar_url': 'https://example.com/alice.png',
            'html_url': 'https://github.com/alice',
            'contributions': 10,
          },
        ]),
      );
    final launcher = await _pump(tester, adapter);
    // テスト環境では画像を取得できないため、アバターの読み込み失敗は無視する
    tester.takeException();

    await tester.tap(find.text('alice'));
    await tester.pumpAndSettle();

    expect(launcher.openedUrls, ['https://github.com/alice']);
  });

  testWidgets('取得に失敗したらエラーを表示する', (tester) async {
    await _pump(tester, FakeHttpClientAdapter());

    expect(find.byType(ErrorView), findsOneWidget);
  });
}
