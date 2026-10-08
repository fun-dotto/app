import 'package:dotto/domain/analytics_repository.dart';
import 'package:dotto/foundation/log/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'analytics_repository_impl.g.dart';

@riverpod
AnalyticsRepository analyticsRepository(Ref ref) =>
    AnalyticsRepositoryImpl(ref.watch(loggerProvider));

final class AnalyticsRepositoryImpl implements AnalyticsRepository {
  const new(this._logger);

  final Logger _logger;

  @override
  Future<void> logLogin() => _logger.logLogin();

  @override
  Future<void> logLogout() => _logger.logLogout();
}
