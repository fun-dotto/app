import 'package:dotto/domain/entity/breaking_announcement.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'course_resources.freezed.dart';

/// 講義画面から案内するリンクとPDF資料。
@freezed
abstract class CourseResources with _$CourseResources {
  const factory({
    required String dottoWebUrl,
    required String macSupportDeskUrl,
    required String opinionBoxUrl,
    required String officialCalendarUrl,
    required String springTimetableUrl,
    required String fallTimetableUrl,
    required String hopeUrl,
    required String hopeIconUrl,
    required String studentPortalUrl,
    required String studentPortalIconUrl,
    BreakingAnnouncement? breakingAnnouncement,
  }) = _CourseResources;
}
