import 'package:dotto/domain/entity/day_of_week.dart';
import 'package:dotto/domain/entity/period.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'timetable_slot.freezed.dart';

@freezed
abstract class TimetableSlot with _$TimetableSlot {
  const factory({required DayOfWeek dayOfWeek, required Period period}) =
      _TimetableSlot;
}
