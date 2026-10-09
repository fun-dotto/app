import 'package:dotto/presentation/subject/subject_detail_past_exam_content.dart';
import 'package:flutter/widgets.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Default', type: SubjectDetailPastExamContent)
Widget subjectDetailPastExamContentDefault(BuildContext context) =>
    SubjectDetailPastExamContent(
      pastExams: const ['subject/2024_前期_期末.pdf', 'subject/2023_前期_期末.pdf'],
      onPastExamSelected: (_) {},
    );

@widgetbook.UseCase(name: 'Empty', type: SubjectDetailPastExamContent)
Widget subjectDetailPastExamContentEmpty(BuildContext context) =>
    SubjectDetailPastExamContent(
      pastExams: const [],
      onPastExamSelected: (_) {},
    );
