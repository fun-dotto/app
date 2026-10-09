import 'package:dotto/helper/firebase_realtime_database_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'room_data_source.g.dart';

@riverpod
RoomDataSource roomDataSource(Ref ref) => const FirebaseRoomDataSource();

/// Firebase の部屋情報と利用予定の読み取り境界。
abstract interface class RoomDataSource {
  Future<Object?> fetchRooms();
  Future<Object?> fetchSchedules();
}

final class FirebaseRoomDataSource implements RoomDataSource {
  const new();

  @override
  Future<Object?> fetchRooms() async =>
      (await FirebaseRealtimeDatabaseRepository().getData('map')).value;

  @override
  Future<Object?> fetchSchedules() async =>
      (await FirebaseRealtimeDatabaseRepository().getData('map_room_schedule'))
          .value;
}
