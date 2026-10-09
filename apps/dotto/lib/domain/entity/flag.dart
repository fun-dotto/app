import 'package:freezed_annotation/freezed_annotation.dart';
part 'flag.freezed.dart';

@freezed
abstract class Flag<T> with _$Flag<T> {
  const factory({
    required String key,
    required String description,
    required T defaultValue,
  }) = _Flag<T>;
}
