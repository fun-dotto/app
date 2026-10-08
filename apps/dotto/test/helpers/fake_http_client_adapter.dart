import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';

/// [FakeHttpClientAdapter] が返すレスポンス。
final class FakeResponse {
  const new(this.statusCode, [this.body]);

  final int statusCode;
  final Object? body;
}

typedef FakeHandler = FakeResponse Function(RequestOptions options);

/// 登録したハンドラーで HTTP リクエストに応答するインメモリのアダプター。
///
/// 未登録のパスには 404 を返す。
final class FakeHttpClientAdapter implements HttpClientAdapter {
  final _handlers = <String, FakeHandler>{};

  void on(String method, String path, FakeHandler handler) {
    _handlers['$method $path'] = handler;
  }

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    final handler = _handlers['${options.method} ${options.uri.path}'];
    final response = handler?.call(options) ?? const FakeResponse(404);
    return ResponseBody.fromString(
      jsonEncode(response.body),
      response.statusCode,
      headers: {
        Headers.contentTypeHeader: [Headers.jsonContentType],
      },
    );
  }

  @override
  void close({bool force = false}) {}
}

/// [adapter] を使って通信する [Dio] を作る。
Dio fakeDio(FakeHttpClientAdapter adapter) =>
    Dio(BaseOptions(baseUrl: 'https://example.com'))
      ..httpClientAdapter = adapter;
