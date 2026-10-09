import 'package:dotto/domain/entity/bus_schedule_stop.dart';
import 'package:dotto/presentation/bus/bus_stop_select_content.dart';
import 'package:flutter/widgets.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

const _stops = [
  BusScheduleStop(id: 1, name: '亀田支所前', routeList: ['55']),
  BusScheduleStop(id: 2, name: '五稜郭', routeList: ['55']),
  BusScheduleStop(
    id: 3,
    name: 'とても長い名前のバス停で表示が崩れないことを確認するためのダミー',
    routeList: ['55'],
  ),
];

@widgetbook.UseCase(name: '通常', type: BusStopSelectContent)
Widget busStopSelectContentDefault(BuildContext context) =>
    BusStopSelectContent(stops: _stops, onStopSelected: (_) {});

@widgetbook.UseCase(name: '空', type: BusStopSelectContent)
Widget busStopSelectContentEmpty(BuildContext context) =>
    BusStopSelectContent(stops: const [], onStopSelected: (_) {});
