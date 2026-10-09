import 'package:dotto/domain/repository/error_report_repository.dart';
import 'package:dotto/foundation/log/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'error_report_repository_impl.g.dart';

@riverpod
ErrorReportRepository errorReportRepository(Ref ref) =>
    ErrorReportRepositoryImpl(ref.watch(loggerProvider));

final class ErrorReportRepositoryImpl implements ErrorReportRepository {
  const new(this._logger);
  final Logger _logger;
  @override
  Future<void> report(
    Object error,
    StackTrace stack, {
    required String reason,
  }) => _logger.logError(error, stack, reason: reason);
}
