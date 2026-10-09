import 'package:dotto/domain/entity/day_of_week.dart';
import 'package:dotto/domain/entity/period.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'room_assignment_index.freezed.dart';

@freezed
abstract class RoomAssignmentIndex with _$RoomAssignmentIndex {
  const factory({
    required Map<({DayOfWeek dayOfWeek, Period period, String title}), String>
    roomNamesBySlotAndTitle,
    required Map<String, String> roomNamesByTitle,
  }) = _RoomAssignmentIndex;
  const new _();

  String? roomName({
    required DayOfWeek dayOfWeek,
    required Period period,
    required String title,
  }) {
    return roomNamesBySlotAndTitle[(
          dayOfWeek: dayOfWeek,
          period: period,
          title: title,
        )] ??
        roomNamesByTitle[title];
  }

  String? roomNameByTitle(String title) {
    return roomNamesByTitle[title];
  }
}
