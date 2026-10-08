import 'package:dotto/data/debug_token_data_source_impl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'debug_token_data_source.g.dart';

@riverpod
DebugTokenDataSource debugTokenDataSource(Ref ref) =>
    const DebugTokenDataSourceImpl();

/// 開発者向けに各種 Firebase のトークンを取得する。
abstract interface class DebugTokenDataSource {
  Future<String?> fetchAppCheckToken();

  Future<String?> fetchIdToken();

  Future<String?> fetchFcmToken();
}
