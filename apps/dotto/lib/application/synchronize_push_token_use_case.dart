import 'package:dotto/data/push_token_repository_impl.dart';
import 'package:dotto/domain/repository/push_token_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'synchronize_push_token_use_case.g.dart';

final class SynchronizePushTokenUseCase {
  const new(this._repository);
  final PushTokenRepository _repository;
  Future<void> call([String? token]) => _repository.synchronize(token);
}

@riverpod
SynchronizePushTokenUseCase synchronizePushTokenUseCase(Ref ref) =>
    SynchronizePushTokenUseCase(ref.watch(pushTokenRepositoryProvider));
