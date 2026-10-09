import 'package:dotto/application/service/course_registration_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'register_course_use_case.g.dart';

@riverpod
RegisterCourseUseCase registerCourseUseCase(Ref ref) =>
    RegisterCourseUseCase(ref.watch(courseRegistrationServiceProvider));

final class RegisterCourseUseCase {
  const new(this._service);
  final CourseRegistrationService _service;
  Future<void> call(String subjectId) => _service.register(subjectId);
}
