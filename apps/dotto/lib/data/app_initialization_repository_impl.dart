import 'package:dotto/data/domain_error_mapper.dart';
import 'package:dotto/data/notification_interaction_data_source.dart';
import 'package:dotto/data/remote_config_data_source.dart';
import 'package:dotto/domain/repository/app_initialization_repository.dart';
import 'package:dotto/foundation/log/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_initialization_repository_impl.g.dart';

@riverpod
AppInitializationRepository appInitializationRepository(Ref ref) =>
    AppInitializationRepositoryImpl(
      ref.watch(remoteConfigDataSourceProvider),
      ref.watch(notificationInteractionDataSourceProvider),
      ref.watch(loggerProvider),
    );

final class AppInitializationRepositoryImpl
    implements AppInitializationRepository {
  const new(this._remoteConfig, this._notifications, this._logger);
  final RemoteConfigDataSource _remoteConfig;
  final NotificationInteractionDataSource _notifications;
  final Logger _logger;

  @override
  Future<void> initialize() async {
    try {
      await _remoteConfig.setup();
      await _notifications.setupInteractedMessage();
      await _logger.setup();
    } on Exception catch (error, stack) {
      throw mapDomainError(e: error, stackTrace: stack);
    }
  }
}
