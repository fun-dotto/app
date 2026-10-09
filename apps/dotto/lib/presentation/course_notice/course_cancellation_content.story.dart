import 'package:dotto/domain/entity/course_notice.dart';
import 'package:dotto/domain/entity/course_notice_scope.dart';
import 'package:dotto/domain/entity/subject_summary.dart';
import 'package:dotto/presentation/course_notice/course_cancellation_content.dart';
import 'package:flutter/widgets.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

const _subject = SubjectSummary(id: '1', name: '情報処理演習', faculties: []);

final _notices = <CourseNotice>[
  CourseNotice.cancellation(
    id: '1',
    subject: _subject,
    date: DateTime(2026, 4, 13),
    periodNumber: 1,
    comment: '担当教員の出張のため',
  ),
  CourseNotice.cancellation(
    id: '2',
    subject: _subject,
    date: DateTime(2026, 4, 20),
    periodNumber: 2,
    comment: '',
  ),
  CourseNotice.makeup(
    id: '3',
    subject: _subject,
    date: DateTime(2026, 4, 25),
    periodNumber: 3,
    comment: '4/13 の補講',
  ),
  CourseNotice.roomChange(
    id: '4',
    subject: _subject,
    date: DateTime(2026, 4, 27),
    periodNumber: 4,
    originalRoomName: '講堂',
    newRoomName: '大講義室',
  ),
];

Widget _content({
  required Widget body,
  CourseNoticeTab initialTab = CourseNoticeTab.cancellations,
  CourseNoticeScope scope = CourseNoticeScope.registered,
}) => CourseCancellationContent(
  initialTab: initialTab,
  scope: scope,
  onScopeToggled: () {},
  body: body,
);

@widgetbook.UseCase(name: 'Cancellations', type: CourseCancellationContent)
Widget courseCancellationContentCancellations(BuildContext context) => _content(
  body: CourseNoticeTabView(notices: _notices, onRefresh: () async {}),
);

@widgetbook.UseCase(name: 'Makeups', type: CourseCancellationContent)
Widget courseCancellationContentMakeups(BuildContext context) => _content(
  initialTab: CourseNoticeTab.makeups,
  body: CourseNoticeTabView(notices: _notices, onRefresh: () async {}),
);

@widgetbook.UseCase(name: 'Room changes', type: CourseCancellationContent)
Widget courseCancellationContentRoomChanges(BuildContext context) => _content(
  initialTab: CourseNoticeTab.roomChanges,
  body: CourseNoticeTabView(notices: _notices, onRefresh: () async {}),
);

@widgetbook.UseCase(name: 'All scope', type: CourseCancellationContent)
Widget courseCancellationContentAllScope(BuildContext context) => _content(
  scope: CourseNoticeScope.all,
  body: CourseNoticeTabView(notices: _notices, onRefresh: () async {}),
);

@widgetbook.UseCase(name: 'Empty', type: CourseCancellationContent)
Widget courseCancellationContentEmpty(BuildContext context) => _content(
  body: CourseNoticeTabView(notices: const [], onRefresh: () async {}),
);
