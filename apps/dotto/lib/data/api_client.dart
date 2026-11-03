import 'dart:io' as io;

import 'package:connectrpc/connect.dart';
import 'package:connectrpc/io.dart';
import 'package:connectrpc/protobuf.dart';
import 'package:connectrpc/protocol/connect.dart' as connect_protocol;
import 'package:dotto/foundation/config/environment_configs.dart';
import 'package:dotto/foundation/log/logger.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'api_client.g.dart';

const _connectionTimeout = Duration(seconds: 10);
const _requestTimeout = Duration(seconds: 15);

/// app API (Connect) と通信する [Transport]。
@Riverpod(keepAlive: true)
Transport apiClient(Ref ref) {
  final httpClient = io.HttpClient()..connectionTimeout = _connectionTimeout;
  return connect_protocol.Transport(
    baseUrl: EnvironmentConfigs.appApiBaseUrl,
    codec: const ProtoCodec(),
    httpClient: createHttpClient(httpClient),
    interceptors: [_authInterceptor(ref)],
  );
}

Interceptor _authInterceptor(Ref ref) {
  return <I extends Object, O extends Object>(next) {
    return (request) async {
      debugPrint('Request: ${request.url}');
      try {
        final appCheckToken = await FirebaseAppCheck.instance.getToken();
        if (appCheckToken != null) {
          request.headers['X-Firebase-AppCheck'] = 'Bearer $appCheckToken';
        }
      } on Exception catch (e, stack) {
        await ref
            .read(loggerProvider)
            .logError(e, stack, reason: 'Failed to get App Check token');
      }
      final idToken = await FirebaseAuth.instance.currentUser?.getIdToken();
      if (idToken != null) {
        request.headers['Authorization'] = 'Bearer $idToken';
      }
      try {
        final response = await next(request).timeout(_requestTimeout);
        debugPrint('Response: OK ${request.url}');
        return response;
      } on ConnectException catch (e) {
        debugPrint('Response: ${e.code.name} ${request.url}');
        rethrow;
      }
    };
  };
}
