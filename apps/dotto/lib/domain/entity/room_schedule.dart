import 'package:freezed_annotation/freezed_annotation.dart';

part 'room_schedule.freezed.dart';
part 'room_schedule.g.dart';

@freezed
abstract class RoomSchedule with _$RoomSchedule {
  //
  // ignore: invalid_annotation_target
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory({
    required DateTime beginDatetime,
    required DateTime endDatetime,
    required String title,
  }) = _RoomSchedule;

  factory fromJson(Map<String, Object?> json) => _$RoomScheduleFromJson(json);
}
