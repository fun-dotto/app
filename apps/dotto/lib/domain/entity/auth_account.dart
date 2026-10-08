import 'package:dotto/domain/entity/dotto_user.dart' show DottoUser;
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_account.freezed.dart';

/// 認証基盤上のアカウント。
///
/// Dotto 上のプロフィール ([DottoUser]) とは別に、ログイン状態の判定に使う。
@freezed
abstract class AuthAccount with _$AuthAccount {
  const factory({
    required String id,
    required String name,
    required String email,
    required String avatarUrl,
  }) = _AuthAccount;
}
