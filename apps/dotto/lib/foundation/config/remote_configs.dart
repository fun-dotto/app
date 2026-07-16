import 'package:dotto/domain/breaking_announcement.dart';
import 'package:dotto/foundation/config/remote_config.dart';
import 'package:dotto/helper/remote_config_helper.dart';

abstract final class RemoteConfigs {
  /// サポート対象の最小バージョン。
  ///
  /// 現在のアプリバージョンがこの値より小さい場合は強制アップデート対象。
  static const validAppVersion = RemoteConfig<String>(
    key: 'valid_app_version',
    defaultValue: '0.0.0',
    remoteDefaultValue: '0.0.0',
    getValue: _getString,
  );

  /// 最新のアプリバージョン。
  ///
  /// 現在のアプリバージョンがこの値より小さい場合は更新を案内する。
  static const latestAppVersion = RemoteConfig<String>(
    key: 'latest_app_version',
    defaultValue: '0.0.0',
    remoteDefaultValue: '0.0.0',
    getValue: _getString,
  );

  /// メンテナンスモード。
  static const isUnderMaintenance = RemoteConfig<bool>(
    key: 'is_under_maintenance',
    defaultValue: false,
    remoteDefaultValue: false,
    getValue: _getBool,
  );

  /// フィードバックフォームURL。
  static const feedbackFormUrl = RemoteConfig<String>(
    key: 'feedback_form_url',
    defaultValue: 'https://forms.gle/ruo8iBxLMmvScNMFA',
    remoteDefaultValue: 'https://forms.gle/ruo8iBxLMmvScNMFA',
    getValue: _getString,
  );

  /// 利用規約URL。
  static const termsOfServiceUrl = RemoteConfig<String>(
    key: 'terms_of_service_url',
    defaultValue: '',
    remoteDefaultValue: '',
    getValue: _getString,
  );

  /// プライバシーポリシーURL。
  static const privacyPolicyUrl = RemoteConfig<String>(
    key: 'privacy_policy_url',
    defaultValue: '',
    remoteDefaultValue: '',
    getValue: _getString,
  );

  /// アプリストアURL。
  static const appStorePageUrl = RemoteConfig<String>(
    key: 'app_store_page_url',
    defaultValue: 'https://fun-dotto.github.io',
    remoteDefaultValue: 'https://fun-dotto.github.io',
    getValue: _getString,
  );

  /// 学年暦PDF URL。
  static const officialCalendarPdfUrl = RemoteConfig<String>(
    key: 'official_calendar_pdf_url',
    defaultValue:
        'https://fun-dotto.github.io/files/official_calendar_2026.pdf',
    remoteDefaultValue:
        'https://fun-dotto.github.io/files/official_calendar_2026.pdf',
    getValue: _getString,
  );

  /// 時間割（前期）PDF URL。
  static const timetable1PdfUrl = RemoteConfig<String>(
    key: 'timetable_1_pdf_url',
    defaultValue: 'https://fun-dotto.github.io/files/timetable_2026_1.pdf',
    remoteDefaultValue:
        'https://fun-dotto.github.io/files/timetable_2026_1.pdf',
    getValue: _getString,
  );

  /// 時間割（後期）PDF URL。
  static const timetable2PdfUrl = RemoteConfig<String>(
    key: 'timetable_2_pdf_url',
    defaultValue: 'https://fun-dotto.github.io/files/timetable_2026_2.pdf',
    remoteDefaultValue:
        'https://fun-dotto.github.io/files/timetable_2026_2.pdf',
    getValue: _getString,
  );

  /// 緊急告知。
  static const breakingAnnouncement = RemoteConfig<BreakingAnnouncement?>(
    key: 'breaking_announcement',
    defaultValue: null,
    remoteDefaultValue: '',
    getValue: _getBreakingAnnouncement,
  );

  /// Dotto Web URL。
  static const dottoWebUrl = RemoteConfig<String>(
    key: 'dotto_web_url',
    defaultValue: 'https://dotto.web.app',
    remoteDefaultValue: 'https://dotto.web.app',
    getValue: _getString,
  );

  /// MacサポートデスクURL。
  static const macSupportDeskUrl = RemoteConfig<String>(
    key: 'mac_support_desk_url',
    defaultValue: 'https://dotto.web.app/mac',
    remoteDefaultValue: 'https://dotto.web.app/mac',
    getValue: _getString,
  );

  /// Remote Configの既定値登録用。新しいConfigを追加したらここにも追記する。
  static const List<RemoteConfig<Object?>> all = [
    validAppVersion,
    latestAppVersion,
    isUnderMaintenance,
    feedbackFormUrl,
    termsOfServiceUrl,
    privacyPolicyUrl,
    appStorePageUrl,
    officialCalendarPdfUrl,
    timetable1PdfUrl,
    timetable2PdfUrl,
    breakingAnnouncement,
    dottoWebUrl,
    macSupportDeskUrl,
  ];
}

String _getString(RemoteConfigHelper helper, String key) =>
    helper.getString(key);

bool _getBool(RemoteConfigHelper helper, String key) => helper.getBool(key);

BreakingAnnouncement? _getBreakingAnnouncement(
  RemoteConfigHelper helper,
  String key,
) {
  final json = helper.getJSON(key);
  final title = json['title'];
  final url = json['url'];
  final isExternal = json['is_external'];
  if (title is! String || url is! String || isExternal is! bool) return null;

  return BreakingAnnouncement(title: title, url: url, isExternal: isExternal);
}
