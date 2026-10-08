import 'package:dotto/data/notification_data_source_impl.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'notification_data_source.g.dart';

@Riverpod(keepAlive: true)
NotificationDataSource notificationDataSource(Ref ref) =>
    const NotificationDataSourceImpl();

/// OS の通知設定へのアクセスを担う。
abstract interface class NotificationDataSource {
  Future<NotificationSettings> fetchSettings();

  Future<void> openSystemSettings();
}
