import 'package:dotto/data/app_api_mapper.dart';
import 'package:dotto/data/app_api_transport.dart';
import 'package:dotto/data/bus_data_source.dart';
import 'package:dotto/data/bus_schedule_repository_impl.dart';
import 'package:dotto/data/domain_error_mapper.dart';
import 'package:dotto/domain/entity/bus_schedule.dart';
import 'package:dotto/domain/entity/bus_schedule_stop.dart';
import 'package:dotto/domain/entity/bus_schedule_trip.dart';
import 'package:dotto/domain/entity/bus_schedule_trip_stop.dart';
import 'package:dotto/domain/entity/domain_error.dart';
import 'package:dotto/domain/repository/bus_schedule_repository.dart';
import 'package:dotto/helper/date_formatter.dart';
import 'package:dotto_app_api/app/v1/bus_timetable_stop.connect.client.dart';
import 'package:dotto_app_api/app/v1/bus_timetable_stop.pb.dart' as api;
import 'package:dotto_app_api/app/v1/bus_trip.connect.client.dart';
import 'package:dotto_app_api/app/v1/bus_trip.pb.dart' as api;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'bus_schedule_api_repository_impl.g.dart';

/// app-api からバスの時刻表を取得する [BusScheduleRepository]。
///
/// 時刻表以外 (選択バス停、初期方向、初期曜日) は従来の実装に委譲する。
@riverpod
BusScheduleRepository busScheduleApiRepository(Ref ref) =>
    BusScheduleApiRepositoryImpl(
      BusTripServiceClient(ref.watch(appApiTransportProvider)),
      BusTimetableStopServiceClient(ref.watch(appApiTransportProvider)),
      ref.watch(busDataSourceProvider),
      ref.watch(busScheduleRepositoryProvider),
    );

final class BusScheduleApiRepositoryImpl implements BusScheduleRepository {
  const new(
    this._tripClient,
    this._timetableStopClient,
    this._source,
    this._fallback,
  );

  final BusTripServiceClient _tripClient;
  final BusTimetableStopServiceClient _timetableStopClient;
  final BusDataSource _source;
  final BusScheduleRepository _fallback;

  static const _searchDays = 14;

  Future<T> _guard<T>(Future<T> Function() action) async {
    try {
      return await action();
    } on DomainError {
      rethrow;
    } on Exception catch (e, st) {
      throw mapDomainError(e: e, stackTrace: st);
    }
  }

  @override
  Future<BusSchedule> fetchSchedule() => _guard(() async {
    final today = _source.now();
    final base = DateTime(today.year, today.month, today.day);
    Set<String> holidays;
    try {
      holidays = await _source.fetchHolidayDates();
    } on DomainError {
      holidays = const {};
    }
    bool isWeekday(DateTime d) =>
        d.weekday <= DateTime.friday &&
        !holidays.contains(DateFormatter.date(d));
    DateTime nearest({required bool weekday}) {
      for (var i = 0; i < _searchDays; i++) {
        final d = base.add(Duration(days: i));
        if (isWeekday(d) == weekday) return d;
      }
      return base;
    }

    final stopsById = <int, BusScheduleStop>{};
    final routesByStop = <int, Set<String>>{};
    final trips = <String, Map<String, List<BusScheduleTrip>>>{
      'to_fun': {},
      'from_fun': {},
    };
    for (final (dayKey, date) in [
      ('weekday', nearest(weekday: true)),
      ('holiday', nearest(weekday: false)),
    ]) {
      final response = await _tripClient.listBusTrips(
        api.ListBusTripsRequest(date: toApiDate(date)),
      );
      final timetables = await Future.wait(
        response.busTrips.map(
          (trip) => _timetableStopClient.listBusTimetableStops(
            api.ListBusTimetableStopsRequest(tripId: trip.id),
          ),
        ),
      );
      for (final (index, trip) in response.busTrips.indexed) {
        final route = trip.route.name.isNotEmpty
            ? trip.route.name
            : trip.route.id;
        final rawStops = timetables[index].busTimetableStops.toList()
          ..sort(
            (a, b) => a.departureTime.toDateTime().compareTo(
              b.departureTime.toDateTime(),
            ),
          );
        if (rawStops.isEmpty) continue;
        final tripStops = <BusScheduleTripStop>[];
        for (final raw in rawStops) {
          final id = int.tryParse(raw.stop.id);
          if (id == null) {
            throw DomainError(
              type: DomainErrorType.invalidResponse,
              message: 'Invalid bus stop id: ${raw.stop.id}',
            );
          }
          final stop = BusScheduleStop(
            id: id,
            name: raw.stop.name,
            routeList: const [],
          );
          final time = raw.departureTime.toDateTime().toLocal();
          tripStops.add(
            BusScheduleTripStop(time: time.difference(date), stop: stop),
          );
        }
        final String direction;
        if (tripStops.last.stop.id == BusScheduleStop.universityId) {
          direction = 'to_fun';
        } else if (tripStops.first.stop.id == BusScheduleStop.universityId) {
          direction = 'from_fun';
        } else {
          continue;
        }
        // 時刻表に載る便のバス停・路線だけを登録する。
        for (final s in tripStops) {
          stopsById.putIfAbsent(s.stop.id, () => s.stop);
          (routesByStop[s.stop.id] ??= {}).add(route);
        }
        (trips[direction]![dayKey] ??= []).add(
          BusScheduleTrip(route: route, stops: tripStops),
        );
      }
    }

    final allStops = [
      for (final stop in stopsById.values)
        stop.copyWith(routeList: routesByStop[stop.id]!.toList()..sort()),
    ];
    final stopById = {for (final s in allStops) s.id: s};
    BusScheduleTrip withRoutes(BusScheduleTrip trip) => trip.copyWith(
      stops: [
        for (final s in trip.stops) s.copyWith(stop: stopById[s.stop.id]!),
      ],
    );
    return BusSchedule(
      trips: {
        for (final direction in trips.entries)
          direction.key: {
            for (final day in direction.value.entries)
              day.key: (day.value.map(withRoutes).toList()
                ..sort(
                  (a, b) => a.stops.first.time.compareTo(b.stops.first.time),
                )),
          },
      },
      allStops: allStops,
    );
  });

  @override
  Future<BusScheduleStop> fetchSelectedStop() => _guard(() async {
    final id = await _source.readSelectedStopId();
    final stops = (await fetchSchedule()).allStops;
    BusScheduleStop? find(int target) =>
        stops.where((s) => s.id == target).firstOrNull;
    return find(id ?? BusScheduleStop.defaultId) ??
        find(BusScheduleStop.defaultId) ??
        await _fallback.fetchSelectedStop();
  });

  @override
  Future<void> saveSelectedStop(BusScheduleStop stop) =>
      _fallback.saveSelectedStop(stop);

  @override
  Future<bool> fetchInitialDirection() => _fallback.fetchInitialDirection();

  @override
  Future<bool> fetchInitialWeekday() => _fallback.fetchInitialWeekday();
}
