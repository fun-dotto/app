import 'package:dotto/data/room_data_source.dart';

final class FakeRoomDataSource implements RoomDataSource {
  const new({this.rooms = const {}, this.schedules = const {}, this.error});

  final Object? rooms;
  final Object? schedules;
  final Exception? error;

  @override
  Future<Object?> fetchRooms() async {
    if (error case final error?) throw error;
    return rooms;
  }

  @override
  Future<Object?> fetchSchedules() async => schedules;
}
