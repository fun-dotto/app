import 'package:dotto/data/push_token_repository_impl.dart';
import 'package:dotto/domain/repository/push_token_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'watch_push_token_use_case.g.dart';

final class WatchPushTokenUseCase {
  const new(this._repository);
  final PushTokenRepository _repository;
  Stream<String> call() => _repository.watchRefreshes();
}

@riverpod
WatchPushTokenUseCase watchPushTokenUseCase(Ref ref) =>
    WatchPushTokenUseCase(ref.watch(pushTokenRepositoryProvider));
