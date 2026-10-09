import 'package:dotto/data/app_session_repository_impl.dart';
import 'package:dotto/domain/repository/app_session_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'fetch_tutorial_completion_use_case.g.dart';

final class FetchTutorialCompletionUseCase {
  const new(this._repository);
  final AppSessionRepository _repository;
  Future<bool> call() => _repository.fetchTutorialCompletion();
}

@riverpod
FetchTutorialCompletionUseCase fetchTutorialCompletionUseCase(Ref ref) =>
    FetchTutorialCompletionUseCase(ref.watch(appSessionRepositoryProvider));
