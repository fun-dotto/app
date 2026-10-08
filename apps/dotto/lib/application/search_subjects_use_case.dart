import 'package:dotto/data/course_registration_repository_impl.dart';
import 'package:dotto/data/subject_repository_impl.dart';
import 'package:dotto/data/timetable_repository_impl.dart';
import 'package:dotto/domain/entity/semester.dart';
import 'package:dotto/domain/entity/subject_filter.dart';
import 'package:dotto/domain/entity/subject_summary.dart';
import 'package:dotto/domain/entity/timetable_slot.dart';
import 'package:dotto/domain/repository/course_registration_repository.dart';
import 'package:dotto/domain/repository/subject_repository.dart';
import 'package:dotto/domain/repository/timetable_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'search_subjects_use_case.g.dart';

@riverpod
SearchSubjectsUseCase searchSubjectsUseCase(Ref ref) => SearchSubjectsUseCase(
  ref.watch(subjectRepositoryProvider),
  ref.watch(timetableRepositoryProvider),
  ref.watch(courseRegistrationRepositoryProvider),
);

/// 検索した科目に時間割と履修状態を付加する。
final class SearchSubjectsUseCase {
  const new(this._subjects, this._timetable, this._registrations);
  final SubjectRepository _subjects;
  final TimetableRepository _timetable;
  final CourseRegistrationRepository _registrations;
  Future<List<SubjectSummary>> call({
    required String query,
    required SubjectFilter filter,
    required bool isAuthenticated,
  }) async {
    final fetchedSubjects = await _subjects.getSubjects(query, filter);
    final timetable = await _timetable.getTimetableItems(Semester.values);
    final registered = isAuthenticated
        ? (await _registrations.getCourseRegistrations(Semester.values))
              .map((item) => item.subject.id)
              .toSet()
        : <String>{};
    final slots = <String, List<TimetableSlot>>{};
    for (final item in timetable) {
      if (item.slot case final slot?) {
        slots.putIfAbsent(item.subject.id, () => []).add(slot);
      }
    }
    return List.unmodifiable(
      fetchedSubjects.map(
        (item) => item.copyWith(
          slots: slots[item.id],
          isAddedToTimetable: registered.contains(item.id),
        ),
      ),
    );
  }
}
