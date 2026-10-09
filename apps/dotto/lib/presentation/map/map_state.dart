import 'package:dotto/application/fetch_rooms_use_case.dart';
import 'package:dotto/domain/entity/room.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'map_state.g.dart';

@riverpod
final class MapState extends _$MapState {
  @override
  Future<List<Room>> build() => ref.watch(fetchRoomsUseCaseProvider)();
}
