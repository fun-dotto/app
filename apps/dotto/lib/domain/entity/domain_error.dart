final class DomainError implements Exception {
  const new({required this.type, required this.message, this.stackTrace});

  factory network({required Exception e, StackTrace? stackTrace}) =>
      DomainError(
        type: DomainErrorType.network,
        message: e.toString(),
        stackTrace: stackTrace,
      );

  factory server({required Exception e, StackTrace? stackTrace}) => DomainError(
    type: DomainErrorType.server,
    message: e.toString(),
    stackTrace: stackTrace,
  );

  factory notFound({required Exception e, StackTrace? stackTrace}) =>
      DomainError(
        type: DomainErrorType.notFound,
        message: e.toString(),
        stackTrace: stackTrace,
      );

  factory invalidResponse({required Exception e, StackTrace? stackTrace}) =>
      DomainError(
        type: DomainErrorType.invalidResponse,
        message: e.toString(),
        stackTrace: stackTrace,
      );

  factory unauthorized({required Exception e, StackTrace? stackTrace}) =>
      DomainError(
        type: DomainErrorType.unauthorized,
        message: e.toString(),
        stackTrace: stackTrace,
      );

  factory forbidden({required Exception e, StackTrace? stackTrace}) =>
      DomainError(
        type: DomainErrorType.forbidden,
        message: e.toString(),
        stackTrace: stackTrace,
      );

  factory invalidData({required Exception e, StackTrace? stackTrace}) =>
      DomainError(
        type: DomainErrorType.invalidData,
        message: e.toString(),
        stackTrace: stackTrace,
      );

  factory unknown({required Exception e, StackTrace? stackTrace}) =>
      DomainError(
        type: DomainErrorType.unknown,
        message: e.toString(),
        stackTrace: stackTrace,
      );

  final DomainErrorType type;
  final String message;
  final StackTrace? stackTrace;

  @override
  String toString() => 'DomainError: $message';
}

enum DomainErrorType {
  network,
  server,
  notFound,
  invalidResponse,
  unauthorized,
  forbidden,
  invalidData,
  unknown,
}
