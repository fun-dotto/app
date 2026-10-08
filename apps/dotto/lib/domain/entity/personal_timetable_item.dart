import 'package:dotto/domain/entity/lecture_status.dart';
import 'package:dotto/domain/entity/period.dart';
import 'package:dotto/domain/entity/subject_summary.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'personal_timetable_item.freezed.dart';

@freezed
abstract class PersonalTimetableItem with _$PersonalTimetableItem {
  const factory({
    required Period period,
    required SubjectSummary subject,
    required LectureStatus lectureStatus,
    required String roomName,
  }) = _PersonalTimetableItem;
}
