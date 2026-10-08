import 'package:dotto/data/auth_repository_impl.dart';
import 'package:dotto/domain/auth_account.dart';
import 'package:dotto/domain/auth_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'watch_auth_account_use_case.g.dart';

final class WatchAuthAccountUseCase {
  const new(this._repository);

  final AuthRepository _repository;

  Stream<AuthAccount?> call() => _repository.watchAccount();
}

@riverpod
WatchAuthAccountUseCase watchAuthAccountUseCase(Ref ref) =>
    WatchAuthAccountUseCase(ref.watch(authRepositoryProvider));
