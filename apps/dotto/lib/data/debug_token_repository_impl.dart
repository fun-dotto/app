import 'package:dotto/data/debug_token_data_source.dart';
import 'package:dotto/domain/entity/debug_tokens.dart';
import 'package:dotto/domain/repository/debug_token_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'debug_token_repository_impl.g.dart';

@riverpod
DebugTokenRepository debugTokenRepository(Ref ref) =>
    DebugTokenRepositoryImpl(ref.watch(debugTokenDataSourceProvider));

final class DebugTokenRepositoryImpl implements DebugTokenRepository {
  const new(this._dataSource);

  final DebugTokenDataSource _dataSource;

  @override
  Future<DebugTokens> fetch() async {
    // 各トークンは独立して取得し、失敗したものだけ null にする
    // (App Check の Debug Token 未登録などで他の情報まで表示できなくならないように)
    final [appCheckToken, idToken, fcmToken] = await Future.wait([
      _fetchOrNull('App Check', _dataSource.fetchAppCheckToken),
      _fetchOrNull('ID', _dataSource.fetchIdToken),
      _fetchOrNull('FCM', _dataSource.fetchFcmToken),
    ]);
    return DebugTokens(
      appCheckToken: appCheckToken,
      idToken: idToken,
      fcmToken: fcmToken,
    );
  }

  Future<String?> _fetchOrNull(
    String label,
    Future<String?> Function() fetch,
  ) async {
    try {
      return await fetch();
    } on Exception catch (e) {
      debugPrint('Failed to fetch $label token: $e');
      return null;
    }
  }
}
