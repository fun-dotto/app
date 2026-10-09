import 'package:dotto/domain/entity/syllabus.dart';
import 'package:dotto/presentation/subject/subject_detail_syllabus_content.dart';
import 'package:flutter/widgets.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

const _syllabus = Syllabus(
  id: '1',
  name: '情報処理演習',
  enName: 'Information Processing Exercise',
  grades: '1年',
  credit: 2,
  facultyNames: '未来 太郎',
  practicalHomeFacultyCategory: '',
  multiplePersonTeachingForm: '',
  teachingForm: '演習',
  summary: 'プログラミングの基礎を学ぶ。',
  learningOutcomes: '基本的なプログラムを書けるようになる。',
  assignments: '毎回の課題を提出する。',
  evaluationMethod: '課題 60%、期末試験 40%',
  textbooks: 'なし',
  referenceBooks: 'なし',
  prerequisites: '特になし',
  preLearning: '前回の内容を復習する。',
  postLearning: '課題に取り組む。',
  notes: '',
  keywords: 'プログラミング',
  targetCourses: '全コース',
  targetAreas: '',
  classifications: '必修',
  teachingLanguage: '日本語',
  contentsAndSchedule: '第1回 ガイダンス\n第2回 変数と型\n第3回 条件分岐',
  teachingAndExamForm: '対面',
  dsopSubject: '',
);

@widgetbook.UseCase(name: 'Default', type: SubjectDetailSyllabusContent)
Widget subjectDetailSyllabusContentDefault(BuildContext context) =>
    const SubjectDetailSyllabusContent(syllabus: _syllabus);
