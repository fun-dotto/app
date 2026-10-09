import 'package:dotto/domain/entity/subject_feedback.dart';
import 'package:dotto/presentation/subject/subject_detail_feedback_content.dart';
import 'package:flutter/widgets.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Default', type: SubjectDetailFeedbackContent)
Widget subjectDetailFeedbackContentDefault(BuildContext context) =>
    SubjectDetailFeedbackContent(
      feedbacks: [
        SubjectFeedback(score: 5, comment: '分かりやすい授業でした。'),
        SubjectFeedback(score: 4, comment: '課題は多いが力がつく。'),
        SubjectFeedback(score: 3, comment: ''),
        SubjectFeedback(score: 1, comment: '出席が厳しい。'),
      ],
    );

@widgetbook.UseCase(name: 'Empty', type: SubjectDetailFeedbackContent)
Widget subjectDetailFeedbackContentEmpty(BuildContext context) =>
    const SubjectDetailFeedbackContent(feedbacks: []);
