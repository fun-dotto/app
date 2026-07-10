import 'package:freezed_annotation/freezed_annotation.dart';

part 'root_app_version.freezed.dart';

@freezed
abstract class RootAppVersion with _$RootAppVersion {
  const factory RootAppVersion({
    required bool isValidAppVersion,
    required bool isLatestAppVersion,
    required String currentAppVersion,
    required String latestAppVersion,
    required String appStorePageUrl,
  }) = _RootAppVersion;
}
