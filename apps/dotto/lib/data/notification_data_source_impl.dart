import 'package:app_settings/app_settings.dart';
import 'package:dotto/data/notification_data_source.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

final class NotificationDataSourceImpl implements NotificationDataSource {
  const new();

  @override
  Future<NotificationSettings> fetchSettings() =>
      FirebaseMessaging.instance.getNotificationSettings();

  @override
  Future<void> openSystemSettings() =>
      AppSettings.openAppSettings(type: AppSettingsType.notification);
}
