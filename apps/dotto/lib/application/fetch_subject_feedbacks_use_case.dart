import 'package:dotto/data/subject_repository_impl.dart';
import 'package:dotto/domain/entity/subject_feedback.dart';
import 'package:dotto/domain/repository/subject_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'fetch_subject_feedbacks_use_case.g.dart';

@riverpod
FetchSubjectFeedbacksUseCase fetchSubjectFeedbacksUseCase(Ref ref) =>
    FetchSubjectFeedbacksUseCase(ref.watch(subjectRepositoryProvider));

final class FetchSubjectFeedbacksUseCase {
  const new(this._repository);
  final SubjectRepository _repository;
  Future<List<SubjectFeedback>> call(String lessonId) =>
      _repository.getFeedbacks(lessonId);
}
