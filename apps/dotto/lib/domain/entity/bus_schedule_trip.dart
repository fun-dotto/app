import 'package:dotto/domain/entity/bus_schedule_stop.dart';
import 'package:dotto/domain/entity/bus_schedule_trip_stop.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'bus_schedule_trip.freezed.dart';

@freezed
abstract class BusScheduleTrip with _$BusScheduleTrip {
  const factory({
    required String route,
    required List<BusScheduleTripStop> stops,
  }) = _BusScheduleTrip;
  const new _();

  /// 選択バス停を経由しない便は亀田支所前で乗降する。
  ({BusScheduleTripStop from, BusScheduleTripStop to, bool isFallback})? leg({
    required int selectedStopId,
    required bool isTo,
  }) {
    final university = stops
        .where((s) => s.stop.id == BusScheduleStop.universityId)
        .firstOrNull;
    final selected = stops
        .where((s) => s.stop.id == selectedStopId)
        .firstOrNull;
    final target =
        selected ??
        stops.where((s) => s.stop.id == BusScheduleStop.defaultId).firstOrNull;
    if (university == null || target == null) return null;
    return (
      from: isTo ? target : university,
      to: isTo ? university : target,
      isFallback: selected == null,
    );
  }
}
