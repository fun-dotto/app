import 'package:dotto/application/fetch_personal_timetable_use_case.dart';
import 'package:dotto/domain/entity/personal_timetable_day.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'course_state.g.dart';

@riverpod
final class CourseState extends _$CourseState {
  @override
  Future<List<PersonalTimetableDay>> build() =>
      ref.watch(fetchPersonalTimetableUseCaseProvider)();

  Future<void> refresh() async {
    final next = await AsyncValue.guard(
      () => ref.read(fetchPersonalTimetableUseCaseProvider)(),
    );
    if (ref.mounted) state = next;
  }
}
