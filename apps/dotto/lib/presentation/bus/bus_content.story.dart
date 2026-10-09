import 'package:dotto/domain/entity/bus_schedule.dart';
import 'package:dotto/domain/entity/bus_schedule_stop.dart';
import 'package:dotto/domain/entity/bus_schedule_trip.dart';
import 'package:dotto/domain/entity/bus_schedule_trip_stop.dart';
import 'package:dotto/presentation/bus/bus_content.dart';
import 'package:dotto/presentation/common/use_tab_controller.dart';
import 'package:flutter_hooks/flutter_hooks.dart' hide useTabController;
import 'package:material_ui/material_ui.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

const _route = ['55'];
const _university = BusScheduleStop(
  id: BusScheduleStop.universityId,
  name: '未来大学',
  routeList: _route,
);
const _myStop = BusScheduleStop(
  id: BusScheduleStop.defaultId,
  name: '亀田支所前',
  routeList: _route,
);

BusScheduleTrip _trip(String route, Duration from, Duration to) =>
    BusScheduleTrip(
      route: route,
      stops: [
        BusScheduleTripStop(time: from, stop: _myStop),
        BusScheduleTripStop(time: to, stop: _university),
      ],
    );

final _schedule = BusSchedule(
  trips: {
    'to_fun': {
      'weekday': [
        _trip(
          '55',
          const Duration(hours: 8),
          const Duration(hours: 8, minutes: 30),
        ),
        _trip(
          '55G',
          const Duration(hours: 9),
          const Duration(hours: 9, minutes: 30),
        ),
        _trip(
          '55H',
          const Duration(hours: 10),
          const Duration(hours: 10, minutes: 30),
        ),
      ],
    },
  },
  allStops: const [_university, _myStop],
);

/// タブのコントローラは Screen で Hooks によって作るため、Story でも同様に用意する。
final class _BusStory extends HookWidget {
  const new();

  @override
  Widget build(BuildContext context) {
    final tabController = useTabController(initialLength: 2);
    return BusContent(
      isTo: true,
      myBusStopName: _myStop.name,
      tabController: tabController,
      onDirectionSwapped: () {},
      onBusStopTap: () {},
      onWeekdayTabTap: () {},
      body: BusTripTabView(
        schedule: _schedule,
        stop: _myStop,
        isTo: true,
        currentTime: DateTime(2026, 4, 13, 8, 30),
        tabController: tabController,
        onTripTap: (_) {},
      ),
    );
  }
}

@widgetbook.UseCase(name: 'Default', type: BusContent)
Widget busContentDefault(BuildContext context) => const _BusStory();
