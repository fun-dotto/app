import 'package:connectrpc/connect.dart';
import 'package:dotto/data/api_client.dart';
import 'package:dotto/data/app_api_mapper.dart';
import 'package:dotto/data/domain_error_mapper.dart';
import 'package:dotto/domain/entity/course_registration.dart';
import 'package:dotto/domain/entity/domain_error.dart';
import 'package:dotto/domain/entity/semester.dart';
import 'package:dotto/domain/repository/course_registration_repository.dart';
import 'package:dotto_app_api/app/v1/course_registration.connect.client.dart';
import 'package:dotto_app_api/app/v1/course_registration.pb.dart' as api;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'course_registration_repository_impl.g.dart';

@riverpod
CourseRegistrationRepository courseRegistrationRepository(Ref ref) =>
    CourseRegistrationRepositoryImpl(ref.watch(apiClientProvider));

final class CourseRegistrationRepositoryImpl
    implements CourseRegistrationRepository {
  const new(this._transport);

  final Transport _transport;

  CourseRegistrationServiceClient get _client =>
      CourseRegistrationServiceClient(_transport);

  @override
  Future<List<CourseRegistration>> getCourseRegistrations(
    List<Semester> semesters,
  ) async {
    try {
      final response = await _client.listCourseRegistrations(
        api.ListCourseRegistrationsRequest(
          semesters: semesters.map(toApiSemester),
        ),
      );
      return List<CourseRegistration>.unmodifiable(
        response.courseRegistrations.map(
          (e) => CourseRegistration(
            id: e.id,
            subject: toSubjectSummary(e.subject),
          ),
        ),
      );
    } on DomainError {
      rethrow;
    } on Exception catch (e, stackTrace) {
      throw mapDomainError(e: e, stackTrace: stackTrace);
    }
  }

  @override
  Future<void> registerCourse(String subjectId) async {
    try {
      await _client.createCourseRegistration(
        api.CreateCourseRegistrationRequest(subjectId: subjectId),
      );
    } on Exception catch (e, stackTrace) {
      throw mapDomainError(e: e, stackTrace: stackTrace);
    }
  }

  @override
  Future<void> unregisterCourse(String id) async {
    try {
      await _client.deleteCourseRegistration(
        api.DeleteCourseRegistrationRequest(id: id),
      );
    } on Exception catch (e, stackTrace) {
      throw mapDomainError(e: e, stackTrace: stackTrace);
    }
  }
}
