enum NotificationAlertStatus {
  enabled,
  provisional,
  alertDisabled,
  denied,
  notDetermined;

  bool get isProminentEnabled => this == NotificationAlertStatus.enabled;

  bool get shouldPromptUser => switch (this) {
    NotificationAlertStatus.denied ||
    NotificationAlertStatus.provisional ||
    NotificationAlertStatus.alertDisabled => true,
    NotificationAlertStatus.enabled ||
    NotificationAlertStatus.notDetermined => false,
  };

  String get label => switch (this) {
    NotificationAlertStatus.enabled => '有効',
    NotificationAlertStatus.provisional => '静かな配信',
    NotificationAlertStatus.alertDisabled => 'バナー無効',
    NotificationAlertStatus.denied => '拒否',
    NotificationAlertStatus.notDetermined => '未設定',
  };
}
