import 'dart:async';

import 'package:dotto/data/auth_data_source.dart';
import 'package:dotto/domain/entity/auth_account.dart';

/// サインインすると [accountToSignIn] でログインした状態になる認証基盤のフェイク。
final class FakeAuthDataSource implements AuthDataSource {
  new({this.accountToSignIn, this._currentAccount});

  final AuthAccount? accountToSignIn;
  AuthAccount? _currentAccount;
  final _controller = StreamController<AuthAccount?>.broadcast();

  @override
  Stream<AuthAccount?> authStateChanges() async* {
    yield _currentAccount;
    yield* _controller.stream;
  }

  @override
  Future<void> signIn() async {
    final account = accountToSignIn;
    if (account == null) {
      throw Exception('sign in cancelled');
    }
    _currentAccount = account;
    _controller.add(account);
  }

  @override
  Future<void> signOut() async {
    _currentAccount = null;
    _controller.add(null);
  }
}
