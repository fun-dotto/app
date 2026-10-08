import 'package:dotto/domain/entity/subject_summary.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'course_notice.freezed.dart';

/// 予定された授業への変更通知。
@freezed
sealed class CourseNotice with _$CourseNotice {
  const factory cancellation({
    required String id,
    required SubjectSummary subject,
    required DateTime date,
    required int periodNumber,
    required String comment,
  }) = CancellationNotice;
  const factory makeup({
    required String id,
    required SubjectSummary subject,
    required DateTime date,
    required int periodNumber,
    required String comment,
  }) = MakeupNotice;
  const factory roomChange({
    required String id,
    required SubjectSummary subject,
    required DateTime date,
    required int periodNumber,
    required String originalRoomName,
    required String newRoomName,
  }) = RoomChangeNotice;
}
