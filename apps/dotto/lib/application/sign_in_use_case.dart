import 'package:dotto/data/analytics_repository_impl.dart';
import 'package:dotto/data/auth_repository_impl.dart';
import 'package:dotto/domain/analytics_repository.dart';
import 'package:dotto/domain/auth_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'sign_in_use_case.g.dart';

final class SignInUseCase {
  const new(this._authRepository, this._analyticsRepository);

  final AuthRepository _authRepository;
  final AnalyticsRepository _analyticsRepository;

  Future<void> call() async {
    await _authRepository.signIn();
    await _analyticsRepository.logLogin();
  }
}

@riverpod
SignInUseCase signInUseCase(Ref ref) => SignInUseCase(
  ref.watch(authRepositoryProvider),
  ref.watch(analyticsRepositoryProvider),
);
