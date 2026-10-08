import 'package:dotto/data/debug_token_repository_impl.dart';
import 'package:dotto/domain/entity/debug_tokens.dart';
import 'package:dotto/domain/repository/debug_token_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'fetch_debug_tokens_use_case.g.dart';

final class FetchDebugTokensUseCase {
  const new(this._repository);

  final DebugTokenRepository _repository;

  Future<DebugTokens> call() => _repository.fetch();
}

@riverpod
FetchDebugTokensUseCase fetchDebugTokensUseCase(Ref ref) =>
    FetchDebugTokensUseCase(ref.watch(debugTokenRepositoryProvider));
