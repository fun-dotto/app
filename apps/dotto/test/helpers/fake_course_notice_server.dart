import 'package:connectrpc/connect.dart';
import 'package:dotto_app_api/app/v1/cancelled_class.connect.spec.dart';
import 'package:dotto_app_api/app/v1/cancelled_class.pb.dart';
import 'package:dotto_app_api/app/v1/common.pbenum.dart';
import 'package:dotto_app_api/app/v1/course_registration.connect.spec.dart';
import 'package:dotto_app_api/app/v1/course_registration.pb.dart';
import 'package:dotto_app_api/app/v1/makeup_class.connect.spec.dart';
import 'package:dotto_app_api/app/v1/makeup_class.pb.dart';
import 'package:dotto_app_api/app/v1/room.pb.dart';
import 'package:dotto_app_api/app/v1/room_change.connect.spec.dart';
import 'package:dotto_app_api/app/v1/room_change.pb.dart';
import 'package:dotto_app_api/app/v1/subject.pb.dart';

import 'app_api_fixtures.dart';
import 'fake_app_api.dart';

/// API 境界で科目と授業変更の応答を返す。
final class FakeCourseNoticeServer {
  new() {
    apiClient
      ..on(
        CourseRegistrationService.listCourseRegistrations,
        (_) => ListCourseRegistrationsResponse(
          courseRegistrations: [
            for (final id in registeredSubjectIds)
              CourseRegistration(id: 'registration-$id', subject: subject(id)),
          ],
        ),
      )
      ..on(CancelledClassService.listCancelledClasses, (request) {
        _throwIfNeeded();
        return ListCancelledClassesResponse(
          cancelledClasses: _filter(
            cancellations,
            request.subjectIds,
            (e) => e.subject,
          ),
        );
      })
      ..on(MakeupClassService.listMakeupClasses, (request) {
        _throwIfNeeded();
        return ListMakeupClassesResponse(
          makeupClasses: _filter(makeups, request.subjectIds, (e) => e.subject),
        );
      })
      ..on(RoomChangeService.listRoomChanges, (request) {
        _throwIfNeeded();
        return ListRoomChangesResponse(
          roomChanges: _filter(
            roomChanges,
            request.subjectIds,
            (e) => e.subject,
          ),
        );
      });
  }

  final apiClient = FakeAppApi();
  List<String> registeredSubjectIds = ['s1'];
  bool shouldFail = false;
  List<CancelledClass> cancellations = [
    cancellation('cancel-1', 's1'),
    cancellation('cancel-2', 's2'),
  ];
  List<MakeupClass> makeups = [makeup('makeup-1', 's1')];
  List<RoomChange> roomChanges = [roomChange('change-1', 's1')];

  void _throwIfNeeded() {
    if (shouldFail) throw ConnectException(Code.internal, 'fake error');
  }

  static List<T> _filter<T>(
    List<T> items,
    List<String> subjectIds,
    Subject Function(T) subjectOf,
  ) => [
    for (final item in items)
      if (subjectIds.isEmpty || subjectIds.contains(subjectOf(item).id)) item,
  ];

  static Subject subject(String id) =>
      subjectSummaryFixture(id, name: id == 's1' ? '数学' : '英語');

  static CancelledClass cancellation(String id, String subjectId) =>
      CancelledClass(
        id: id,
        subject: subject(subjectId),
        date: dateFixture(2026, 4, 1),
        period: Period.PERIOD_1,
        comment: '  休講連絡  ',
      );

  static MakeupClass makeup(String id, String subjectId) => MakeupClass(
    id: id,
    subject: subject(subjectId),
    date: dateFixture(2026, 4, 2),
    period: Period.PERIOD_2,
    comment: '補講連絡',
  );

  static RoomChange roomChange(String id, String subjectId) => RoomChange(
    id: id,
    subject: subject(subjectId),
    date: dateFixture(2026, 4, 3),
    period: Period.PERIOD_3,
    originalRoom: Room(id: 'r1', name: 'R101', floor: RoomFloor.ROOM_FLOOR_1),
    newRoom: Room(id: 'r2', name: 'R202', floor: RoomFloor.ROOM_FLOOR_2),
  );
}
