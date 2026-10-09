import 'package:dotto/data/debug_token_data_source.dart';

/// 固定のトークンを返し、[error] を指定するとその例外で失敗するフェイク。
final class FakeDebugTokenDataSource implements DebugTokenDataSource {
  const new({this.appCheckToken, this.idToken, this.fcmToken, this.error});

  final String? appCheckToken;
  final String? idToken;
  final String? fcmToken;
  final Exception? error;

  Future<String?> _respond(String? token) async {
    if (error case final error?) throw error;
    return token;
  }

  @override
  Future<String?> fetchAppCheckToken() => _respond(appCheckToken);

  @override
  Future<String?> fetchIdToken() => _respond(idToken);

  @override
  Future<String?> fetchFcmToken() => _respond(fcmToken);
}
