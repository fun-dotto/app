import 'dart:async';

import 'package:dotto/foundation/flag/flag.dart';
import 'package:dotto/foundation/flag/flags.dart';
import 'package:dotto/repository/flag_override_store.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'flag_overrides.g.dart';

/// Debug用overrideの一覧 (フラグのkey -> override値) を保持するNotifier。
@Riverpod(keepAlive: true)
final class FlagOverridesNotifier extends _$FlagOverridesNotifier {
  @override
  Map<String, Object?> build() {
    unawaited(loadOverrides());
    return const {};
  }

  Future<void> setOverride(Flag<bool> flag, {required bool? value}) async {
    await ref.read(flagOverrideStoreProvider).set(flag, value: value);
    if (value == null) {
      state = {...state}..remove(flag.key);
    } else {
      state = {...state, flag.key: value};
    }
  }

  Future<void> loadOverrides() async {
    state = await ref.read(flagOverrideStoreProvider).load(Flags.all);
  }
}
