import 'package:dotto_app_api/app/v1/faculty.pb.dart' as api;
import 'package:dotto_app_api/app/v1/subject.pb.dart' as api;

/// API が返す科目概要を組み立てる。
api.Subject apiSubjectSummary(
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
api.SubjectFaculty apiSubjectFaculty(String name, {bool isPrimary = false}) =>
    api.SubjectFaculty(
      faculty: api.Faculty(id: name, name: name, email: '$name@fun.ac.jp'),
      isPrimary: isPrimary,
    );

/// API が返すシラバスを、指定した項目以外を空文字で組み立てる。
api.SubjectSyllabus apiSyllabus({
  required String id,
  Map<String, String> fields = const {},
}) {
  final syllabus = api.SubjectSyllabus(id: id, credit: 2);
  final info = syllabus.info_;
  for (final entry in fields.entries) {
    final field = info.byName[entry.key];
    if (field == null) {
      throw ArgumentError.value(entry.key, 'fields', 'Unknown syllabus field');
    }
    syllabus.setField(field.tagNumber, entry.value);
  }
  return syllabus;
}

/// API が返す科目詳細を組み立てる。
api.Subject apiSubjectDetail(
  String id, {
  required String name,
  required api.SubjectSyllabus syllabus,
}) => apiSubjectSummary(id, name: name)..syllabus = syllabus;
