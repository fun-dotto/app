//
//  Generated code. Do not modify.
//  source: app/v1/fcm_token.proto
//

import "package:connectrpc/connect.dart" as connect;
import "fcm_token.pb.dart" as appv1fcm_token;

/// ログイン中のユーザーの FCM トークンを管理する。
abstract final class FcmTokenService {
  /// Fully-qualified name of the FcmTokenService service.
  static const name = 'app.v1.FcmTokenService';

  /// FCM トークンを登録する。存在しない場合は作成し、存在する場合は更新日時を更新する。
  /// 他のユーザーに登録済みのトークンの場合は PERMISSION_DENIED を返す。
  static const registerFcmToken = connect.Spec(
    '/$name/RegisterFcmToken',
    connect.StreamType.unary,
    appv1fcm_token.RegisterFcmTokenRequest.new,
    appv1fcm_token.RegisterFcmTokenResponse.new,
  );
}
