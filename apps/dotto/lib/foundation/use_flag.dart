import 'package:dotto/helper/remote_config_helper.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// Remote Config の Bool 値で値を出し分けるための Hook。
///
/// `switch` は Dart の予約語のため、メソッド名は [FlagSwitcher.switchOn] とする。
FlagSwitcher useFlag(WidgetRef ref) {
  final helper = ref.watch(remoteConfigHelperProvider);
  return useMemoized(() => FlagSwitcher._(helper), [helper]);
}

final class FlagSwitcher {
  const FlagSwitcher._(this._helper);

  final RemoteConfigHelper _helper;

  T switchOn<T>(
    String key, {
    required T Function() onTrue,
    required T Function() onFalse,
  }) {
    return _helper.getBool(key) ? onTrue() : onFalse();
  }
}
