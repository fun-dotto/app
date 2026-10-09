import 'package:dotto/domain/entity/breaking_announcement.dart';
import 'package:dotto/domain/entity/day_of_week.dart';
import 'package:dotto/domain/entity/lecture_status.dart';
import 'package:dotto/domain/entity/period.dart';
import 'package:dotto/domain/entity/personal_timetable_day.dart';
import 'package:dotto/domain/entity/personal_timetable_item.dart';
import 'package:dotto/domain/entity/subject_summary.dart';
import 'package:dotto/presentation/course/course_content.dart';
import 'package:dotto/presentation/course/quick_button.dart';
import 'package:material_ui/material_ui.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

PersonalTimetableItem _item(
  Period period,
  String name, {
  LectureStatus status = LectureStatus.normal,
}) => PersonalTimetableItem(
  period: period,
  subject: SubjectSummary(id: name, name: name, faculties: const []),
  lectureStatus: status,
  roomName: '講堂',
);

final _days = [
  PersonalTimetableDay(
    date: DateTime(2026, 4, 13),
    timetableDayOfWeek: DayOfWeek.monday,
    items: [
      _item(Period.first, '情報処理演習'),
      _item(Period.second, '解析学Ⅰ', status: LectureStatus.cancelled),
      _item(Period.third, '英語', status: LectureStatus.roomChanged),
      _item(Period.fourth, '線形代数学Ⅰ', status: LectureStatus.madeUp),
    ],
  ),
  PersonalTimetableDay(
    date: DateTime(2026, 4, 14),
    timetableDayOfWeek: DayOfWeek.tuesday,
    items: const [],
  ),
];

// アイコンはネットワークから取得しないよう、URL を指定しない。
List<QuickButton> _buttons(List<String> labels) => [
  for (final label in labels)
    QuickButton(
      iconUrl: null,
      fallbackIcon: Icons.language,
      label: label,
      onPressed: () {},
    ),
];

Widget _content({
  bool isAuthenticated = true,
  List<PersonalTimetableDay>? days,
  bool isTimetableTimeVisible = false,
  BreakingAnnouncement? breakingAnnouncement,
}) => CourseContent(
  breakingAnnouncement: breakingAnnouncement,
  onBreakingAnnouncementTap: (_) {},
  onCustomizeTap: () {},
  body: CourseTimetableBody(
    isAuthenticated: isAuthenticated,
    days: days ?? _days,
    selectedDate: DateTime(2026, 4, 13),
    isTimetableTimeVisible: isTimetableTimeVisible,
    quickFeatures: _buttons(['科目検索', '休講・補講']),
    quickFiles: _buttons(['学年暦', '前期時間割', '後期時間割']),
    quickLinks: _buttons(['HOPE', '学生ポータル']),
    onRefresh: () async {},
    onDateSelected: (_) {},
    onSubjectSelected: (_) {},
    onWeeklyTimetableTap: () {},
    onSignIn: () {},
  ),
);

@widgetbook.UseCase(name: 'Default', type: CourseContent)
Widget courseContentDefault(BuildContext context) => _content();

@widgetbook.UseCase(name: 'With time', type: CourseContent)
Widget courseContentWithTime(BuildContext context) =>
    _content(isTimetableTimeVisible: true);

@widgetbook.UseCase(name: 'Breaking announcement', type: CourseContent)
Widget courseContentBreakingAnnouncement(BuildContext context) => _content(
  breakingAnnouncement: const BreakingAnnouncement(
    title: '大雪のため全学休講とします',
    url: 'https://example.com',
    isExternal: true,
  ),
);

@widgetbook.UseCase(name: 'Signed out', type: CourseContent)
Widget courseContentSignedOut(BuildContext context) =>
    _content(isAuthenticated: false, days: const []);
