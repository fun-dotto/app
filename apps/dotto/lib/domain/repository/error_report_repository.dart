abstract interface class ErrorReportRepository {
  Future<void> report(Object error, StackTrace stack, {required String reason});
}
