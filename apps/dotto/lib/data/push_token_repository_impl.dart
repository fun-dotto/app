import 'package:dotto/api/api_client.dart';
import 'package:dotto/data/push_token_data_source.dart';
import 'package:dotto/domain/entity/domain_error.dart';
import 'package:dotto/domain/repository/push_token_repository.dart';
import 'package:openapi/openapi.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'push_token_repository_impl.g.dart';

@riverpod
PushTokenRepository pushTokenRepository(Ref ref) => PushTokenRepositoryImpl(
  ref.watch(apiClientProvider),
  ref.watch(pushTokenDataSourceProvider),
);

final class PushTokenRepositoryImpl implements PushTokenRepository {
  const new(this._api, this._tokens);
  final Openapi _api;
  final PushTokenDataSource _tokens;
  @override
  Stream<String> watchRefreshes() async* {
    try {
      await for (final token in _tokens.watchRefreshes()) {
        yield token;
      }
    } on Exception catch (error, stack) {
      throw DomainError.fromException(e: error, stackTrace: stack);
    }
  }

  @override
  Future<void> synchronize([String? token]) async {
    try {
      final value = token ?? await _tokens.fetch();
      if (value == null) return;
      await _api.getFCMTokensApi().fCMTokenV1Upsert(
        fCMTokenRequest: FCMTokenRequest((builder) => builder.token = value),
      );
    } on Exception catch (error, stack) {
      throw DomainError.fromException(e: error, stackTrace: stack);
    }
  }
}
