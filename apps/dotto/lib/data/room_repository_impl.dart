import 'package:dotto/data/room_data_source.dart';
import 'package:dotto/domain/entity/domain_error.dart';
import 'package:dotto/domain/entity/floor.dart';
import 'package:dotto/domain/entity/room.dart';
import 'package:dotto/domain/entity/room_assignment_index.dart';
import 'package:dotto/domain/entity/room_schedule.dart';
import 'package:dotto/domain/repository/room_repository.dart';
import 'package:dotto/domain/service/room_assignment_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'room_repository_impl.g.dart';

@riverpod
RoomRepository roomRepository(Ref ref) =>
    RoomRepositoryImpl(ref.watch(roomDataSourceProvider));

final class RoomRepositoryImpl implements RoomRepository {
  const new(this._dataSource);
  final RoomDataSource _dataSource;

  @override
  Future<List<Room>> getRooms() async {
    try {
      final [roomData, scheduleData] = await Future.wait([
        _dataSource.fetchRooms(),
        _dataSource.fetchSchedules(),
      ]);
      final floors = _map(roomData);
      final schedules = _map(scheduleData);
      return List.unmodifiable(
        floors.entries.expand((floorEntry) {
          final floor = Floor.fromLabel(floorEntry.key.toString());
          return _map(floorEntry.value).entries.map((roomEntry) {
            final response = _json(roomEntry.value);
            final roomId = roomEntry.key.toString();
            final roomSchedules = switch (schedules[roomId]) {
              final List<Object?> values => values.map((value) {
                final schedule = _json(value);
                return RoomSchedule(
                  beginDatetime: DateTime.parse(
                    _string(schedule, 'begin_datetime'),
                  ),
                  endDatetime: DateTime.parse(
                    _string(schedule, 'end_datetime'),
                  ),
                  title: _string(schedule, 'title'),
                );
              }).toList(),
              null => <RoomSchedule>[],
              _ => throw _invalidResponse(),
            };
            return Room(
              id: _optionalString(response, 'classroom_no') ?? roomId,
              name: _string(response, 'header'),
              shortName: roomId,
              description: _optionalString(response, 'detail') ?? '',
              floor: floor,
              email: _optionalString(response, 'mail') ?? '',
              keywords: _keywords(response['search_word_list']),
              schedules: roomSchedules,
            );
          });
        }),
      );
    } on DomainError {
      rethrow;
    } on Exception catch (error, stackTrace) {
      throw DomainError.fromException(e: error, stackTrace: stackTrace);
    }
  }

  @override
  Future<RoomAssignmentIndex> getRoomAssignmentIndex() async =>
      const RoomAssignmentService().build(await getRooms());

  Map<Object?, Object?> _map(Object? value) => switch (value) {
    final Map<Object?, Object?> map => map,
    _ => throw _invalidResponse(),
  };

  Map<String, Object?> _json(Object? value) =>
      _map(value).map((key, value) => MapEntry(key.toString(), value));

  String _string(Map<String, Object?> json, String key) => switch (json[key]) {
    final String value => value,
    _ => throw _invalidResponse(),
  };

  String? _optionalString(Map<String, Object?> json, String key) =>
      switch (json[key]) {
        final String value => value,
        null => null,
        _ => throw _invalidResponse(),
      };

  List<String> _keywords(Object? value) => switch (value) {
    null => const [],
    final List<Object?> values =>
      values
          .map(
            (value) => switch (value) {
              final String keyword => keyword,
              _ => throw _invalidResponse(),
            },
          )
          .toList(),
    _ => throw _invalidResponse(),
  };

  DomainError _invalidResponse() => const DomainError(
    type: DomainErrorType.invalidResponse,
    message: 'Invalid room response',
  );
}
