import 'package:dotto/domain/auth_account.dart';

abstract interface class AuthRepository {
  /// ログイン状態の変化を購読する。未ログインの場合は `null` を流す。
  Stream<AuthAccount?> watchAccount();

  Future<void> signIn();

  Future<void> signOut();
}
