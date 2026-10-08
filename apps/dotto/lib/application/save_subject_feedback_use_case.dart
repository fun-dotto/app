import 'package:dotto/data/subject_repository_impl.dart';
import 'package:dotto/domain/entity/subject_feedback.dart';
import 'package:dotto/domain/repository/subject_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'save_subject_feedback_use_case.g.dart';

@riverpod
SaveSubjectFeedbackUseCase saveSubjectFeedbackUseCase(Ref ref) =>
    SaveSubjectFeedbackUseCase(ref.watch(subjectRepositoryProvider));

final class SaveSubjectFeedbackUseCase {
  const new(this._repository);
  final SubjectRepository _repository;
  Future<void> call({
    required String userId,
    required String lessonId,
    required SubjectFeedback feedback,
  }) => _repository.createFeedback(
    userId: userId,
    lessonId: lessonId,
    score: feedback.score,
    comment: feedback.comment,
  );
}
