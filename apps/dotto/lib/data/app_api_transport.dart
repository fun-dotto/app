import 'dart:io' as io;

import 'package:connectrpc/connect.dart' as connect;
import 'package:connectrpc/io.dart' as connect_io;
import 'package:connectrpc/protobuf.dart' as connect_protobuf;
import 'package:connectrpc/protocol/connect.dart' as connect_protocol;
import 'package:dotto/foundation/config/environment_configs.dart';
import 'package:dotto/foundation/log/logger.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_api_transport.g.dart';

/// app-api (Connect RPC) への Transport。
@Riverpod(keepAlive: true)
connect.Transport appApiTransport(Ref ref) {
  final httpClient = io.HttpClient()
    ..connectionTimeout = const Duration(seconds: 10);

  connect.AnyFn<I, O> authInterceptor<I extends Object, O extends Object>(
    connect.AnyFn<I, O> next,
  ) {
    return (request) async {
      debugPrint('Request: ${request.spec.procedure}');
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
        final response = await next(request);
        debugPrint('Response: OK ${request.spec.procedure}');
        return response;
      } on connect.ConnectException catch (e) {
        debugPrint('Response: ${e.code.name} ${request.spec.procedure}');
        rethrow;
      }
    };
  }

  return connect_protocol.Transport(
    baseUrl: EnvironmentConfigs.apiBaseUrl,
    codec: const connect_protobuf.ProtoCodec(),
    httpClient: connect_io.createHttpClient(httpClient),
    interceptors: [authInterceptor],
  );
}
