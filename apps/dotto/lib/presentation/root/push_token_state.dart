import 'package:dotto/application/watch_push_token_use_case.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'push_token_state.g.dart';

@riverpod
Stream<String> pushTokenState(Ref ref) =>
    ref.watch(watchPushTokenUseCaseProvider)();
