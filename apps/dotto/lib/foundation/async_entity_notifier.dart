import 'dart:async';

import 'package:dotto/foundation/async_entity.dart';
import 'package:dotto/foundation/async_status.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

mixin AsyncEntityNotifierMixin<T extends Object> on $Notifier<AsyncEntity<T>> {
  Future<T> fetch();

  AsyncEntity<T> initialState() {
    unawaited(Future.microtask(load));
    return AsyncEntity<T>();
  }

  Future<void> load({AsyncStatus status = AsyncStatus.loading}) async {
    state = state.copyWith(status: status);
    try {
      final entity = await fetch();
      state = state.copyWith(status: AsyncStatus.success, entity: entity);
    } on Object catch (error) {
      state = state.copyWith(status: AsyncStatus.failure, error: error);
    }
  }

  Future<void> refresh() => load(status: AsyncStatus.refreshing);
}
