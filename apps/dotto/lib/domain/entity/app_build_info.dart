import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_build_info.freezed.dart';

@freezed
abstract class AppBuildInfo with _$AppBuildInfo {
  const factory({required String version, required String buildNumber}) =
      _AppBuildInfo;
}
