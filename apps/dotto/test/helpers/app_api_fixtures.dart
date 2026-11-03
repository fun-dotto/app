import 'package:dotto_app_api/app/v1/common.pbenum.dart' as api;
import 'package:dotto_app_api/app/v1/course_registration.pb.dart' as api;
import 'package:dotto_app_api/app/v1/faculty.pb.dart' as api;
import 'package:dotto_app_api/app/v1/subject.pb.dart' as api;
import 'package:dotto_app_api/app/v1/timetable_item.pb.dart' as api;
import 'package:dotto_app_api/google/type/date.pb.dart' as api;
import 'package:dotto_app_api/google/type/dayofweek.pbenum.dart' as api;

/// API が返す科目概要を組み立てる。
api.Subject subjectSummaryFixture(
  String id, {
  String? name,
  List<api.SubjectFaculty> faculties = const [],
}) => api.Subject(
  id: id,
  name: name ?? '科目$id',
  faculties: faculties,
  year: 2026,
  semester: api.SubjectSemester.SUBJECT_SEMESTER_H1,
  credit: 2,
);

/// API が返す担当教員を組み立てる。
api.SubjectFaculty subjectFacultyFixture(
  String name, {
  bool isPrimary = false,
}) => api.SubjectFaculty(
  faculty: api.Faculty(id: name, name: name, email: '$name@fun.ac.jp'),
  isPrimary: isPrimary,
);

/// API が返すシラバスを、指定した項目以外を空文字で組み立てる。
api.SubjectSyllabus syllabusFixture({
  required String id,
  Map<String, String> fields = const {},
}) {
  return api.SubjectSyllabus()
    ..mergeFromProto3Json(fields)
    ..id = id
    ..credit = 2;
}

/// API が返す科目詳細を組み立てる。
api.Subject subjectDetailFixture(
  String id, {
  required String name,
  required api.SubjectSyllabus syllabus,
}) => subjectSummaryFixture(id, name: name)..syllabus = syllabus;

/// API が返す履修登録を組み立てる。
api.CourseRegistration courseRegistrationFixture(
  String subjectId, {
  String? name,
}) => api.CourseRegistration(
  id: 'registration-$subjectId',
  subject: subjectSummaryFixture(subjectId, name: name),
);

/// 月曜1限に配置された時間割項目を組み立てる。
api.TimetableItem mondayFirstTimetableItemFixture(
  String id,
  api.Subject subject,
) => api.TimetableItem(
  id: id,
  subject: subject,
  slot: api.TimetableItemSlot(
    dayOfWeek: api.DayOfWeek.MONDAY,
    period: api.Period.PERIOD_1,
  ),
);

/// [DateTime] から API の Date を組み立てる。
api.Date dateFixture(int year, int month, int day) =>
    api.Date(year: year, month: month, day: day);

/// [DateTime] の日付部分から API の Date を組み立てる。
api.Date toDateFixture(DateTime date) =>
    dateFixture(date.year, date.month, date.day);
