import 'package:dotto/application/fetch_subject_feedbacks_use_case.dart';
import 'package:dotto/domain/entity/subject_feedback.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'subject_feedbacks_state.g.dart';

@riverpod
final class SubjectFeedbacksState extends _$SubjectFeedbacksState {
  @override
  Future<List<SubjectFeedback>> build(String lessonId) =>
      ref.watch(fetchSubjectFeedbacksUseCaseProvider)(lessonId);
}
