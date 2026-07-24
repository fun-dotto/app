import 'package:dotto/foundation/flag/flag.dart';
import 'package:dotto/foundation/flag/flag_overrides.dart';
import 'package:dotto/repository/feature_flag_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'feature_flag.g.dart';

/// FeatureFlagの実効値 (Debug用override > Remote Config) を返す。
@Riverpod(keepAlive: true)
T featureFlag<T>(Ref ref, Flag<T> flag) {
  final override = ref.watch(flagOverridesProvider)[flag.key];
  if (override is T) return override;
  return ref.watch(featureFlagRepositoryProvider).get(flag);
}
