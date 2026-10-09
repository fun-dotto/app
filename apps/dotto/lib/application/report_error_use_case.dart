import 'package:dotto/data/error_report_repository_impl.dart';
import 'package:dotto/domain/repository/error_report_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'report_error_use_case.g.dart';

final class ReportErrorUseCase {
  const new(this._repository);
  final ErrorReportRepository _repository;
  Future<void> call(Object error, StackTrace stack, {required String reason}) =>
      _repository.report(error, stack, reason: reason);
}

@riverpod
ReportErrorUseCase reportErrorUseCase(Ref ref) =>
    ReportErrorUseCase(ref.watch(errorReportRepositoryProvider));
