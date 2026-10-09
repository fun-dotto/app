import 'package:dotto/data/api_client.dart';
import 'package:dotto/data/auth_data_source.dart';
import 'package:dotto/data/notification_data_source.dart';
import 'package:dotto/data/remote_config_data_source.dart';
import 'package:dotto/domain/entity/auth_account.dart';
import 'package:dotto/foundation/log/logger.dart';
import 'package:dotto/presentation/setting/settings_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:openapi/openapi.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../helpers/fake_auth_data_source.dart';
import '../../helpers/fake_http_client_adapter.dart';
import '../../helpers/fake_logger.dart';
import '../../helpers/fake_notification_data_source.dart';
import '../../helpers/fake_remote_config_data_source.dart';

const _account = AuthAccount(
  id: 'uid',
  name: '未来 太郎',
  email: 'b1000000@fun.ac.jp',
  avatarUrl: '',
);

Future<void> _pumpSettingsScreen(
  WidgetTester tester, {
  AuthAccount? currentAccount,
}) async {
  final adapter = FakeHttpClientAdapter()
    ..on(
      'GET',
      '/v1/users',
      (_) => const FakeResponse(200, {'user': <String, Object?>{}}),
    );
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        apiClientProvider.overrideWithValue(Openapi(dio: fakeDio(adapter))),
        authDataSourceProvider.overrideWithValue(
          FakeAuthDataSource(currentAccount: currentAccount),
        ),
        loggerProvider.overrideWithValue(FakeLogger()),
        remoteConfigDataSourceProvider.overrideWithValue(
          FakeRemoteConfigDataSource(),
        ),
        notificationDataSourceProvider.overrideWithValue(
          FakeNotificationDataSource(
            notificationSettings(
              authorizationStatus: AuthorizationStatus.authorized,
            ),
          ),
        ),
      ],
      child: const MaterialApp(home: SettingsScreen()),
    ),
  );
  await tester.pumpAndSettle();
}

void main() {
  setUp(() {
    PackageInfo.setMockInitialValues(
      appName: 'Dotto',
      packageName: 'jp.ac.fun.dotto',
      version: '1.2.3',
      buildNumber: '45',
      buildSignature: '',
    );
  });

  testWidgets('未ログインのときプロフィール欄を表示しない', (tester) async {
    await _pumpSettingsScreen(tester);

    expect(find.text('あなたの情報'), findsNothing);
  });

  testWidgets('ログイン中はプロフィール欄を表示する', (tester) async {
    await _pumpSettingsScreen(tester, currentAccount: _account);

    expect(find.text('あなたの情報'), findsOneWidget);
    expect(find.text(_account.name), findsOneWidget);
  });

  testWidgets('通知設定の状態を表示する', (tester) async {
    await _pumpSettingsScreen(tester);
    await tester.scrollUntilVisible(find.text('有効'), 100);

    expect(find.text('有効'), findsOneWidget);
  });

  testWidgets('アプリのバージョンを表示する', (tester) async {
    await _pumpSettingsScreen(tester);
    await tester.scrollUntilVisible(find.text('1.2.3 (45)'), 100);

    expect(find.text('1.2.3 (45)'), findsOneWidget);
  });
}
