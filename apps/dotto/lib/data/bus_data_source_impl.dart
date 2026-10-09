import 'package:dotto/data/bus_data_source.dart';
import 'package:dotto/data/holiday_data_source.dart';
import 'package:dotto/data/location_data_source.dart';
import 'package:dotto/data/preference_data_source.dart';
import 'package:dotto/data/realtime_database_data_source.dart';
import 'package:dotto/domain/entity/domain_error.dart';
import 'package:dotto/domain/entity/user_preference_keys.dart';
import 'package:dotto/foundation/log/logger.dart';

final class BusDataSourceImpl implements BusDataSource {
  const new(
    this._logger,
    this._database,
    this._preferences,
    this._location,
    this._holidays,
  );
  final RealtimeDatabaseDataSource _database;
  final PreferenceDataSource _preferences;
  final LocationDataSource _location;
  final HolidayDataSource _holidays;
  final Logger _logger;
  @override
  Future<Object?> fetch(String path) async =>
      (await _database.getData(path)).value;
  @override
  Future<int?> readSelectedStopId() =>
      _preferences.getInt(UserPreferenceKeys.myBusStop);
  @override
  Future<void> saveSelectedStopId(int id) =>
      _preferences.setInt(UserPreferenceKeys.myBusStop, id);
  @override
  Future<bool> isNearUniversity() => _location.isNearUniversity();
  @override
  Future<Set<String>> fetchHolidayDates() async {
    try {
      return await _holidays.getHolidayDates();
    } on DomainError catch (error, stackTrace) {
      await _logger.logError(error, stackTrace);
      rethrow;
    }
  }

  @override
  DateTime now() => DateTime.now();
}
