import 'package:dotto/data/app_session_repository_impl.dart';
import 'package:dotto/domain/repository/app_session_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'complete_tutorial_use_case.g.dart';

final class CompleteTutorialUseCase {
  const new(this._repository);
  final AppSessionRepository _repository;
  Future<void> call() => _repository.completeTutorial();
}

@riverpod
CompleteTutorialUseCase completeTutorialUseCase(Ref ref) =>
    CompleteTutorialUseCase(ref.watch(appSessionRepositoryProvider));
