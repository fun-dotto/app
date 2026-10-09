import 'package:dotto/domain/entity/bus_schedule_stop.dart';
import 'package:dotto/domain/entity/bus_schedule_trip.dart';
import 'package:dotto/domain/entity/bus_schedule_trip_stop.dart';
import 'package:dotto/presentation/bus/bus_trip_content.dart';
import 'package:flutter/widgets.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

const _route = ['55'];

@widgetbook.UseCase(name: 'Default', type: BusTripContent)
Widget busTripContentDefault(BuildContext context) => const BusTripContent(
  busTrip: BusScheduleTrip(
    route: '55系統',
    stops: [
      BusScheduleTripStop(
        time: Duration(hours: 8, minutes: 30),
        stop: BusScheduleStop(id: 1, name: '函館駅前', routeList: _route),
        terminal: 4,
      ),
      BusScheduleTripStop(
        time: Duration(hours: 8, minutes: 50),
        stop: BusScheduleStop(id: 2, name: '五稜郭', routeList: _route),
      ),
      BusScheduleTripStop(
        time: Duration(hours: 9, minutes: 20),
        stop: BusScheduleStop(id: 3, name: '未来大学', routeList: _route),
      ),
    ],
  ),
);
