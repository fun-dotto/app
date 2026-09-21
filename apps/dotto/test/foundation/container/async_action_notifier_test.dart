import 'dart:async';

import 'package:dotto/foundation/container/async_action_notifier.dart';
import 'package:dotto/foundation/container/async_entity.dart';
import 'package:dotto/foundation/container/async_status.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

/// テスト対象の mixin を動かすための最小の Notifier。
final class _CounterAction extends Notifier<AsyncEntity<int>>
    with AsyncActionNotifierMixin<int> {
  Completer<int> completer = Completer<int>();
  int callCount = 0;

  @override
  AsyncEntity<int> build() => initialState();

  Future<void> submit() => run(() {
    callCount++;
    return completer.future;
  });
}

final _counterActionProvider =
    NotifierProvider<_CounterAction, AsyncEntity<int>>(_CounterAction.new);

void main() {
  ProviderContainer createContainer() {
    final container = ProviderContainer();
    addTearDown(container.dispose);
    return container;
  }

  test('build 直後は status=idle で自動実行されない', () {
    final container = createContainer();

    final state = container.read(_counterActionProvider);
    final notifier = container.read(_counterActionProvider.notifier);

    expect(state.status, AsyncStatus.idle);
    expect(state.entity, isNull);
    expect(notifier.callCount, 0);
  });

  test('submit で loading に遷移し、成功すると success と結果を保持する', () async {
    final container = createContainer();
    final notifier = container.read(_counterActionProvider.notifier);

    final future = notifier.submit();
    expect(container.read(_counterActionProvider).status, AsyncStatus.loading);

    notifier.completer.complete(1);
    await future;

    final state = container.read(_counterActionProvider);
    expect(state.status, AsyncStatus.success);
    expect(state.entity, 1);
    expect(state.error, isNull);
  });

  test('失敗すると failure と error を保持する', () async {
    final container = createContainer();
    final notifier = container.read(_counterActionProvider.notifier);

    final future = notifier.submit();
    notifier.completer.completeError(Exception('failed'));
    await future;

    final state = container.read(_counterActionProvider);
    expect(state.status, AsyncStatus.failure);
    expect(state.error, isA<Exception>());
    expect(state.entity, isNull);
  });

  test('実行中の submit は無視され、二重送信されない', () async {
    final container = createContainer();
    final notifier = container.read(_counterActionProvider.notifier);

    final future = notifier.submit();
    await notifier.submit();

    expect(notifier.callCount, 1);

    notifier.completer.complete(1);
    await future;

    expect(notifier.callCount, 1);
  });

  test('再実行時は前回の error を引き継がない', () async {
    final container = createContainer();
    final notifier = container.read(_counterActionProvider.notifier);

    final failed = notifier.submit();
    notifier.completer.completeError(Exception('failed'));
    await failed;
    expect(container.read(_counterActionProvider).error, isNotNull);

    notifier.completer = Completer<int>();
    final succeeded = notifier.submit();
    expect(container.read(_counterActionProvider).error, isNull);

    notifier.completer.complete(2);
    await succeeded;

    final state = container.read(_counterActionProvider);
    expect(state.status, AsyncStatus.success);
    expect(state.entity, 2);
    expect(state.error, isNull);
  });

  test('reset で未実行の状態へ戻る', () async {
    final container = createContainer();
    final notifier = container.read(_counterActionProvider.notifier);

    final future = notifier.submit();
    notifier.completer.complete(1);
    await future;

    notifier.reset();

    final state = container.read(_counterActionProvider);
    expect(state.status, AsyncStatus.idle);
    expect(state.entity, isNull);
    expect(state.error, isNull);
  });
}
