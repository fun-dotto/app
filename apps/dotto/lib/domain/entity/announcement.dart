import 'package:freezed_annotation/freezed_annotation.dart';

part 'announcement.freezed.dart';

@freezed
abstract class Announcement with _$Announcement {
  const factory({
    required String id,
    required String title,
    required DateTime date,
    required String url,
  }) = _Announcement;
}
