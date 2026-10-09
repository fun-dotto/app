import 'package:dotto/domain/entity/bus_schedule_stop.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'bus_schedule_trip_stop.freezed.dart';

@freezed
abstract class BusScheduleTripStop with _$BusScheduleTripStop {
  const factory({
    required Duration time,
    required BusScheduleStop stop,
    int? terminal,
  }) = _BusScheduleTripStop;
}
