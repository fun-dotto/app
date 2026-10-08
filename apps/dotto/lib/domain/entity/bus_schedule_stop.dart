import 'package:freezed_annotation/freezed_annotation.dart';

part 'bus_schedule_stop.freezed.dart';

@freezed
abstract class BusScheduleStop with _$BusScheduleStop {
  const factory({
    required int id,
    required String name,
    required List<String> routeList,
    bool? reverse,
    bool? selectable,
  }) = _BusScheduleStop;
  static const universityId = 14023;
  static const defaultId = 14013;
}
