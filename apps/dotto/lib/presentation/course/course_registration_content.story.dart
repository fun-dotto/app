import 'package:dotto/domain/entity/day_of_week.dart';
import 'package:dotto/domain/entity/period.dart';
import 'package:dotto/domain/entity/subject_summary.dart';
import 'package:dotto/domain/entity/timetable_item.dart';
import 'package:dotto/domain/entity/timetable_semester.dart';
import 'package:dotto/domain/entity/timetable_slot.dart';
import 'package:dotto/presentation/course/course_registration_content.dart';
import 'package:flutter/widgets.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

const _items = [
  TimetableItem(
    id: '1',
    subject: SubjectSummary(id: '1', name: '情報処理演習', faculties: []),
    slot: TimetableSlot(dayOfWeek: DayOfWeek.monday, period: Period.first),
    isAddedToTimetable: true,
  ),
  TimetableItem(
    id: '2',
    subject: SubjectSummary(id: '2', name: '解析学Ⅰ', faculties: []),
    slot: TimetableSlot(dayOfWeek: DayOfWeek.monday, period: Period.first),
    isAddedToTimetable: true,
  ),
  TimetableItem(
    id: '3',
    subject: SubjectSummary(id: '3', name: '英語', faculties: []),
    slot: TimetableSlot(dayOfWeek: DayOfWeek.wednesday, period: Period.third),
    isAddedToTimetable: true,
  ),
];

@widgetbook.UseCase(name: 'Default', type: CourseRegistrationContent)
Widget courseRegistrationContentDefault(BuildContext context) =>
    CourseRegistrationContent(
      body: CourseRegistrationTabView(
        timetableItemsBySemester: const {TimetableSemester.spring: _items},
        onRefresh: () async {},
        onSlotTap: (_, _, _, _) {},
      ),
    );

@widgetbook.UseCase(name: 'Empty', type: CourseRegistrationContent)
Widget courseRegistrationContentEmpty(BuildContext context) =>
    CourseRegistrationContent(
      body: CourseRegistrationTabView(
        timetableItemsBySemester: const {},
        onRefresh: () async {},
        onSlotTap: (_, _, _, _) {},
      ),
    );
