import 'package:dotto/data/app_api_transport.dart';
import 'package:dotto/data/domain_error_mapper.dart';
import 'package:dotto/data/push_token_data_source.dart';
import 'package:dotto/domain/repository/push_token_repository.dart';
import 'package:dotto_app_api/app/v1/fcm_token.connect.client.dart';
import 'package:dotto_app_api/app/v1/fcm_token.pb.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'push_token_repository_impl.g.dart';

@riverpod
PushTokenRepository pushTokenRepository(Ref ref) => PushTokenRepositoryImpl(
  FcmTokenServiceClient(ref.watch(appApiTransportProvider)),
  ref.watch(pushTokenDataSourceProvider),
);

final class PushTokenRepositoryImpl implements PushTokenRepository {
  const new(this._client, this._tokens);
  final FcmTokenServiceClient _client;
  final PushTokenDataSource _tokens;
  @override
  Stream<String> watchRefreshes() async* {
    try {
      await for (final token in _tokens.watchRefreshes()) {
        yield token;
      }
    } on Exception catch (error, stack) {
      throw mapDomainError(e: error, stackTrace: stack);
    }
  }

  @override
  Future<void> synchronize([String? token]) async {
    try {
      final value = token ?? await _tokens.fetch();
      if (value == null) return;
      await _client.registerFcmToken(RegisterFcmTokenRequest(token: value));
    } on Exception catch (error, stack) {
      throw mapDomainError(e: error, stackTrace: stack);
    }
  }
}
