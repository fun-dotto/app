import 'dart:async';

import 'package:dotto/foundation/async_entity.dart';
import 'package:dotto/foundation/async_status.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

/// [AsyncEntity] を状態に持つ Notifier の共通処理を提供する mixin。
///
/// サブクラスは [fetch] を実装するだけで、読み込み・更新・エラーハンドリングの
/// 状態遷移が共通化される。
mixin AsyncStateNotifier<T extends Object> on $Notifier<AsyncEntity<T>> {
  /// 実際のデータ取得処理。サブクラスで実装する。
  Future<T> fetch();

  AsyncEntity<T> build() {
    unawaited(_load());
    return const AsyncEntity();
  }

  /// 引っ張って更新する。
  Future<void> refresh() => _load(status: AsyncStatus.refreshing);

  Future<void> _load({AsyncStatus status = AsyncStatus.loading}) async {
    state = state.copyWith(status: status);
    try {
      final entity = await fetch();
      state = state.copyWith(status: AsyncStatus.success, entity: entity);
    } on Object catch (error) {
      state = state.copyWith(status: AsyncStatus.failure, error: error);
    }
  }
}
