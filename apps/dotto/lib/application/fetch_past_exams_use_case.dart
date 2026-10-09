import 'package:dotto/data/past_exam_repository_impl.dart';
import 'package:dotto/domain/repository/past_exam_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'fetch_past_exams_use_case.g.dart';

@riverpod
FetchPastExamsUseCase fetchPastExamsUseCase(Ref ref) =>
    FetchPastExamsUseCase(ref.watch(pastExamRepositoryProvider));

final class FetchPastExamsUseCase {
  const new(this._repository);
  final PastExamRepository _repository;
  Future<List<String>> call(String pastExamId) =>
      _repository.fetchKeys(pastExamId);
}
