import 'package:dotto/data/debug_token_data_source.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

final class DebugTokenDataSourceImpl implements DebugTokenDataSource {
  const new();

  @override
  Future<String?> fetchAppCheckToken() => FirebaseAppCheck.instance.getToken();

  @override
  Future<String?> fetchIdToken() async =>
      await FirebaseAuth.instance.currentUser?.getIdToken();

  @override
  Future<String?> fetchFcmToken() => FirebaseMessaging.instance.getToken();
}
