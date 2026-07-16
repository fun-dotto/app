import 'package:dotto/domain/breaking_announcement.dart';
import 'package:dotto/domain/config.dart';
import 'package:dotto/domain/remote_config_keys.dart';
import 'package:dotto/helper/remote_config_helper.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'config_controller.g.dart';

@Riverpod(keepAlive: true)
Config config(Ref ref) {
  final remoteConfigRepository = ref.watch(remoteConfigHelperProvider);
  final validAppVersion = remoteConfigRepository.getString(
    RemoteConfigKeys.validAppVersion,
  );
  final latestAppVersion = remoteConfigRepository.getString(
    RemoteConfigKeys.latestAppVersion,
  );
  final isUnderMaintenance = remoteConfigRepository.getBool(
    RemoteConfigKeys.isUnderMaintenance,
  );
  final feedbackFormUrl = remoteConfigRepository.getString(
    RemoteConfigKeys.feedbackFormUrl,
  );
  final termsOfServiceUrl = remoteConfigRepository.getString(
    RemoteConfigKeys.termsOfServiceUrl,
  );
  final privacyPolicyUrl = remoteConfigRepository.getString(
    RemoteConfigKeys.privacyPolicyUrl,
  );
  final appStorePageUrl = remoteConfigRepository.getString(
    RemoteConfigKeys.appStorePageUrl,
  );
  final officialCalendarPdfUrl = remoteConfigRepository.getString(
    RemoteConfigKeys.officialCalendarPdfUrl,
  );
  final timetable1PdfUrl = remoteConfigRepository.getString(
    RemoteConfigKeys.timetable1PdfUrl,
  );
  final timetable2PdfUrl = remoteConfigRepository.getString(
    RemoteConfigKeys.timetable2PdfUrl,
  );
  final dottoWebUrl = remoteConfigRepository.getString(
    RemoteConfigKeys.dottoWebUrl,
  );
  final macSupportDeskUrl = remoteConfigRepository.getString(
    RemoteConfigKeys.macSupportDeskUrl,
  );

  final breakingAnnouncementJson = remoteConfigRepository.getJSON(
    RemoteConfigKeys.breakingAnnouncement,
  );
  final breakingAnnouncementTitle = _asStringOrNull(
    breakingAnnouncementJson['title'],
  );
  final breakingAnnouncementUrl = _asStringOrNull(
    breakingAnnouncementJson['url'],
  );
  final breakingAnnouncementIsExternal = _asBoolOrNull(
    breakingAnnouncementJson['is_external'],
  );
  BreakingAnnouncement? breakingAnnouncement;
  if (breakingAnnouncementTitle != null &&
      breakingAnnouncementUrl != null &&
      breakingAnnouncementIsExternal != null) {
    breakingAnnouncement = BreakingAnnouncement(
      title: breakingAnnouncementTitle,
      url: breakingAnnouncementUrl,
      isExternal: breakingAnnouncementIsExternal,
    );
  }

  return Config(
    validAppVersion: validAppVersion,
    latestAppVersion: latestAppVersion,
    isUnderMaintenance: isUnderMaintenance,
    feedbackFormUrl: feedbackFormUrl,
    termsOfServiceUrl: termsOfServiceUrl,
    privacyPolicyUrl: privacyPolicyUrl,
    appStorePageUrl: appStorePageUrl,
    officialCalendarPdfUrl: officialCalendarPdfUrl,
    timetable1PdfUrl: timetable1PdfUrl,
    timetable2PdfUrl: timetable2PdfUrl,
    breakingAnnouncement: breakingAnnouncement,
    dottoWebUrl: dottoWebUrl,
    macSupportDeskUrl: macSupportDeskUrl,
  );
}

String? _asStringOrNull(Object? value) {
  return value is String ? value : null;
}

bool? _asBoolOrNull(Object? value) {
  return value is bool ? value : null;
}
