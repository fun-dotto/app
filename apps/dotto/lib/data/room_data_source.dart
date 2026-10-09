import 'package:dotto/data/realtime_database_data_source.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'room_data_source.g.dart';

@riverpod
RoomDataSource roomDataSource(Ref ref) =>
    FirebaseRoomDataSource(ref.watch(realtimeDatabaseDataSourceProvider));

/// Firebase の部屋情報と利用予定の読み取り境界。
abstract interface class RoomDataSource {
  Future<Object?> fetchRooms();
  Future<Object?> fetchSchedules();
}

final class FirebaseRoomDataSource implements RoomDataSource {
  const new(this._database);
  final RealtimeDatabaseDataSource _database;

  @override
  Future<Object?> fetchRooms() async => (await _database.getData('map')).value;

  @override
  Future<Object?> fetchSchedules() async =>
      (await _database.getData('map_room_schedule')).value;
}
