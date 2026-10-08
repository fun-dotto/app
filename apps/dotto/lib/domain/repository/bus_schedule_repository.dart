import 'package:dotto/domain/entity/bus_schedule.dart';
import 'package:dotto/domain/entity/bus_schedule_stop.dart';

abstract interface class BusScheduleRepository {
  Future<BusSchedule> fetchSchedule();
  Future<BusScheduleStop> fetchSelectedStop();
  Future<void> saveSelectedStop(BusScheduleStop stop);
  Future<bool> fetchInitialDirection();
  Future<bool> fetchInitialWeekday();
}
