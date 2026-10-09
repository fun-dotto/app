import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'push_token_data_source.g.dart';

@riverpod
PushTokenDataSource pushTokenDataSource(Ref ref) => const PushTokenDataSource();

class PushTokenDataSource {
  const new();
  Stream<String> watchRefreshes() => FirebaseMessaging.instance.onTokenRefresh;
  Future<String?> fetch() => FirebaseMessaging.instance.getToken();
}
