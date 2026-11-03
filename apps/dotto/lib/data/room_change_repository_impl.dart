import 'package:connectrpc/connect.dart';
import 'package:dotto/data/api_client.dart';
import 'package:dotto/data/app_api_mapper.dart';
import 'package:dotto/data/course_notice_clock.dart';
import 'package:dotto/data/course_notice_mapper.dart';
import 'package:dotto/data/domain_error_mapper.dart';
import 'package:dotto/domain/entity/course_notice.dart';
import 'package:dotto/domain/entity/domain_error.dart';
import 'package:dotto/domain/repository/room_change_repository.dart';
import 'package:dotto_app_api/app/v1/room_change.connect.client.dart';
import 'package:dotto_app_api/app/v1/room_change.pb.dart' as api;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'room_change_repository_impl.g.dart';

@riverpod
RoomChangeRepository roomChangeRepository(Ref ref) => RoomChangeRepositoryImpl(
  ref.watch(apiClientProvider),
  ref.watch(courseNoticeClockProvider),
);

final class RoomChangeRepositoryImpl implements RoomChangeRepository {
  const new(this._transport, this._now);
  final Transport _transport;
  final DateTime Function() _now;
  @override
  Future<List<CourseNotice>> fetchAll({List<String>? subjectIds}) async {
    try {
      final response = await RoomChangeServiceClient(_transport)
          .listRoomChanges(
            api.ListRoomChangesRequest(
              fromDate: toApiDate(_now()),
              subjectIds: subjectIds,
            ),
          );
      return List.unmodifiable(
        response.roomChanges.map(
          (e) => CourseNotice.roomChange(
            id: e.id,
            subject: mapNoticeSubject(e.subject),
            date: fromApiDate(e.date),
            periodNumber: mapNoticePeriod(e.period),
            originalRoomName: e.originalRoom.name,
            newRoomName: e.newRoom.name,
          ),
        ),
      );
    } on DomainError {
      rethrow;
    } on Exception catch (e, stackTrace) {
      throw mapDomainError(e: e, stackTrace: stackTrace);
    }
  }
}
