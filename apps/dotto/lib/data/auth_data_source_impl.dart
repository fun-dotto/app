import 'package:dotto/data/auth_data_source.dart';
import 'package:dotto/domain/entity/auth_account.dart';
import 'package:dotto/domain/entity/domain_error.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

final class AuthDataSourceImpl implements AuthDataSource {
  const new();

  @override
  Stream<AuthAccount?> authStateChanges() {
    return FirebaseAuth.instance.authStateChanges().map(
      (user) => switch (user) {
        null => null,
        final user => AuthAccount(
          id: user.uid,
          name: user.displayName ?? '',
          email: user.email ?? '',
          avatarUrl: user.photoURL ?? '',
        ),
      },
    );
  }

  @override
  Future<void> signIn() async {
    final account = await GoogleSignIn.instance.authenticate();
    final idToken = account.authentication.idToken;
    if (idToken == null) {
      throw const DomainError(
        type: DomainErrorType.unauthorized,
        message: 'Google Sign-In の ID token を取得できませんでした',
      );
    }
    final credential = await FirebaseAuth.instance.signInWithCredential(
      GoogleAuthProvider.credential(idToken: idToken),
    );
    final user = credential.user;
    if (user == null) {
      throw const DomainError(
        type: DomainErrorType.unauthorized,
        message: 'User is null',
      );
    }
    // メールアドレスで学内アカウントを識別するため、取得できないアカウントは残さない
    if (user.email == null) {
      await user.delete();
      throw const DomainError(
        type: DomainErrorType.unauthorized,
        message: 'User email is null',
      );
    }
  }

  @override
  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn.instance.signOut();
  }
}
