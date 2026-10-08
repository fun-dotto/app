import 'package:dotto/domain/floor.dart';
import 'package:dotto/domain/room_schedule.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'room.freezed.dart';

@freezed
abstract class Room with _$Room {
  const factory({
    required String id,
    required String name,
    required String shortName,
    required String description,
    required Floor floor,
    required String email,
    required List<String> keywords,
    required List<RoomSchedule> schedules,
  }) = _Room;

  const new _();

  bool isInUse(DateTime dateTime) {
    return schedules.any(
      (schedule) =>
          (schedule.beginDatetime.isBefore(dateTime) ||
              schedule.beginDatetime.isAtSameMomentAs(dateTime)) &&
          (schedule.endDatetime.isAfter(dateTime) ||
              schedule.endDatetime.isAtSameMomentAs(dateTime)),
    );
  }
}
