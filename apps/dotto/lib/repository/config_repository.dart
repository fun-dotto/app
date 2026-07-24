import 'package:dotto/foundation/config/remote_config.dart';
import 'package:dotto/helper/remote_config_helper.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'config_repository.g.dart';

@Riverpod(keepAlive: true)
ConfigRepository configRepository(Ref ref) =>
    ConfigRepository(ref.watch(remoteConfigHelperProvider));

/// Remote Configから[RemoteConfig]の値を型安全に取得する。
final class ConfigRepository {
  const ConfigRepository(this._remoteConfigHelper);

  final RemoteConfigHelper _remoteConfigHelper;

  T get<T>(RemoteConfig<T> config) =>
      config.getValue(_remoteConfigHelper, config.key);
}
