import 'package:dotto/domain/entity/auth_account.dart';
import 'package:dotto/domain/entity/dotto_user.dart';

abstract interface class UserRepository {
  /// [account] に紐づくユーザーを取得する。未登録の場合は `null` を返す。
  Future<DottoUser?> fetch(AuthAccount account);

  /// [user] を登録または更新し、保存後のユーザーを返す。
  Future<DottoUser> save(DottoUser user);
}
