import 'package:dotto/data/auth_data_source.dart';
import 'package:dotto/domain/entity/auth_account.dart';
import 'package:dotto/domain/entity/domain_error.dart';
import 'package:dotto/domain/repository/auth_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_repository_impl.g.dart';

@riverpod
AuthRepository authRepository(Ref ref) =>
    AuthRepositoryImpl(ref.watch(authDataSourceProvider));

final class AuthRepositoryImpl implements AuthRepository {
  const new(this._dataSource);

  final AuthDataSource _dataSource;

  @override
  Stream<AuthAccount?> watchAccount() => _dataSource.authStateChanges();

  @override
  Future<void> signIn() => _guard(_dataSource.signIn);

  @override
  Future<void> signOut() => _guard(_dataSource.signOut);

  Future<void> _guard(Future<void> Function() action) async {
    try {
      await action();
    } on DomainError {
      rethrow;
    } on Exception catch (e, stackTrace) {
      throw DomainError.fromException(e: e, stackTrace: stackTrace);
    }
  }
}
