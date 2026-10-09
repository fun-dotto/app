import 'package:dotto/application/fetch_registered_timetable_use_case.dart';
import 'package:dotto/domain/entity/timetable_item.dart';
import 'package:dotto/domain/entity/timetable_semester.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'course_registration_state.g.dart';

@riverpod
final class CourseRegistrationState extends _$CourseRegistrationState {
  @override
  Future<Map<TimetableSemester, List<TimetableItem>>> build() =>
      ref.watch(fetchRegisteredTimetableUseCaseProvider)();

  Future<void> refresh() async {
    state = const AsyncLoading();
    final next = await AsyncValue.guard(
      () => ref.read(fetchRegisteredTimetableUseCaseProvider)(),
    );
    if (ref.mounted) state = next;
  }
}
