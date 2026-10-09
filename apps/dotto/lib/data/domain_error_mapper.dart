import 'package:dio/dio.dart';
import 'package:dotto/domain/entity/domain_error.dart';
import 'package:firebase_core/firebase_core.dart';

DomainError mapDomainError({required Exception e, StackTrace? stackTrace}) {
  if (e is DioException) {
    return _fromDioException(e: e, stackTrace: stackTrace);
  }
  if (e is FirebaseException) {
    return _fromFirebaseException(e: e, stackTrace: stackTrace);
  }
  return DomainError.unknown(e: e, stackTrace: stackTrace);
}

DomainError _fromDioException({
  required DioException e,
  StackTrace? stackTrace,
}) {
  switch (e.type) {
    case DioExceptionType.connectionTimeout:
    case DioExceptionType.sendTimeout:
    case DioExceptionType.receiveTimeout:
    case DioExceptionType.transformTimeout:
    case DioExceptionType.connectionError:
      return DomainError.network(e: e, stackTrace: stackTrace);
    case DioExceptionType.badResponse:
      final statusCode = e.response?.statusCode;
      if (statusCode != null) {
        if (statusCode == 401) {
          return DomainError.unauthorized(e: e, stackTrace: stackTrace);
        }
        if (statusCode == 403) {
          return DomainError.forbidden(e: e, stackTrace: stackTrace);
        }
        if (statusCode == 404) {
          return DomainError.notFound(e: e, stackTrace: stackTrace);
        }
        if (statusCode >= 500) {
          return DomainError.server(e: e, stackTrace: stackTrace);
        }
      }
      return DomainError.invalidResponse(e: e, stackTrace: stackTrace);
    case DioExceptionType.cancel:
    case DioExceptionType.badCertificate:
    case DioExceptionType.unknown:
      return DomainError.network(e: e, stackTrace: stackTrace);
  }
}

DomainError _fromFirebaseException({
  required FirebaseException e,
  StackTrace? stackTrace,
}) {
  switch (e.code) {
    case 'unavailable':
    case 'deadline-exceeded':
      return DomainError.network(e: e, stackTrace: stackTrace);
    case 'not-found':
      return DomainError.notFound(e: e, stackTrace: stackTrace);
    case 'permission-denied':
      return DomainError.forbidden(e: e, stackTrace: stackTrace);
    case 'unauthenticated':
      return DomainError.unauthorized(e: e, stackTrace: stackTrace);
    case 'internal':
    case 'data-loss':
      return DomainError.server(e: e, stackTrace: stackTrace);
    case 'invalid-argument':
    case 'failed-precondition':
    case 'out-of-range':
      return DomainError.invalidData(e: e, stackTrace: stackTrace);
    default:
      return DomainError.unknown(e: e, stackTrace: stackTrace);
  }
}
