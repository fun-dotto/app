import 'package:built_collection/built_collection.dart';
import 'package:dotto/api/api_client.dart';
import 'package:dotto/data/course_notice_clock.dart';
import 'package:dotto/data/course_notice_mapper.dart';
import 'package:dotto/domain/entity/course_notice.dart';
import 'package:dotto/domain/entity/domain_error.dart';
import 'package:dotto/domain/repository/room_change_repository.dart';
import 'package:openapi/openapi.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'room_change_repository_impl.g.dart';

@riverpod
RoomChangeRepository roomChangeRepository(Ref ref) => RoomChangeRepositoryImpl(
  ref.watch(apiClientProvider),
  ref.watch(courseNoticeClockProvider),
);

final class RoomChangeRepositoryImpl implements RoomChangeRepository {
  const new(this._apiClient, this._now);
  final Openapi _apiClient;
  final DateTime Function() _now;
  @override
  Future<List<CourseNotice>> fetchAll({List<String>? subjectIds}) async {
    try {
      final now = _now();
      final response = await _apiClient.getRoomChangesApi().roomChangesV1List(
        from: Date(now.year, now.month, now.day),
        subjectIds: subjectIds == null ? null : BuiltList<String>(subjectIds),
      );
      final data = response.data;
      if (response.statusCode != 200 || data == null) {
        throw const DomainError(
          type: DomainErrorType.invalidResponse,
          message: 'Failed to fetch course notices',
        );
      }
      return List.unmodifiable(
        data.roomChanges.map(
          (e) => CourseNotice.roomChange(
            id: e.id,
            subject: mapNoticeSubject(e.subject),
            date: e.date.toDateTime(),
            periodNumber: mapNoticePeriod(e.period),
            originalRoomName: e.originalRoom.name,
            newRoomName: e.newRoom.name,
          ),
        ),
      );
    } on DomainError {
      rethrow;
    } on Exception catch (e, stackTrace) {
      throw DomainError.fromException(e: e, stackTrace: stackTrace);
    }
  }
}
