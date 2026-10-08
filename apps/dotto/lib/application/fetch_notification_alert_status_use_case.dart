import 'package:dotto/data/notification_setting_repository_impl.dart';
import 'package:dotto/domain/entity/notification_alert_status.dart';
import 'package:dotto/domain/repository/notification_setting_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'fetch_notification_alert_status_use_case.g.dart';

final class FetchNotificationAlertStatusUseCase {
  const new(this._repository);

  final NotificationSettingRepository _repository;

  Future<NotificationAlertStatus> call() => _repository.fetchAlertStatus();
}

@riverpod
FetchNotificationAlertStatusUseCase fetchNotificationAlertStatusUseCase(
  Ref ref,
) => FetchNotificationAlertStatusUseCase(
  ref.watch(notificationSettingRepositoryProvider),
);
