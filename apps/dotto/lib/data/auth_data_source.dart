import 'package:dotto/data/auth_data_source_impl.dart';
import 'package:dotto/domain/auth_account.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_data_source.g.dart';

@Riverpod(keepAlive: true)
AuthDataSource authDataSource(Ref ref) => const AuthDataSourceImpl();

/// 認証基盤 (Firebase Authentication と Google Sign-In) へのアクセスを担う。
abstract interface class AuthDataSource {
  Stream<AuthAccount?> authStateChanges();

  Future<void> signIn();

  Future<void> signOut();
}
