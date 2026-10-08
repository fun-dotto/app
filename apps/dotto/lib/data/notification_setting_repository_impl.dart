import 'package:dotto/data/notification_data_source.dart';
import 'package:dotto/domain/notification_alert_status.dart';
import 'package:dotto/domain/notification_setting_repository.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'notification_setting_repository_impl.g.dart';

@riverpod
NotificationSettingRepository notificationSettingRepository(Ref ref) =>
    NotificationSettingRepositoryImpl(
      ref.watch(notificationDataSourceProvider),
    );

final class NotificationSettingRepositoryImpl
    implements NotificationSettingRepository {
  const new(this._dataSource);

  final NotificationDataSource _dataSource;

  @override
  Future<NotificationAlertStatus> fetchAlertStatus() async {
    final settings = await _dataSource.fetchSettings();
    return switch (settings.authorizationStatus) {
      AuthorizationStatus.notDetermined =>
        NotificationAlertStatus.notDetermined,
      AuthorizationStatus.provisional => NotificationAlertStatus.provisional,
      AuthorizationStatus.authorized
          when settings.alert == AppleNotificationSetting.disabled =>
        NotificationAlertStatus.alertDisabled,
      AuthorizationStatus.authorized => NotificationAlertStatus.enabled,
      AuthorizationStatus.denied ||
      AuthorizationStatus.deniedPermanently => NotificationAlertStatus.denied,
    };
  }

  @override
  Future<void> openSystemSettings() => _dataSource.openSystemSettings();
}
