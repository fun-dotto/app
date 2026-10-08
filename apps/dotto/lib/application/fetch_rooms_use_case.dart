import 'package:dotto/data/room_repository_impl.dart';
import 'package:dotto/domain/entity/room.dart';
import 'package:dotto/domain/repository/room_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'fetch_rooms_use_case.g.dart';

@riverpod
FetchRoomsUseCase fetchRoomsUseCase(Ref ref) =>
    FetchRoomsUseCase(ref.watch(roomRepositoryProvider));

final class FetchRoomsUseCase {
  const new(this._repository);
  final RoomRepository _repository;

  Future<List<Room>> call() => _repository.getRooms();
}
