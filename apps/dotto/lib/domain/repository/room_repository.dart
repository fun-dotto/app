import 'package:dotto/domain/entity/room.dart';
import 'package:dotto/domain/entity/room_assignment_index.dart';

abstract interface class RoomRepository {
  Future<List<Room>> getRooms();
  Future<RoomAssignmentIndex> getRoomAssignmentIndex();
}
