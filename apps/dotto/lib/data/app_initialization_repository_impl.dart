import 'package:dotto/domain/entity/domain_error.dart';
import 'package:dotto/domain/repository/app_initialization_repository.dart';
import 'package:dotto/foundation/log/logger.dart';
import 'package:dotto/helper/notification_helper.dart';
import 'package:dotto/helper/remote_config_helper.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_initialization_repository_impl.g.dart';

@riverpod
AppInitializationRepository appInitializationRepository(Ref ref) =>
    AppInitializationRepositoryImpl(
      ref.watch(remoteConfigHelperProvider),
      ref.watch(notificationHelperProvider),
      ref.watch(loggerProvider),
    );

final class AppInitializationRepositoryImpl
    implements AppInitializationRepository {
  const new(this._remoteConfig, this._notifications, this._logger);
  final RemoteConfigHelper _remoteConfig;
  final NotificationHelper _notifications;
  final Logger _logger;

  @override
  Future<void> initialize() async {
    try {
      await _remoteConfig.setup();
      await _notifications.setupInteractedMessage();
      await _logger.setup();
    } on Exception catch (error, stack) {
      throw DomainError.fromException(e: error, stackTrace: stack);
    }
  }
}
