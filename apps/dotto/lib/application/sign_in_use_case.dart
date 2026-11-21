import 'package:dotto/data/analytics_repository_impl.dart';
import 'package:dotto/data/auth_repository_impl.dart';
import 'package:dotto/data/error_report_repository_impl.dart';
import 'package:dotto/domain/entity/domain_error.dart';
import 'package:dotto/domain/repository/analytics_repository.dart';
import 'package:dotto/domain/repository/auth_repository.dart';
import 'package:dotto/domain/repository/error_report_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'sign_in_use_case.g.dart';

final class SignInUseCase {
  const new(
    this._authRepository,
    this._analyticsRepository,
    this._errorReportRepository,
  );

  final AuthRepository _authRepository;
  final AnalyticsRepository _analyticsRepository;
  final ErrorReportRepository _errorReportRepository;

  Future<void> call() async {
    try {
      await _authRepository.signIn();
    } on DomainError catch (error, stackTrace) {
      // 画面には汎用的な失敗表示しか出さないため、原因の調査用に詳細を報告する
      await _errorReportRepository.report(
        error,
        error.stackTrace ?? stackTrace,
        reason: 'サインインに失敗',
      );
      rethrow;
    }
    await _analyticsRepository.logLogin();
  }
}

@riverpod
SignInUseCase signInUseCase(Ref ref) => SignInUseCase(
  ref.watch(authRepositoryProvider),
  ref.watch(analyticsRepositoryProvider),
  ref.watch(errorReportRepositoryProvider),
);
