import 'package:dotto/application/service/course_registration_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'unregister_course_use_case.g.dart';

@riverpod
UnregisterCourseUseCase unregisterCourseUseCase(Ref ref) =>
    UnregisterCourseUseCase(ref.watch(courseRegistrationServiceProvider));

final class UnregisterCourseUseCase {
  const new(this._service);
  final CourseRegistrationService _service;
  Future<void> call(String subjectId) => _service.unregister(subjectId);
}
