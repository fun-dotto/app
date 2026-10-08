import 'package:dotto/data/app_session_repository_impl.dart';
import 'package:dotto/domain/repository/app_session_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'should_prompt_notification_use_case.g.dart';

final class ShouldPromptNotificationUseCase {
  const new(this._repository);
  final AppSessionRepository _repository;
  Future<bool> call() => _repository.shouldPromptNotification();
}

@riverpod
ShouldPromptNotificationUseCase shouldPromptNotificationUseCase(Ref ref) =>
    ShouldPromptNotificationUseCase(ref.watch(appSessionRepositoryProvider));
