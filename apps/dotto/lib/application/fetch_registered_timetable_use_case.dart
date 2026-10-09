import 'package:dotto/application/service/course_registration_service.dart';
import 'package:dotto/domain/entity/timetable_item.dart';
import 'package:dotto/domain/entity/timetable_semester.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'fetch_registered_timetable_use_case.g.dart';

@riverpod
FetchRegisteredTimetableUseCase fetchRegisteredTimetableUseCase(Ref ref) =>
    FetchRegisteredTimetableUseCase(
      ref.watch(courseRegistrationServiceProvider),
    );

final class FetchRegisteredTimetableUseCase {
  const new(this._service);
  final CourseRegistrationService _service;
  Future<Map<TimetableSemester, List<TimetableItem>>> call() =>
      _service.fetchTimetable();
}
