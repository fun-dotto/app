import 'package:dotto/data/bus_data_source.dart';
import 'package:dotto/domain/entity/domain_error.dart';
import 'package:dotto/domain/entity/user_preference_keys.dart';
import 'package:dotto/foundation/log/logger.dart';
import 'package:dotto/helper/firebase_realtime_database_repository.dart';
import 'package:dotto/helper/location_helper.dart';
import 'package:dotto/helper/user_preference_repository.dart';
import 'package:dotto/repository/holiday_repository.dart';

final class BusDataSourceImpl implements BusDataSource {
  const new(this._logger);
  final Logger _logger;
  @override
  Future<Object?> fetch(String path) async =>
      (await FirebaseRealtimeDatabaseRepository().getData(path)).value;
  @override
  Future<int?> readSelectedStopId() =>
      UserPreferenceRepository.getInt(UserPreferenceKeys.myBusStop);
  @override
  Future<void> saveSelectedStopId(int id) =>
      UserPreferenceRepository.setInt(UserPreferenceKeys.myBusStop, id);
  @override
  Future<bool> isNearUniversity() => LocationHelper.isNearUniversity();
  @override
  Future<Set<String>> fetchHolidayDates() async {
    try {
      return await HolidayRepositoryImpl().getHolidayDates();
    } on DomainError catch (error, stackTrace) {
      await _logger.logError(error, stackTrace);
      rethrow;
    }
  }

  @override
  DateTime now() => DateTime.now();
}
