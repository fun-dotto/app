import 'package:dotto/domain/entity/notification_alert_status.dart';

abstract interface class NotificationSettingRepository {
  Future<NotificationAlertStatus> fetchAlertStatus();

  /// OS の通知設定画面を開く。
  Future<void> openSystemSettings();
}
