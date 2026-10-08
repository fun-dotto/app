import 'package:dotto/data/user_repository_impl.dart';
import 'package:dotto/domain/entity/auth_account.dart';
import 'package:dotto/domain/entity/dotto_user.dart';
import 'package:dotto/domain/repository/user_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'fetch_current_user_use_case.g.dart';

/// ログイン中のアカウントに対応するユーザーを取得する。
///
/// 初回ログインでユーザーが未登録の場合は、アカウント情報から登録する。
final class FetchCurrentUserUseCase {
  const new(this._repository);

  final UserRepository _repository;

  Future<DottoUser> call(AuthAccount account) async {
    final existingUser = await _repository.fetch(account);
    if (existingUser != null) {
      return existingUser;
    }
    return await _repository.save(
      DottoUser(
        id: account.id,
        name: account.name,
        email: account.email,
        avatarUrl: account.avatarUrl,
      ),
    );
  }
}

@riverpod
FetchCurrentUserUseCase fetchCurrentUserUseCase(Ref ref) =>
    FetchCurrentUserUseCase(ref.watch(userRepositoryProvider));
