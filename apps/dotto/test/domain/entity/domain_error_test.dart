import 'package:dotto/domain/entity/domain_error.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('原因の例外から種類ごとのドメインエラーを作る', () {
    const cause = FormatException('原因');
    final stackTrace = StackTrace.current;
    final factories =
        <DomainErrorType, DomainError Function(Exception, StackTrace)>{
          DomainErrorType.network: (e, s) =>
              DomainError.network(e: e, stackTrace: s),
          DomainErrorType.server: (e, s) =>
              DomainError.server(e: e, stackTrace: s),
          DomainErrorType.notFound: (e, s) =>
              DomainError.notFound(e: e, stackTrace: s),
          DomainErrorType.invalidResponse: (e, s) =>
              DomainError.invalidResponse(e: e, stackTrace: s),
          DomainErrorType.unauthorized: (e, s) =>
              DomainError.unauthorized(e: e, stackTrace: s),
          DomainErrorType.forbidden: (e, s) =>
              DomainError.forbidden(e: e, stackTrace: s),
          DomainErrorType.invalidData: (e, s) =>
              DomainError.invalidData(e: e, stackTrace: s),
          DomainErrorType.unknown: (e, s) =>
              DomainError.unknown(e: e, stackTrace: s),
        };

    for (final MapEntry(key: type, value: create) in factories.entries) {
      final error = create(cause, stackTrace);

      expect(error.type, type);
      expect(error.message, cause.toString());
      expect(error.stackTrace, stackTrace);
      expect(error.toString(), 'DomainError: $cause');
    }
  });
}
