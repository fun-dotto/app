import 'package:dotto/data/bus_data_source_impl.dart';
import 'package:dotto/data/holiday_data_source.dart';
import 'package:dotto/data/location_data_source.dart';
import 'package:dotto/data/preference_data_source.dart';
import 'package:dotto/data/realtime_database_data_source.dart';
import 'package:dotto/foundation/log/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'bus_data_source.g.dart';

abstract interface class BusDataSource {
  Future<Object?> fetch(String path);
  Future<int?> readSelectedStopId();
  Future<void> saveSelectedStopId(int id);
  Future<bool> isNearUniversity();
  Future<Set<String>> fetchHolidayDates();
  DateTime now();
}

@riverpod
BusDataSource busDataSource(Ref ref) => BusDataSourceImpl(
  ref.watch(loggerProvider),
  ref.watch(realtimeDatabaseDataSourceProvider),
  ref.watch(preferenceDataSourceProvider),
  ref.watch(locationDataSourceProvider),
  ref.watch(holidayDataSourceProvider),
);
