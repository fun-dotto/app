import 'package:built_collection/built_collection.dart';
import 'package:dotto/api/api_client.dart';
import 'package:dotto/domain/entity/course_registration.dart';
import 'package:dotto/domain/entity/domain_error.dart';
import 'package:dotto/domain/entity/faculty.dart';
import 'package:dotto/domain/entity/semester.dart';
import 'package:dotto/domain/entity/subject_faculty.dart';
import 'package:dotto/domain/entity/subject_summary.dart';
import 'package:dotto/domain/repository/course_registration_repository.dart';
import 'package:openapi/openapi.dart'
    hide
        CourseRegistration,
        Faculty,
        SubjectFaculty,
        SubjectSummary,
        TimetableItem;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'course_registration_repository_impl.g.dart';

@riverpod
CourseRegistrationRepository courseRegistrationRepository(Ref ref) =>
    CourseRegistrationRepositoryImpl(ref.watch(apiClientProvider));

final class CourseRegistrationRepositoryImpl
    implements CourseRegistrationRepository {
  const new(this.apiClient);

  final Openapi apiClient;

  @override
  Future<List<CourseRegistration>> getCourseRegistrations(
    List<Semester> semesters,
  ) async {
    try {
      final api = apiClient.getCourseRegistrationsApi();
      final response = await api.courseRegistrationsV1List(
        semesters: BuiltList<DottoFoundationV1CourseSemester>(
          semesters.map(
            (semester) => switch (semester) {
              Semester.h1 => DottoFoundationV1CourseSemester.H1,
              Semester.h2 => DottoFoundationV1CourseSemester.H2,
              Semester.allYear => DottoFoundationV1CourseSemester.allYear,
              Semester.q1 => DottoFoundationV1CourseSemester.Q1,
              Semester.q2 => DottoFoundationV1CourseSemester.Q2,
              Semester.q3 => DottoFoundationV1CourseSemester.Q3,
              Semester.q4 => DottoFoundationV1CourseSemester.Q4,
              Semester.summerIntensive =>
                DottoFoundationV1CourseSemester.summerIntensive,
              Semester.winterIntensive =>
                DottoFoundationV1CourseSemester.winterIntensive,
            },
          ),
        ),
      );
      if (response.statusCode != 200) {
        throw const DomainError(
          type: DomainErrorType.invalidResponse,
          message: 'Failed to get course registrations',
        );
      }
      final data = response.data;
      if (data == null) {
        throw const DomainError(
          type: DomainErrorType.invalidResponse,
          message: 'Failed to get course registrations',
        );
      }
      return List<CourseRegistration>.unmodifiable(
        data.courseRegistrations
            .map(
              (e) => CourseRegistration(
                id: e.id,
                subject: SubjectSummary(
                  id: e.subject.id,
                  name: e.subject.name,
                  faculties: e.subject.faculties
                      .map(
                        (e) => SubjectFaculty(
                          faculty: Faculty(
                            id: e.faculty.id,
                            name: e.faculty.name,
                            email: e.faculty.email,
                          ),
                          isPrimary: e.isPrimary,
                        ),
                      )
                      .toList(),
                ),
              ),
            )
            .toList(),
      );
    } on DomainError {
      rethrow;
    } on Exception catch (e, stackTrace) {
      throw DomainError.fromException(e: e, stackTrace: stackTrace);
    }
  }

  @override
  Future<void> registerCourse(String subjectId) async {
    try {
      final api = apiClient.getCourseRegistrationsApi();
      final request = CourseRegistrationRequest((b) => b.subjectId = subjectId);
      final response = await api.courseRegistrationsV1Create(
        courseRegistrationRequest: request,
      );
      if (response.statusCode != 201) {
        throw const DomainError(
          type: DomainErrorType.invalidResponse,
          message: 'Failed to register course',
        );
      }
    } on DomainError {
      rethrow;
    } on Exception catch (e, stackTrace) {
      throw DomainError.fromException(e: e, stackTrace: stackTrace);
    }
  }

  @override
  Future<void> unregisterCourse(String id) async {
    try {
      final api = apiClient.getCourseRegistrationsApi();
      final response = await api.courseRegistrationsV1Delete(id: id);
      if (response.statusCode != 204) {
        throw const DomainError(
          type: DomainErrorType.invalidResponse,
          message: 'Failed to unregister course',
        );
      }
    } on DomainError {
      rethrow;
    } on Exception catch (e, stackTrace) {
      throw DomainError.fromException(e: e, stackTrace: stackTrace);
    }
  }
}
