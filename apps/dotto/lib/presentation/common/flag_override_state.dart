import 'dart:async';

import 'package:dotto/application/fetch_flag_overrides_use_case.dart';
import 'package:dotto/application/save_flag_override_use_case.dart';
import 'package:dotto/domain/entity/flag.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'flag_override_state.g.dart';

/// Debug 用に上書きしたフラグの値 (フラグの key -> 上書き値)。
@Riverpod(keepAlive: true)
final class FlagOverrideState extends _$FlagOverrideState {
  @override
  Map<String, bool> build() {
    // 起動を待たせないよう、保存済みの値は読み込み次第反映する
    unawaited(load());
    return const {};
  }

  Future<void> load() async {
    state = await ref.read(fetchFlagOverridesUseCaseProvider)();
  }

  Future<void> setOverride(Flag<bool> flag, {required bool? value}) async {
    await ref.read(saveFlagOverrideUseCaseProvider)(flag, value: value);
    state = switch (value) {
      null => Map.unmodifiable({...state}..remove(flag.key)),
      final value => Map.unmodifiable({...state, flag.key: value}),
    };
  }
}
