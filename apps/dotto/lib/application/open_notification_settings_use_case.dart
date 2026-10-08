import 'package:dotto/data/notification_setting_repository_impl.dart';
import 'package:dotto/domain/notification_setting_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'open_notification_settings_use_case.g.dart';

final class OpenNotificationSettingsUseCase {
  const new(this._repository);

  final NotificationSettingRepository _repository;

  Future<void> call() => _repository.openSystemSettings();
}

@riverpod
OpenNotificationSettingsUseCase openNotificationSettingsUseCase(Ref ref) =>
    OpenNotificationSettingsUseCase(
      ref.watch(notificationSettingRepositoryProvider),
    );
