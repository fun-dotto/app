import 'package:dotto/application/fetch_notification_alert_status_use_case.dart';
import 'package:dotto/application/open_notification_settings_use_case.dart';
import 'package:dotto/domain/entity/notification_alert_status.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'notification_alert_status_state.g.dart';

@riverpod
final class NotificationAlertStatusState
    extends _$NotificationAlertStatusState {
  @override
  Future<NotificationAlertStatus> build() =>
      ref.watch(fetchNotificationAlertStatusUseCaseProvider)();

  /// OS の通知設定画面を開く。
  ///
  /// 設定変更はアプリ復帰時に再取得して反映するため、ここでは状態を更新しない。
  Future<void> openSystemSettings() =>
      ref.read(openNotificationSettingsUseCaseProvider)();
}
