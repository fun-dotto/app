import 'package:dotto/application/fetch_notification_alert_status_use_case.dart';
import 'package:dotto/application/open_notification_settings_use_case.dart';
import 'package:dotto/data/notification_data_source.dart';
import 'package:dotto/domain/entity/notification_alert_status.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/fake_notification_data_source.dart';

ProviderContainer _container(FakeNotificationDataSource dataSource) {
  final container = ProviderContainer(
    overrides: [notificationDataSourceProvider.overrideWithValue(dataSource)],
  );
  addTearDown(container.dispose);
  return container;
}

void main() {
  for (final (status, alert, expected) in [
    (
      AuthorizationStatus.notDetermined,
      AppleNotificationSetting.enabled,
      NotificationAlertStatus.notDetermined,
    ),
    (
      AuthorizationStatus.provisional,
      AppleNotificationSetting.enabled,
      NotificationAlertStatus.provisional,
    ),
    (
      AuthorizationStatus.authorized,
      AppleNotificationSetting.disabled,
      NotificationAlertStatus.alertDisabled,
    ),
    (
      AuthorizationStatus.authorized,
      AppleNotificationSetting.enabled,
      NotificationAlertStatus.enabled,
    ),
    (
      AuthorizationStatus.denied,
      AppleNotificationSetting.enabled,
      NotificationAlertStatus.denied,
    ),
  ]) {
    test('OSの通知設定が$status・アラート$alertなら$expectedとする', () async {
      final container = _container(
        FakeNotificationDataSource(
          notificationSettings(authorizationStatus: status, alert: alert),
        ),
      );

      expect(
        await container.read(fetchNotificationAlertStatusUseCaseProvider)(),
        expected,
      );
    });
  }

  test('OSの通知設定画面を開く', () async {
    final dataSource = FakeNotificationDataSource(
      notificationSettings(authorizationStatus: AuthorizationStatus.denied),
    );
    final container = _container(dataSource);

    await container.read(openNotificationSettingsUseCaseProvider)();

    expect(dataSource.openedSettingsCount, 1);
  });
}
