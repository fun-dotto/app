import 'package:dotto/data/push_token_data_source.dart';

/// 通知トークンの取得・更新をメモリ上で供給する。
final class FakePushTokenDataSource extends PushTokenDataSource {
  const new(this.refreshes);
  final Stream<String> refreshes;
  @override
  Stream<String> watchRefreshes() => refreshes;
  @override
  Future<String?> fetch() async => 'token';
}
