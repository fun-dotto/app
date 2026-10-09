import 'package:dotto/presentation/subject/subject_detail_add_feedback_content.dart';
import 'package:flutter/widgets.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

Widget _content({required bool canSubmit}) => SubjectDetailAddFeedbackContent(
  canSubmit: canSubmit,
  onClose: () {},
  onSubmit: () {},
  onScoreChanged: (_) {},
  onCommentChanged: (_) {},
);

@widgetbook.UseCase(name: 'Default', type: SubjectDetailAddFeedbackContent)
Widget subjectDetailAddFeedbackContentDefault(BuildContext context) =>
    _content(canSubmit: true);

@widgetbook.UseCase(name: 'Submitting', type: SubjectDetailAddFeedbackContent)
Widget subjectDetailAddFeedbackContentSubmitting(BuildContext context) =>
    _content(canSubmit: false);
