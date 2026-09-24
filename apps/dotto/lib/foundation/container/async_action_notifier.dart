import 'package:dotto/foundation/container/async_entity.dart';
import 'package:dotto/foundation/container/async_status.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

/// 書き込み系の処理（POST/PUT/DELETE など）の状態を扱う mixin。
///
/// 読み取り系の `AsyncEntityNotifierMixin` と異なり、生成時に自動実行せず、
/// 画面の操作を起点に [run] で明示的に実行する。
mixin AsyncActionNotifierMixin<T extends Object> on $Notifier<AsyncEntity<T>> {
  /// 未実行の初期状態。`build()` から返す。
  AsyncEntity<T> initialState() => AsyncEntity<T>();

  /// 実行中かどうか。送信ボタンの無効化に使う。
  bool get isRunning => state.status == AsyncStatus.loading;

  /// [action] を実行し、結果を状態へ反映する。
  ///
  /// 実行中の再実行は無視することで二重送信を防ぐ。
  Future<void> run(Future<T> Function() action) async {
    if (isRunning) {
      return;
    }
    state = AsyncEntity<T>(status: AsyncStatus.loading);
    try {
      final entity = await action();
      state = state.copyWith(status: AsyncStatus.success, entity: entity);
    } on Object catch (error) {
      state = state.copyWith(status: AsyncStatus.failure, error: error);
    }
  }

  /// 状態を未実行に戻す。同一画面で続けて実行する場合に使う。
  void reset() {
    state = AsyncEntity<T>();
  }
}
