import 'package:dotto/data/bus_schedule_api_repository_impl.dart';
import 'package:dotto/data/bus_schedule_repository_impl.dart';
import 'package:dotto_app_api/app/v1/bus_route.pb.dart' as api;
import 'package:dotto_app_api/app/v1/bus_stop.pb.dart' as api;
import 'package:dotto_app_api/app/v1/bus_timetable_stop.connect.client.dart';
import 'package:dotto_app_api/app/v1/bus_timetable_stop.connect.spec.dart';
import 'package:dotto_app_api/app/v1/bus_timetable_stop.pb.dart' as api;
import 'package:dotto_app_api/app/v1/bus_trip.connect.client.dart';
import 'package:dotto_app_api/app/v1/bus_trip.connect.spec.dart';
import 'package:dotto_app_api/app/v1/bus_trip.pb.dart' as api;
import 'package:flutter_test/flutter_test.dart';
import 'package:protobuf/well_known_types/google/protobuf/timestamp.pb.dart';

import '../helpers/fake_app_api_transport.dart';
import '../helpers/fake_bus_data_source.dart';

void main() {
  // 2026-10-08 (木) を基準日とする。
  final weekday = DateTime(2026, 10, 8);
  final holiday = DateTime(2026, 10, 10);

  api.BusStop stop(int id, String name) => api.BusStop(id: '$id', name: name);
  Timestamp at(DateTime date, int h, int m) =>
      Timestamp.fromDateTime(date.add(Duration(hours: h, minutes: m)));

  FakeAppApiTransport transport() => FakeAppApiTransport()
    ..on(BusTripService.listBusTrips, (req) {
      final date = DateTime(req.date.year, req.date.month, req.date.day);
      final prefix = date == weekday ? 'w' : 'h';
      return api.ListBusTripsResponse(
        busTrips: [
          api.BusTrip(
            id: '$prefix-from',
            route: api.BusRoute(name: '55'),
          ),
          api.BusTrip(
            id: '$prefix-to',
            route: api.BusRoute(name: '55'),
          ),
          api.BusTrip(
            id: '$prefix-other',
            route: api.BusRoute(name: '99'),
          ),
        ],
      );
    })
    ..on(BusTimetableStopService.listBusTimetableStops, (req) {
      final date = req.tripId.startsWith('w') ? weekday : holiday;
      final kameda = stop(14013, '亀田支所前');
      final fun = stop(14023, 'はこだて未来大学');
      final isTo = req.tripId.endsWith('to');
      if (req.tripId.endsWith('other')) {
        // 未来大を経由しない便。
        return api.ListBusTimetableStopsResponse(
          busTimetableStops: [
            api.BusTimetableStop(
              tripId: req.tripId,
              stop: stop(1, '経由しないバス停'),
              departureTime: at(date, 12, 0),
            ),
            api.BusTimetableStop(
              tripId: req.tripId,
              stop: kameda,
              departureTime: at(date, 12, 10),
            ),
          ],
        );
      }
      return api.ListBusTimetableStopsResponse(
        busTimetableStops: [
          api.BusTimetableStop(
            tripId: req.tripId,
            stop: isTo ? fun : kameda,
            departureTime: at(date, isTo ? 8 : 18, 30),
          ),
          api.BusTimetableStop(
            tripId: req.tripId,
            stop: isTo ? kameda : fun,
            departureTime: at(date, isTo ? 8 : 18, 0),
          ),
        ],
      );
    });

  BusScheduleApiRepositoryImpl repository(FakeAppApiTransport t) {
    final source = FakeBusDataSource()..currentTime = weekday;
    return BusScheduleApiRepositoryImpl(
      BusTripServiceClient(t),
      BusTimetableStopServiceClient(t),
      source,
      BusScheduleRepositoryImpl(source),
    );
  }

  test('APIの運行情報から方向・曜日別の時刻表を組み立てる', () async {
    final schedule = await repository(transport()).fetchSchedule();

    final toWeekday = schedule.tripsOf(isTo: true, isWeekday: true);
    expect(toWeekday, hasLength(1));
    expect(toWeekday.single.route, '55');
    expect(toWeekday.single.stops.map((s) => s.stop.id), [14013, 14023]);
    expect(toWeekday.single.stops.first.time, const Duration(hours: 8));

    final fromHoliday = schedule.tripsOf(isTo: false, isWeekday: false);
    expect(fromHoliday.single.stops.map((s) => s.stop.id), [14023, 14013]);
    expect(fromHoliday.single.stops.first.time, const Duration(hours: 18));

    expect(schedule.allStops.map((s) => s.id), containsAll([14013, 14023]));
    expect(schedule.allStops.first.routeList, ['55']);
  });

  test('未来大を経由しない便のバス停・路線は登録しない', () async {
    final schedule = await repository(transport()).fetchSchedule();

    expect(schedule.allStops.map((s) => s.id), isNot(contains(1)));
    final kameda = schedule.allStops.singleWhere((s) => s.id == 14013);
    expect(kameda.routeList, ['55']);
  });

  test('平日と休日の日付でそれぞれ運行情報を取得する', () async {
    final t = transport();
    await repository(t).fetchSchedule();
    final dates = t.requests[BusTripService.listBusTrips.procedure]!
        .cast<api.ListBusTripsRequest>()
        .map((r) => DateTime(r.date.year, r.date.month, r.date.day));
    expect(dates, [weekday, holiday]);
  });

  test('未選択の場合は亀田支所前を返す', () async {
    final selected = await repository(transport()).fetchSelectedStop();
    expect(selected.id, 14013);
  });
}
