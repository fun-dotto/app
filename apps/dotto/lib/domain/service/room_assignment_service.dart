import 'package:dotto/domain/entity/day_of_week.dart';
import 'package:dotto/domain/entity/period.dart';
import 'package:dotto/domain/entity/room.dart';
import 'package:dotto/domain/entity/room_assignment_index.dart';
import 'package:dotto/domain/entity/room_schedule.dart';

/// 部屋の利用予定から、授業名と時限ごとの部屋一覧を構築する。
final class RoomAssignmentService {
  const new();

  RoomAssignmentIndex build(List<Room> rooms) {
    final roomNamesBySlotAndTitle =
        <({DayOfWeek dayOfWeek, Period period, String title}), Set<String>>{};
    final roomNamesByTitle = <String, Set<String>>{};

    for (final room in rooms) {
      final roomName = room.shortName.trim();
      if (roomName.isEmpty) {
        continue;
      }

      for (final schedule in room.schedules) {
        final title = schedule.title.trim();
        if (title.isEmpty) {
          continue;
        }

        final period = _periodFromSchedule(schedule);
        if (period == null) {
          continue;
        }

        final key = (
          dayOfWeek: DayOfWeek.fromDateTime(schedule.beginDatetime),
          period: period,
          title: title,
        );
        roomNamesBySlotAndTitle
            .putIfAbsent(key, () => <String>{})
            .add(roomName);
        roomNamesByTitle.putIfAbsent(title, () => <String>{}).add(roomName);
      }
    }

    return RoomAssignmentIndex(
      roomNamesBySlotAndTitle: {
        for (final entry in roomNamesBySlotAndTitle.entries)
          entry.key: (entry.value.toList()..sort()).join(', '),
      },
      roomNamesByTitle: {
        for (final entry in roomNamesByTitle.entries)
          entry.key: (entry.value.toList()..sort()).join(', '),
      },
    );
  }

  Period? _periodFromSchedule(RoomSchedule schedule) {
    final beginMinutes =
        schedule.beginDatetime.hour * 60 + schedule.beginDatetime.minute;

    for (final period in Period.values) {
      final startMinutes = period.startTime.hour * 60 + period.startTime.minute;
      final endMinutes = period.endTime.hour * 60 + period.endTime.minute;
      if (beginMinutes >= startMinutes && beginMinutes <= endMinutes) {
        return period;
      }
    }
    return null;
  }
}
