import 'package:dotto/foundation/async_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'screen_states.freezed.dart';

@freezed
abstract class ScreenStates<T extends Object> with _$ScreenStates<T> {
  const factory ScreenStates({
    /// 全ての状態
    required List<AsyncEntity> states,

    /// 必須の状態
    required List<AsyncEntity> requiredStates,
  }) = _ScreenStates<T>;
}
