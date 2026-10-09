import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_version_status.freezed.dart';

@freezed
abstract class AppVersionStatus with _$AppVersionStatus {
  const factory({
    required bool isValidAppVersion,
    required bool isLatestAppVersion,
    required String currentAppVersion,
    required String latestAppVersion,
    required String appStorePageUrl,
  }) = _AppVersionStatus;
}
