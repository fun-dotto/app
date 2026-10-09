import 'package:dotto/data/flag_override_data_source.dart';
import 'package:dotto/data/remote_config_data_source.dart';
import 'package:dotto/domain/entity/flag.dart';
import 'package:dotto/domain/repository/feature_flag_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'feature_flag_repository_impl.g.dart';

@Riverpod(keepAlive: true)
FeatureFlagRepository featureFlagRepository(Ref ref) =>
    FeatureFlagRepositoryImpl(
      ref.watch(remoteConfigDataSourceProvider),
      ref.watch(flagOverrideDataSourceProvider),
    );

final class FeatureFlagRepositoryImpl implements FeatureFlagRepository {
  const new(this._remoteConfigHelper, this._overrideDataSource);

  final RemoteConfigDataSource _remoteConfigHelper;
  final FlagOverrideDataSource _overrideDataSource;

  @override
  T fetchRemoteValue<T>(Flag<T> flag) {
    return switch (flag) {
      Flag<bool>() => _remoteConfigHelper.getBool(flag.key) as T,
      Flag<int>() => _remoteConfigHelper.getInt(flag.key) as T,
      Flag<double>() => _remoteConfigHelper.getDouble(flag.key) as T,
      Flag<String>() => _remoteConfigHelper.getString(flag.key) as T,
      _ => flag.defaultValue,
    };
  }

  @override
  Future<Map<String, bool>> fetchOverrides(List<Flag<Object>> flags) =>
      _overrideDataSource.load(flags);

  @override
  Future<void> saveOverride(Flag<bool> flag, {required bool? value}) =>
      _overrideDataSource.save(flag, value: value);
}
