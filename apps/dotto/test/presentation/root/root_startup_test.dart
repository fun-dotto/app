import 'dart:async';

import 'package:dotto/application/fetch_app_version_use_case.dart';
import 'package:dotto/data/app_session_repository_impl.dart';
import 'package:dotto/data/notification_interaction_data_source.dart';
import 'package:dotto/data/remote_config_data_source.dart';
import 'package:dotto/domain/entity/flags.dart';
import 'package:dotto/domain/entity/user_preference_keys.dart';
import 'package:dotto/foundation/config/remote_configs.dart';
import 'package:dotto/foundation/log/logger.dart';
import 'package:dotto/presentation/common/feature_flag.dart';
import 'package:dotto/presentation/root/root_app_tutorial_state.dart';
import 'package:dotto/presentation/root/root_initialization_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../helpers/fake_logger.dart';
import '../../helpers/fake_notification_interaction_data_source.dart';
import '../../helpers/fake_remote_config_data_source.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('起動前に読んだフラグをRemote Config初期化後の値で更新する', () async {
    SharedPreferences.setMockInitialValues({});
    final setup = Completer<void>();
    final remoteConfig = FakeRemoteConfigDataSource(
      setupResult: setup.future,
      activatedValues: {Flags.funch.key: true},
    );
    final container = ProviderContainer(
      retry: (_, _) => null,
      overrides: [
        remoteConfigDataSourceProvider.overrideWithValue(remoteConfig),
        notificationInteractionDataSourceProvider.overrideWithValue(
          const FakeNotificationInteractionDataSource(),
        ),
        loggerProvider.overrideWithValue(FakeLogger()),
      ],
    );
    addTearDown(container.dispose);
    final subscription = container.listen(
      featureFlagProvider(Flags.funch),
      (_, _) {},
    );
    addTearDown(subscription.close);
    expect(container.read(featureFlagProvider(Flags.funch)), isFalse);
    final initialization = container.read(
      rootInitializationStateProvider.future,
    );

    setup.complete();
    await initialization;
    await container.pump();

    expect(container.read(featureFlagProvider(Flags.funch)), isTrue);
  });

  test('公開バージョン設定に基づいて更新の必要性を評価する', () async {
    PackageInfo.setMockInitialValues(
      appName: 'Dotto',
      packageName: 'jp.ac.fun.dotto',
      version: '1.0.0',
      buildNumber: '1',
      buildSignature: '',
    );
    final remoteConfig = FakeRemoteConfigDataSource()
      ..values[RemoteConfigs.validAppVersion.key] = '1.0.0'
      ..values[RemoteConfigs.latestAppVersion.key] = '2.0.0'
      ..values[RemoteConfigs.appStorePageUrl.key] = 'https://example.com/app';
    final container = ProviderContainer(
      overrides: [
        remoteConfigDataSourceProvider.overrideWithValue(remoteConfig),
      ],
    );
    addTearDown(container.dispose);

    final version = await container.read(fetchAppVersionUseCaseProvider)();

    expect(version.isValidAppVersion, isTrue);
    expect(version.isLatestAppVersion, isFalse);
    expect(version.currentAppVersion, '1.0.0');
    expect(version.latestAppVersion, '2.0.0');
    expect(version.appStorePageUrl, 'https://example.com/app');
  });

  test('初回起動で未完了のチュートリアルを表示し完了を保存する', () async {
    SharedPreferences.setMockInitialValues({});
    final container = ProviderContainer();
    addTearDown(container.dispose);
    final subscription = container.listen(
      rootAppTutorialStateProvider,
      (_, _) {},
    );
    addTearDown(subscription.close);

    expect(await container.read(rootAppTutorialStateProvider.future), isFalse);
    await container
        .read(rootAppTutorialStateProvider.notifier)
        .onAppTutorialDismissed();

    expect(container.read(rootAppTutorialStateProvider).requireValue, isTrue);
    expect(
      (await SharedPreferences.getInstance()).getBool(
        UserPreferenceKeys.isAppTutorialComplete.key,
      ),
      isTrue,
    );
  });

  test('完了済みのチュートリアルは次回起動時に表示しない', () async {
    SharedPreferences.setMockInitialValues({
      UserPreferenceKeys.isAppTutorialComplete.key: true,
    });
    final container = ProviderContainer();
    addTearDown(container.dispose);

    expect(await container.read(rootAppTutorialStateProvider.future), isTrue);
  });

  test('通知案内を表示してから7日間は再表示しない', () async {
    SharedPreferences.setMockInitialValues({});
    final preferences = SharedPreferences.getInstance();
    final now = DateTime(2026, 10, 8);
    final repository = AppSessionRepositoryImpl(
      preferences,
      now,
      isDebug: false,
    );
    expect(await repository.shouldPromptNotification(), isTrue);

    await repository.recordNotificationPrompt();

    expect(await repository.shouldPromptNotification(), isFalse);
    expect(
      await AppSessionRepositoryImpl(
        preferences,
        now.add(const Duration(days: 6)),
        isDebug: false,
      ).shouldPromptNotification(),
      isFalse,
    );
    expect(
      await AppSessionRepositoryImpl(
        preferences,
        now.add(const Duration(days: 7)),
        isDebug: false,
      ).shouldPromptNotification(),
      isTrue,
    );
  });
}
