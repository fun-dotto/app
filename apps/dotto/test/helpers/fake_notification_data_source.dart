import 'package:dotto/data/notification_data_source.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

/// 指定した [settings] を OS の通知設定として返すフェイク。
final class FakeNotificationDataSource implements NotificationDataSource {
  new(this.settings);

  NotificationSettings settings;

  @override
  Future<NotificationSettings> fetchSettings() async => settings;

  /// OS の通知設定画面を開いた回数。
  int openedSettingsCount = 0;

  @override
  Future<void> openSystemSettings() async => openedSettingsCount++;
}

NotificationSettings notificationSettings({
  required AuthorizationStatus authorizationStatus,
  AppleNotificationSetting alert = AppleNotificationSetting.enabled,
}) => NotificationSettings(
  alert: alert,
  announcement: AppleNotificationSetting.notSupported,
  authorizationStatus: authorizationStatus,
  badge: AppleNotificationSetting.notSupported,
  carPlay: AppleNotificationSetting.notSupported,
  lockScreen: AppleNotificationSetting.notSupported,
  notificationCenter: AppleNotificationSetting.notSupported,
  showPreviews: AppleShowPreviewSetting.notSupported,
  timeSensitive: AppleNotificationSetting.notSupported,
  criticalAlert: AppleNotificationSetting.notSupported,
  sound: AppleNotificationSetting.notSupported,
  providesAppNotificationSettings: AppleNotificationSetting.notSupported,
);
