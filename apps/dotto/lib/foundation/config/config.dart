import 'package:dotto/data/config_data_source.dart';
import 'package:dotto/foundation/config/remote_config.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'config.g.dart';

@Riverpod(keepAlive: true)
T config<T>(Ref ref, RemoteConfig<T> config) =>
    ref.watch(configDataSourceProvider).get(config);
