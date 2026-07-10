import 'dart:async';

import 'package:dotto/foundation/flag.dart';
import 'package:dotto/foundation/flags.dart';
import 'package:dotto/repository/feature_flag_repository.dart';
import 'package:dotto/repository/flag_override_store.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'feature_flag_controller.g.dart';

/// Debug用overrideの一覧 (フラグのkey -> override値) を保持するNotifier。
@Riverpod(keepAlive: true)
final class FeatureFlagNotifier extends _$FeatureFlagNotifier {
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

/// FeatureFlagの実効値 (Debug用override > Remote Config) を返す。
@Riverpod(keepAlive: true)
T featureFlag<T>(Ref ref, Flag<T> flag) {
  final override = ref.watch(
    featureFlagNotifierProvider.select((overrides) => overrides[flag.key]),
  );
  if (override is T) return override;
  return ref.watch(featureFlagRepositoryProvider).get(flag);
}
