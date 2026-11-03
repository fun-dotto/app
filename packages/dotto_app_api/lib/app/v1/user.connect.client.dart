//
//  Generated code. Do not modify.
//  source: app/v1/user.proto
//

import "package:connectrpc/connect.dart" as connect;
import "user.pb.dart" as appv1user;
import "user.connect.spec.dart" as specs;

/// ログイン中のユーザーを管理する。
extension type UserServiceClient (connect.Transport _transport) {
  /// ログイン中のユーザーを取得する。
  Future<appv1user.GetUserResponse> getUser(
    appv1user.GetUserRequest input, {
    connect.Headers? headers,
    connect.AbortSignal? signal,
    Function(connect.Headers)? onHeader,
    Function(connect.Headers)? onTrailer,
  }) {
    return connect.Client(_transport).unary(
      specs.UserService.getUser,
      input,
      signal: signal,
      headers: headers,
      onHeader: onHeader,
      onTrailer: onTrailer,
    );
  }

  /// ログイン中のユーザーを更新する。存在しない場合は作成する。
  Future<appv1user.UpdateUserResponse> updateUser(
    appv1user.UpdateUserRequest input, {
    connect.Headers? headers,
    connect.AbortSignal? signal,
    Function(connect.Headers)? onHeader,
    Function(connect.Headers)? onTrailer,
  }) {
    return connect.Client(_transport).unary(
      specs.UserService.updateUser,
      input,
      signal: signal,
      headers: headers,
      onHeader: onHeader,
      onTrailer: onTrailer,
    );
  }
}
