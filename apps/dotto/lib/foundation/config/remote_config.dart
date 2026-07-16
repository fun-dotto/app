import 'package:dotto/helper/remote_config_helper.dart';

typedef RemoteConfigGetter<T> =
    T Function(RemoteConfigHelper helper, String key);

final class RemoteConfig<T> {
  const RemoteConfig({
    required this.key,
    required this.defaultValue,
    required this.getValue,
  });

  final String key;
  final Object defaultValue;
  final RemoteConfigGetter<T> getValue;
}
