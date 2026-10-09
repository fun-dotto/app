import 'package:dotto/data/app_session_repository_impl.dart';
import 'package:dotto/domain/repository/app_session_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'record_notification_prompt_use_case.g.dart';

final class RecordNotificationPromptUseCase {
  const new(this._repository);
  final AppSessionRepository _repository;
  Future<void> call() => _repository.recordNotificationPrompt();
}

@riverpod
RecordNotificationPromptUseCase recordNotificationPromptUseCase(Ref ref) =>
    RecordNotificationPromptUseCase(ref.watch(appSessionRepositoryProvider));
