import 'package:dotto/domain/entity/day_of_week.dart';
import 'package:dotto/domain/entity/faculty.dart';
import 'package:dotto/domain/entity/grade.dart';
import 'package:dotto/domain/entity/period.dart';
import 'package:dotto/domain/entity/semester.dart';
import 'package:dotto/domain/entity/subject_faculty.dart';
import 'package:dotto/domain/entity/subject_filter.dart';
import 'package:dotto/domain/entity/subject_summary.dart';
import 'package:dotto/domain/entity/timetable_slot.dart';
import 'package:dotto/presentation/subject/search_subject_content.dart';
import 'package:flutter/widgets.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

const _subjects = [
  SubjectSummary(
    id: '1',
    name: '情報処理演習',
    faculties: [
      SubjectFaculty(
        faculty: Faculty(id: '1', name: '未来 太郎', email: ''),
        isPrimary: true,
      ),
      SubjectFaculty(
        faculty: Faculty(id: '2', name: '函館 花子', email: ''),
        isPrimary: false,
      ),
    ],
    semester: Semester.h1,
    credit: 2,
    slots: [TimetableSlot(dayOfWeek: DayOfWeek.monday, period: Period.first)],
    isAddedToTimetable: true,
  ),
  SubjectSummary(
    id: '2',
    name: 'とても長い科目名の授業で折り返しを確認するためのダミーデータ',
    faculties: [],
    semester: Semester.h2,
    credit: 1,
    isAddedToTimetable: false,
  ),
  SubjectSummary(id: '3', name: '解析学Ⅰ', faculties: []),
];

Widget _content({
  required Widget results,
  SubjectFilter filter = const SubjectFilter(),
}) => SearchSubjectContent(
  filter: filter,
  results: results,
  onQueryChanged: (_) {},
  onQuerySubmitted: () {},
  onFilterChanged: (_) {},
  onFiltersCleared: () {},
);

Widget _results({
  List<SubjectSummary> subjects = _subjects,
  SubjectFilter filter = const SubjectFilter(),
  bool isAuthenticated = true,
  Set<String> processingIds = const {},
}) => SearchSubjectResults(
  subjects: subjects,
  filter: filter,
  isAuthenticated: isAuthenticated,
  processingIds: processingIds,
  onSelected: (_) {},
  onToggle: (_, {required isAddedToTimetable}) {},
);

@widgetbook.UseCase(name: 'Default', type: SearchSubjectContent)
Widget searchSubjectContentDefault(BuildContext context) =>
    _content(results: _results());

@widgetbook.UseCase(name: 'Signed out', type: SearchSubjectContent)
Widget searchSubjectContentSignedOut(BuildContext context) =>
    _content(results: _results(isAuthenticated: false));

@widgetbook.UseCase(name: 'Processing', type: SearchSubjectContent)
Widget searchSubjectContentProcessing(BuildContext context) =>
    _content(results: _results(processingIds: {'1'}));

@widgetbook.UseCase(name: 'Filtered', type: SearchSubjectContent)
Widget searchSubjectContentFiltered(BuildContext context) {
  const filter = SubjectFilter(grades: [Grade.b1]);
  return _content(
    filter: filter,
    results: _results(filter: filter),
  );
}

@widgetbook.UseCase(name: 'Not found', type: SearchSubjectContent)
Widget searchSubjectContentNotFound(BuildContext context) {
  const filter = SubjectFilter(grades: [Grade.b1]);
  return _content(
    filter: filter,
    results: _results(subjects: const [], filter: filter),
  );
}
