import 'package:dotto/foundation/flag.dart';
import 'package:dotto/helper/remote_config_helper.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'feature_flag_repository.g.dart';

@Riverpod(keepAlive: true)
FeatureFlagRepository featureFlagRepository(Ref ref) =>
    FeatureFlagRepository(ref.watch(remoteConfigHelperProvider));

/// Remote Config から [Flag] の値を型安全に取得する。
final class FeatureFlagRepository {
  const FeatureFlagRepository(this._remoteConfigHelper);

  final RemoteConfigHelper _remoteConfigHelper;

  T get<T>(Flag<T> flag) {
    return switch (flag) {
      Flag<bool>() => _remoteConfigHelper.getBool(flag.key) as T,
      Flag<int>() => _remoteConfigHelper.getInt(flag.key) as T,
      Flag<double>() => _remoteConfigHelper.getDouble(flag.key) as T,
      Flag<String>() => _remoteConfigHelper.getString(flag.key) as T,
      _ => flag.defaultValue,
    };
  }
}
