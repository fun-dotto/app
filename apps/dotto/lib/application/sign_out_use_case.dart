import 'package:dotto/data/analytics_repository_impl.dart';
import 'package:dotto/data/auth_repository_impl.dart';
import 'package:dotto/domain/analytics_repository.dart';
import 'package:dotto/domain/auth_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'sign_out_use_case.g.dart';

final class SignOutUseCase {
  const new(this._authRepository, this._analyticsRepository);

  final AuthRepository _authRepository;
  final AnalyticsRepository _analyticsRepository;

  Future<void> call() async {
    await _authRepository.signOut();
    await _analyticsRepository.logLogout();
  }
}

@riverpod
SignOutUseCase signOutUseCase(Ref ref) => SignOutUseCase(
  ref.watch(authRepositoryProvider),
  ref.watch(analyticsRepositoryProvider),
);
