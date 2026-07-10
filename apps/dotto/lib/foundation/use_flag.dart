import 'package:dotto/controller/feature_flag_controller.dart';
import 'package:dotto/foundation/flag.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// FeatureFlagの値で出し分けるためのHook。
///
/// 値は [featureFlagProvider] を参照するため、Debug用overrideも反映される。
///
/// `switch` は Dart の予約語のため、メソッド名は [FlagSwitcher.switchOn] とする。
FlagSwitcher useFlag(WidgetRef ref) {
  return useMemoized(() => FlagSwitcher._(ref), [ref]);
}

final class FlagSwitcher {
  const FlagSwitcher._(this._ref);

  final WidgetRef _ref;

  T get<T>(Flag<T> flag) => _ref.watch(featureFlagProvider(flag));

  R switchOn<R>(
    Flag<bool> flag, {
    required R Function() onTrue,
    required R Function() onFalse,
  }) {
    return get(flag) ? onTrue() : onFalse();
  }
}
