import 'package:dotto/data/bus_data_source.dart';
import 'package:dotto/data/domain_error_mapper.dart';
import 'package:dotto/domain/entity/bus_schedule.dart';
import 'package:dotto/domain/entity/bus_schedule_stop.dart';
import 'package:dotto/domain/entity/bus_schedule_trip.dart';
import 'package:dotto/domain/entity/bus_schedule_trip_stop.dart';
import 'package:dotto/domain/entity/domain_error.dart';
import 'package:dotto/domain/repository/bus_schedule_repository.dart';
import 'package:dotto/helper/date_formatter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'bus_schedule_repository_impl.g.dart';

@riverpod
BusScheduleRepository busScheduleRepository(Ref ref) =>
    BusScheduleRepositoryImpl(ref.watch(busDataSourceProvider));

final class BusScheduleRepositoryImpl implements BusScheduleRepository {
  const new(this._source);
  final BusDataSource _source;
  static const _defaultStop = BusScheduleStop(
    id: 14013,
    name: '亀田支所前',
    routeList: ['50', '55', '55A', '55B', '55C', '55E', '55F', '55G', '55H'],
  );
  Future<T> _guard<T>(Future<T> Function() action) async {
    try {
      return await action();
    } on DomainError {
      rethrow;
    } on Exception catch (e, st) {
      throw mapDomainError(e: e, stackTrace: st);
    }
    // Firebase の動的データに起因する型不一致を境界で変換する。
    // ignore: avoid_catching_errors
    on TypeError catch (e, st) {
      throw DomainError(
        type: DomainErrorType.invalidResponse,
        message: e.toString(),
        stackTrace: st,
      );
    }
  }

  @override
  Future<BusSchedule> fetchSchedule() => _guard(() async {
    final rawStops = await _source.fetch('bus/stops');
    final rawTrips = await _source.fetch('bus/trips');
    if (rawStops is! List || rawTrips is! Map) {
      throw const DomainError(
        type: DomainErrorType.invalidResponse,
        message: 'Invalid bus schedule',
      );
    }
    final stops = rawStops
        .map((e) => parseStop(Map<String, dynamic>.from(e as Map)))
        .toList();
    final trips = <String, Map<String, List<BusScheduleTrip>>>{};
    for (final entry in rawTrips.entries) {
      trips[entry.key as String] = {
        for (final day in (entry.value as Map).entries)
          day.key as String: (day.value as List)
              .map((e) => parseTrip(Map<String, dynamic>.from(e as Map), stops))
              .toList(),
      };
    }
    return BusSchedule(trips: trips, allStops: stops);
  });
  @override
  Future<BusScheduleStop> fetchSelectedStop() => _guard(() async {
    final id = await _source.readSelectedStopId();
    if (id == null) return _defaultStop;
    final schedule = await fetchSchedule();
    return schedule.allStops.where((s) => s.id == id).firstOrNull ??
        _defaultStop;
  });
  @override
  Future<void> saveSelectedStop(BusScheduleStop stop) =>
      _guard(() => _source.saveSelectedStopId(stop.id));
  @override
  Future<bool> fetchInitialDirection() =>
      _guard(() async => !await _source.isNearUniversity());
  @override
  Future<bool> fetchInitialWeekday() => _guard(() async {
    final now = _source.now();
    try {
      final holidays = await _source.fetchHolidayDates();
      return now.weekday <= DateTime.friday &&
          !holidays.contains(DateFormatter.date(now));
    } on DomainError {
      return now.weekday <= DateTime.friday;
    }
  });
  static BusScheduleStop parseStop(Map<String, dynamic> map) {
    final rawId = map['id'];
    final id = switch (rawId) {
      final int v => v,
      final num v => v.toInt(),
      final String v =>
        int.tryParse(v) ??
            (throw FormatException('Invalid BusScheduleStop id', v)),
      _ => throw FormatException('Invalid BusScheduleStop id', rawId),
    };
    final rawRoute = map['route'];
    if (rawRoute is! List) {
      throw FormatException('BusScheduleStop route must be a list', rawRoute);
    }
    final routeList = rawRoute.map((e) => e.toString()).toList();
    return BusScheduleStop(
      id: id,
      name: map['name'] as String,
      routeList: routeList,
      reverse: map['reverse'] as bool?,
      selectable: map['selectable'] as bool?,
    );
  }

  static BusScheduleTrip parseTrip(
    Map<String, dynamic> map,
    List<BusScheduleStop> allStops,
  ) {
    final stopsList = map['stops'] as List;
    final busStopById = {for (final stop in allStops) stop.id: stop};
    return BusScheduleTrip(
      route: map['route'] as String,
      stops: stopsList.map((e) {
        final stopMap = Map<String, dynamic>.from(e as Map);
        final id = stopMap['id'] as int;
        final targetBusScheduleStop = busStopById[id];
        if (targetBusScheduleStop == null) {
          throw FormatException('Unknown bus stop id: $id');
        }
        return parseTripStop(targetBusScheduleStop, stopMap);
      }).toList(),
    );
  }

  static BusScheduleTripStop parseTripStop(
    BusScheduleStop stop,
    Map<String, dynamic> map,
  ) {
    final timeStr = map['time'] as String;
    final timeStrList = timeStr.split(':');
    if (timeStrList.length != 2) {
      throw FormatException('Invalid time format (expected HH:mm)', timeStr);
    }
    final hour = int.tryParse(timeStrList[0]);
    final minute = int.tryParse(timeStrList[1]);
    if (hour == null || minute == null) {
      throw FormatException('Invalid time format (expected HH:mm)', timeStr);
    }
    return BusScheduleTripStop(
      time: Duration(hours: hour, minutes: minute),
      stop: stop,
      terminal: map['terminal'] as int?,
    );
  }
}
