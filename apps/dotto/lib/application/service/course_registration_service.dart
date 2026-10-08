import 'package:dotto/data/course_registration_repository_impl.dart';
import 'package:dotto/data/timetable_repository_impl.dart';
import 'package:dotto/domain/entity/domain_error.dart';
import 'package:dotto/domain/entity/semester.dart';
import 'package:dotto/domain/entity/timetable_item.dart';
import 'package:dotto/domain/entity/timetable_semester.dart';
import 'package:dotto/domain/repository/course_registration_repository.dart';
import 'package:dotto/domain/repository/timetable_repository.dart';
import 'package:dotto/domain/service/course_registration_policy.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'course_registration_service.g.dart';

@riverpod
CourseRegistrationService courseRegistrationService(Ref ref) =>
    CourseRegistrationService(
      ref.watch(courseRegistrationRepositoryProvider),
      ref.watch(timetableRepositoryProvider),
    );

/// 時間割候補と履修登録の整合性を保つ手続きを担う。
final class CourseRegistrationService {
  const new(this._registrations, this._timetable);
  final CourseRegistrationRepository _registrations;
  final TimetableRepository _timetable;

  Future<Map<TimetableSemester, List<TimetableItem>>> fetchTimetable() async {
    final registrations = await _registrations.getCourseRegistrations(
      Semester.values,
    );
    final registeredIds = registrations.map((e) => e.subject.id).toSet();
    final entries = await Future.wait(
      TimetableSemester.values.map((semester) async {
        final items = await _timetable.getTimetableItems(semester.semesters);
        return MapEntry(
          semester,
          List<TimetableItem>.unmodifiable(
            items.map(
              (item) => item.copyWith(
                isAddedToTimetable: registeredIds.contains(item.subject.id),
              ),
            ),
          ),
        );
      }),
    );
    return Map.unmodifiable(Map.fromEntries(entries));
  }

  Future<void> register(String subjectId) async {
    final registrations = await _registrations.getCourseRegistrations(
      Semester.values,
    );
    final registeredIds = registrations.map((e) => e.subject.id).toSet();
    if (registeredIds.contains(subjectId)) return;
    final semesterItems = await Future.wait(
      TimetableSemester.values.map(
        (semester) => _timetable.getTimetableItems(semester.semesters),
      ),
    );
    final canRegister = semesterItems.every(
      (items) => const CourseRegistrationPolicy().canRegister(
        subjectId: subjectId,
        timetableItems: items,
        registeredSubjectIds: registeredIds,
      ),
    );
    if (!canRegister) {
      throw const DomainError(
        type: DomainErrorType.invalidData,
        message: 'The timetable slot is full',
      );
    }
    await _registrations.registerCourse(subjectId);
  }

  Future<void> unregister(String subjectId) async {
    final registrations = await _registrations.getCourseRegistrations(
      Semester.values,
    );
    for (final registration in registrations.where(
      (e) => e.subject.id == subjectId,
    )) {
      await _registrations.unregisterCourse(registration.id);
    }
  }
}
