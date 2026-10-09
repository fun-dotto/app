// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get login => 'ログイン';

  @override
  String get rootUpdateRequired => 'アップデートが必要です';

  @override
  String get rootLater => 'あとで';

  @override
  String get rootUpdateNow => '今すぐアップデート';

  @override
  String get rootEnableNotifications => '通知を有効にしますか？';

  @override
  String get rootOpenSettings => '設定を開く';

  @override
  String get rootNotificationDenied =>
      '通知が拒否されています。休講・補講・教室変更などのお知らせを受け取るには、設定アプリから通知を許可してください。';

  @override
  String get rootNotificationProvisional =>
      '現在は静かな配信のみ許可されています。休講・補講・教室変更などのお知らせをバナーやサウンドで受け取るには、設定アプリから通知を許可してください。';

  @override
  String get rootNotificationAlertDisabled =>
      '通知バナーが無効になっています。休講・補講・教室変更などのお知らせを目立つ形で受け取るには、設定アプリから通知バナーを有効にしてください。';

  @override
  String rootVersionComparison(String currentVersion, String latestVersion) {
    return '現在のバージョン: $currentVersion\n最新バージョン: $latestVersion';
  }
}
