import 'package:dotto/domain/entity/day_of_week.dart';
import 'package:dotto/domain/entity/period.dart';
import 'package:dotto/domain/entity/subject_summary.dart';
import 'package:dotto/domain/entity/timetable_item.dart';
import 'package:dotto/domain/entity/timetable_semester.dart';
import 'package:dotto/presentation/course/select_course_content.dart';
import 'package:flutter/widgets.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

const _items = [
  TimetableItem(
    id: '1',
    subject: SubjectSummary(id: '1', name: '情報処理演習', faculties: []),
    slot: null,
    isAddedToTimetable: true,
  ),
  TimetableItem(
    id: '2',
    subject: SubjectSummary(id: '2', name: 'システム情報科学実習', faculties: []),
    slot: null,
    isAddedToTimetable: false,
  ),
  TimetableItem(
    id: '3',
    subject: SubjectSummary(
      id: '3',
      name: 'とても長い科目名の授業で折り返しを確認するためのダミーデータ',
      faculties: [],
    ),
    slot: null,
    isAddedToTimetable: false,
  ),
];

Widget _content({required List<TimetableItem> items, bool isSaving = false}) =>
    SelectCourseContent(
      semester: TimetableSemester.spring,
      dayOfWeek: DayOfWeek.monday,
      period: Period.first,
      timetableItems: items,
      isSaving: isSaving,
      onRegistrationToggled: (_) {},
    );

@widgetbook.UseCase(name: 'Default', type: SelectCourseContent)
Widget selectCourseContentDefault(BuildContext context) =>
    _content(items: _items);

@widgetbook.UseCase(name: 'Saving', type: SelectCourseContent)
Widget selectCourseContentSaving(BuildContext context) =>
    _content(items: _items, isSaving: true);

@widgetbook.UseCase(name: 'Empty', type: SelectCourseContent)
Widget selectCourseContentEmpty(BuildContext context) => _content(items: []);
