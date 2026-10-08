import 'package:dotto/application/watch_auth_account_use_case.dart';
import 'package:dotto/domain/entity/auth_account.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_account_state.g.dart';

/// ログイン中のアカウント。未ログインの場合は `null`。
@Riverpod(keepAlive: true)
final class AuthAccountState extends _$AuthAccountState {
  @override
  Stream<AuthAccount?> build() => ref.watch(watchAuthAccountUseCaseProvider)();
}
