import 'package:dotto/application/fetch_debug_tokens_use_case.dart';
import 'package:dotto/domain/entity/debug_tokens.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'debug_tokens_state.g.dart';

@riverpod
final class DebugTokensState extends _$DebugTokensState {
  @override
  Future<DebugTokens> build() => ref.watch(fetchDebugTokensUseCaseProvider)();
}
