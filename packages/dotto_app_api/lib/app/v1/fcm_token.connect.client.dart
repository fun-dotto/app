//
//  Generated code. Do not modify.
//  source: app/v1/fcm_token.proto
//

import "package:connectrpc/connect.dart" as connect;
import "fcm_token.pb.dart" as appv1fcm_token;
import "fcm_token.connect.spec.dart" as specs;

/// ログイン中のユーザーの FCM トークンを管理する。
extension type FcmTokenServiceClient (connect.Transport _transport) {
  /// FCM トークンを登録する。存在しない場合は作成し、存在する場合は更新日時を更新する。
  /// 他のユーザーに登録済みのトークンの場合は PERMISSION_DENIED を返す。
  Future<appv1fcm_token.RegisterFcmTokenResponse> registerFcmToken(
    appv1fcm_token.RegisterFcmTokenRequest input, {
    connect.Headers? headers,
    connect.AbortSignal? signal,
    Function(connect.Headers)? onHeader,
    Function(connect.Headers)? onTrailer,
  }) {
    return connect.Client(_transport).unary(
      specs.FcmTokenService.registerFcmToken,
      input,
      signal: signal,
      headers: headers,
      onHeader: onHeader,
      onTrailer: onTrailer,
    );
  }
}
