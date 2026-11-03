import 'dart:async';

import 'package:connectrpc/connect.dart';

/// [FakeAppApi] に登録するハンドラー。
typedef FakeAppApiHandler<I, O> = FutureOr<O> Function(I request);

/// 登録したハンドラーで app API の RPC に応答するインメモリの [Transport]。
///
/// 未登録の RPC には [Code.notFound] を返す。
final class FakeAppApi implements Transport {
  final _handlers = <Spec<Object, Object>, Function>{};

  /// 受け取ったリクエストを呼び出し順に記録する。
  final requests = <Object>[];

  /// [spec] の RPC に [handler] で応答する。
  void on<I extends Object, O extends Object>(
    Spec<I, O> spec,
    FakeAppApiHandler<I, O> handler,
  ) {
    _handlers[spec] = handler;
  }

  /// [spec] の RPC に [code] のエラーで応答する。
  void fail<I extends Object, O extends Object>(
    Spec<I, O> spec, [
    Code code = Code.internal,
  ]) {
    on<I, O>(spec, (_) => throw ConnectException(code, 'fake error'));
  }

  @override
  Future<UnaryResponse<I, O>> unary<I extends Object, O extends Object>(
    Spec<I, O> spec,
    I input, [
    CallOptions? options,
  ]) async {
    requests.add(input);
    final handler = _handlers[spec] as FakeAppApiHandler<I, O>?;
    if (handler == null) {
      throw ConnectException(Code.notFound, '${spec.procedure} not found');
    }
    final message = await handler(input);
    return UnaryResponse(spec, Headers(), message, Headers());
  }

  @override
  Future<StreamResponse<I, O>> stream<I extends Object, O extends Object>(
    Spec<I, O> spec,
    Stream<I> input, [
    CallOptions? options,
  ]) {
    throw UnimplementedError();
  }
}
