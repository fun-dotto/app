import 'package:dotto/data/notification_data_source.dart';
import 'package:dotto/domain/entity/notification_alert_status.dart';
import 'package:dotto/presentation/common/notification_alert_status_state.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/fake_notification_data_source.dart';

void main() {
  Future<NotificationAlertStatus> readStatus(NotificationSettings settings) {
    final container = ProviderContainer(
      overrides: [
        notificationDataSourceProvider.overrideWithValue(
          FakeNotificationDataSource(settings),
        ),
      ],
    );
    addTearDown(container.dispose);
    return container.read(notificationAlertStatusStateProvider.future);
  }

  for (final (authorizationStatus, alert, expected) in [
    (
      AuthorizationStatus.authorized,
      AppleNotificationSetting.enabled,
      NotificationAlertStatus.enabled,
    ),
    (
      AuthorizationStatus.authorized,
      AppleNotificationSetting.disabled,
      NotificationAlertStatus.alertDisabled,
    ),
    (
      AuthorizationStatus.provisional,
      AppleNotificationSetting.enabled,
      NotificationAlertStatus.provisional,
    ),
    (
      AuthorizationStatus.denied,
      AppleNotificationSetting.enabled,
      NotificationAlertStatus.denied,
    ),
    (
      AuthorizationStatus.notDetermined,
      AppleNotificationSetting.enabled,
      NotificationAlertStatus.notDetermined,
    ),
  ]) {
    test('通知設定が$authorizationStatus/$alertのとき$expectedになる', () async {
      final status = await readStatus(
        notificationSettings(
          authorizationStatus: authorizationStatus,
          alert: alert,
        ),
      );

      expect(status, expected);
    });
  }
}
