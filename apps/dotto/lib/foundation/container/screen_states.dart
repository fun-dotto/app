import 'package:dotto/foundation/container/async_entity.dart';
import 'package:dotto/foundation/container/async_status.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'screen_states.freezed.dart';

@freezed
abstract class ScreenStates<T extends Object> with _$ScreenStates<T> {
  const factory ScreenStates({
    /// 全ての状態
    required List<AsyncEntity> states,

    /// 必須の状態
    @Default([]) List<AsyncEntity> optionalStates,
  }) = _ScreenStates<T>;

  const ScreenStates._();

  /// 必須の状態に読み込み中のものが含まれているか
  bool get isRequiredStatesLoading => states
      .where((item) => !optionalStates.contains(item))
      .any((state) => state.status == AsyncStatus.loading);

  /// 必須の状態に失敗したものが含まれているか
  bool get isRequiredStatesFailure => states
      .where((item) => !optionalStates.contains(item))
      .any((state) => state.status == AsyncStatus.failure);
}
