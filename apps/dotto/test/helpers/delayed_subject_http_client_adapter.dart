import 'dart:async';
import 'dart:typed_data';

import 'package:dio/dio.dart';

import 'fake_http_client_adapter.dart';

/// 指定した検索リクエストの応答をテストから再開できる通信境界。
final class DelayedSubjectHttpClientAdapter implements HttpClientAdapter {
  new(this._adapter);
  final FakeHttpClientAdapter _adapter;
  final requested = Completer<void>();
  final resume = Completer<void>();
  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    if (options.uri.path == '/v1/subjects' &&
        options.queryParameters['q'] == '遅い') {
      requested.complete();
      await resume.future;
    }
    return await _adapter.fetch(options, requestStream, cancelFuture);
  }

  @override
  void close({bool force = false}) => _adapter.close(force: force);
}
