import 'package:dotto/domain/entity/personal_timetable_day.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'course_state.freezed.dart';

@freezed
abstract class CourseState with _$CourseState {
  const factory({
    @Default(<PersonalTimetableDay>[]) List<PersonalTimetableDay> days,
  }) = _CourseState;
}
