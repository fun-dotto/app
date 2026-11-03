//
//  Generated code. Do not modify.
//  source: app/v1/user.proto
//

import "package:connectrpc/connect.dart" as connect;
import "user.pb.dart" as appv1user;

/// ログイン中のユーザーを管理する。
abstract final class UserService {
  /// Fully-qualified name of the UserService service.
  static const name = 'app.v1.UserService';

  /// ログイン中のユーザーを取得する。
  static const getUser = connect.Spec(
    '/$name/GetUser',
    connect.StreamType.unary,
    appv1user.GetUserRequest.new,
    appv1user.GetUserResponse.new,
  );

  /// ログイン中のユーザーを更新する。存在しない場合は作成する。
  static const updateUser = connect.Spec(
    '/$name/UpdateUser',
    connect.StreamType.unary,
    appv1user.UpdateUserRequest.new,
    appv1user.UpdateUserResponse.new,
  );
}
