import 'package:dotto/foundation/config/remote_config.dart';
import 'package:dotto/repository/config_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'config_controller.g.dart';

@Riverpod(keepAlive: true)
T config<T>(Ref ref, RemoteConfig<T> config) =>
    ref.watch(configRepositoryProvider).get(config);
