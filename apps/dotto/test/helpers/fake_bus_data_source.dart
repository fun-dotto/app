import 'package:dotto/data/bus_data_source.dart';

final class FakeBusDataSource implements BusDataSource {
  int? selectedStopId;
  bool isNear = false;
  Future<bool>? nearUniversityResult;
  Future<Set<String>>? holidayDatesResult;
  bool hasInvalidTrip = false;
  DateTime currentTime = DateTime(2026, 10, 8);
  Set<String> holidays = {};

  @override
  Future<Object?> fetch(String path) async => switch (path) {
    'bus/stops' => [
      {
        'id': 14013,
        'name': '亀田支所前',
        'route': ['55'],
      },
      {
        'id': 14023,
        'name': 'はこだて未来大学',
        'route': ['55'],
      },
      {
        'id': 1,
        'name': '選択バス停',
        'route': ['55'],
      },
    ],
    'bus/trips' => {
      'to_fun': {
        'weekday': [
          {
            'route': '55',
            'stops': [
              {'id': 14013, 'time': '08:00', 'terminal': 2},
              {'id': hasInvalidTrip ? 999 : 14023, 'time': '08:30'},
            ],
          },
        ],
        'holiday': <Object>[],
      },
      'from_fun': {'weekday': <Object>[], 'holiday': <Object>[]},
    },
    _ => null,
  };

  @override
  Future<int?> readSelectedStopId() async => selectedStopId;
  @override
  Future<void> saveSelectedStopId(int id) async => selectedStopId = id;
  @override
  Future<bool> isNearUniversity() =>
      nearUniversityResult ?? Future.value(isNear);
  @override
  Future<Set<String>> fetchHolidayDates() =>
      holidayDatesResult ?? Future.value(holidays);
  @override
  DateTime now() => currentTime;
}
