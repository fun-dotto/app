import 'package:dotto/domain/entity/notification_alert_status.dart';
import 'package:dotto/l10n/app_localizations.dart';

extension NotificationAlertStatusLabel on NotificationAlertStatus {
  /// 現在のロケールに合わせた表示名。
  String localizedLabel(AppLocalizations l10n) => switch (this) {
    NotificationAlertStatus.enabled => l10n.notificationStatusEnabled,
    NotificationAlertStatus.provisional => l10n.notificationStatusProvisional,
    NotificationAlertStatus.alertDisabled =>
      l10n.notificationStatusAlertDisabled,
    NotificationAlertStatus.denied => l10n.notificationStatusDenied,
    NotificationAlertStatus.notDetermined =>
      l10n.notificationStatusNotDetermined,
  };
}
