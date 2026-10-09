import 'package:dotto/data/remote_config_data_source.dart';
import 'package:dotto/foundation/config/remote_config.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'config_data_source.g.dart';

@Riverpod(keepAlive: true)
ConfigDataSource configDataSource(Ref ref) =>
    ConfigDataSource(ref.watch(remoteConfigDataSourceProvider));

/// Remote Configから[RemoteConfig]の値を型安全に取得する。
final class ConfigDataSource {
  const new(this._remoteConfigHelper);

  final RemoteConfigDataSource _remoteConfigHelper;

  T get<T>(RemoteConfig<T> config) =>
      config.getValue(_remoteConfigHelper, config.key);
}
