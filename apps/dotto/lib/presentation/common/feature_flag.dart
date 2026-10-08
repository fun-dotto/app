import 'package:dotto/application/fetch_remote_flag_value_use_case.dart';
import 'package:dotto/foundation/flag/flag.dart';
import 'package:dotto/presentation/common/flag_override_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'feature_flag.g.dart';

/// Remote Config に設定されたフラグの値を返す。
@Riverpod(keepAlive: true)
T remoteFlagValue<T>(Ref ref, Flag<T> flag) =>
    ref.watch(fetchRemoteFlagValueUseCaseProvider)(flag);

/// フラグの実効値 (Debug 用の上書き値 > Remote Config) を返す。
@Riverpod(keepAlive: true)
T featureFlag<T>(Ref ref, Flag<T> flag) {
  final override = ref.watch(flagOverrideStateProvider)[flag.key];
  if (override case final T value) return value;
  return ref.watch(remoteFlagValueProvider(flag));
}
