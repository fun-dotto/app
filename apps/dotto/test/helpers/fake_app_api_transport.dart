import 'dart:async';

import 'package:connectrpc/connect.dart' as connect;

typedef FakeAppApiHandler<I, O> = FutureOr<O> Function(I request);

/// 登録したハンドラーで app-api の RPC に応答するインメモリの Transport。
///
/// 未登録の RPC には [connect.Code.notFound] を返す。
final class FakeAppApiTransport implements connect.Transport {
  final _handlers = <String, FutureOr<Object> Function(Object)>{};

  /// 受け取ったリクエストを RPC の procedure 単位で記録する。
  final requests = <String, List<Object>>{};

  void on<I extends Object, O extends Object>(
    connect.Spec<I, O> spec,
    FakeAppApiHandler<I, O> handler,
  ) {
    _handlers[spec.procedure] = (request) => handler(request as I);
  }

  /// [spec] の呼び出しを [code] のエラーで失敗させる。
  void fail<I extends Object, O extends Object>(
    connect.Spec<I, O> spec, [
    connect.Code code = connect.Code.internal,
  ]) {
    on<I, O>(spec, (_) => throw connect.ConnectException(code, 'fake error'));
  }

  @override
  Future<connect.UnaryResponse<I, O>> unary<I extends Object, O extends Object>(
    connect.Spec<I, O> spec,
    I input, [
    connect.CallOptions? options,
  ]) async {
    (requests[spec.procedure] ??= []).add(input);
    final handler = _handlers[spec.procedure];
    if (handler == null) {
      throw connect.ConnectException(
        connect.Code.notFound,
        '${spec.procedure} is not registered',
      );
    }
    final output = await handler(input) as O;
    return connect.UnaryResponse(
      spec,
      connect.Headers(),
      output,
      connect.Headers(),
    );
  }

  @override
  Future<connect.StreamResponse<I, O>>
  stream<I extends Object, O extends Object>(
    connect.Spec<I, O> spec,
    Stream<I> input, [
    connect.CallOptions? options,
  ]) => throw UnimplementedError('Streaming RPC is not supported');
}
