import 'package:dotto/data/remote_config_data_source.dart';

typedef RemoteConfigGetter<T> = T Function(
  RemoteConfigDataSource helper,
  String key,
);

final class RemoteConfig<T> {
  const new({
    required this.key,
    required this.defaultValue,
    required this.remoteDefaultValue,
    required this.getValue,
  });

  final String key;
  final T defaultValue;
  final Object remoteDefaultValue;
  final RemoteConfigGetter<T> getValue;
}
