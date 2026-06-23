import 'package:dotto/foundation/async_status.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'async_entity.freezed.dart';

@freezed
abstract class AsyncEntity<T extends Object> with _$AsyncEntity<T> {
  const factory AsyncEntity({
    T? entity,
    Object? error,
    @Default(AsyncStatus.idle) AsyncStatus status,
  }) = _AsyncEntity<T>;
}
