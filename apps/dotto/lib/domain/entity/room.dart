import 'package:dotto/domain/entity/floor.dart';
import 'package:dotto/domain/entity/room_schedule.dart';
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

  /// 部屋名・教員名・メールアドレス・検索キーワードで一致を判定する。
  bool matchesQuery(String query) {
    final normalized = query.trim().toLowerCase();
    return normalized.isNotEmpty &&
        [
          id,
          name,
          description,
          email,
          ...keywords,
        ].any((value) => value.toLowerCase().contains(normalized));
  }

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
