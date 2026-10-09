/// API が返す科目概要の JSON を組み立てる。
Map<String, Object?> subjectSummaryJson(
  String id, {
  String? name,
  List<Map<String, Object?>> faculties = const [],
}) => {
  'id': id,
  'name': name ?? '科目$id',
  'faculties': faculties,
  'year': 2026,
  'semester': 'H1',
  'credit': 2,
};

/// API が返す担当教員の JSON を組み立てる。
Map<String, Object?> subjectFacultyJson(
  String name, {
  bool isPrimary = false,
}) => {
  'faculty': {'id': name, 'name': name, 'email': '$name@fun.ac.jp'},
  'isPrimary': isPrimary,
};

/// API が返すシラバスの JSON を、指定した項目以外を空文字で組み立てる。
Map<String, Object?> syllabusJson({
  required String id,
  Map<String, String> fields = const {},
}) => {
  for (final field in _syllabusFields) field: '',
  'credit': 2,
  ...fields,
  'id': id,
};

/// API が返す科目詳細の JSON を組み立てる。
Map<String, Object?> subjectDetailJson(
  String id, {
  required String name,
  required Map<String, Object?> syllabus,
}) => {
  ...subjectSummaryJson(id, name: name),
  'eligibleAttributes': <Object>[],
  'requirements': <Object>[],
  'syllabus': syllabus,
};

const _syllabusFields = [
  'name',
  'enName',
  'grades',
  'facultyNames',
  'practicalHomeFacultyCategory',
  'multiplePersonTeachingForm',
  'teachingForm',
  'summary',
  'learningOutcomes',
  'assignments',
  'evaluationMethod',
  'textbooks',
  'referenceBooks',
  'prerequisites',
  'preLearning',
  'postLearning',
  'notes',
  'keywords',
  'targetCourses',
  'targetAreas',
  'classifications',
  'teachingLanguage',
  'contentsAndSchedule',
  'teachingAndExamForm',
  'dsopSubject',
];
