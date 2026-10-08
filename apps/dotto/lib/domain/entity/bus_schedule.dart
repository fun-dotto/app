import 'package:dotto/domain/entity/bus_schedule_stop.dart';
import 'package:dotto/domain/entity/bus_schedule_trip.dart';
import 'package:dotto/domain/entity/bus_trip_id.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'bus_schedule.freezed.dart';

@freezed
abstract class BusSchedule with _$BusSchedule {
  const factory({
    required Map<String, Map<String, List<BusScheduleTrip>>> trips,
    required List<BusScheduleStop> allStops,
  }) = _BusSchedule;
  const new _();
  List<BusScheduleTrip> tripsOf({
    required bool isTo,
    required bool isWeekday,
  }) =>
      trips[isTo ? 'to_fun' : 'from_fun']?[isWeekday ? 'weekday' : 'holiday'] ??
      const [];
  BusScheduleTrip? tripOf(BusTripId id) {
    final selected = tripsOf(isTo: id.isTo, isWeekday: id.isWeekday);
    return id.index < selected.length ? selected[id.index] : null;
  }
}
