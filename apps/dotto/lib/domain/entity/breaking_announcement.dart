import 'package:freezed_annotation/freezed_annotation.dart';

part 'breaking_announcement.freezed.dart';

@freezed
abstract class BreakingAnnouncement with _$BreakingAnnouncement {
  const factory({
    required String title,
    required String url,
    required bool isExternal,
  }) = _BreakingAnnouncement;
}
