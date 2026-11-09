import 'package:connectrpc/connect.dart' as connect;
import 'package:dotto_app_api/app/v1/cancelled_class.connect.spec.dart';
import 'package:dotto_app_api/app/v1/cancelled_class.pb.dart' as api;
import 'package:dotto_app_api/app/v1/common.pbenum.dart' as api;
import 'package:dotto_app_api/app/v1/course_registration.connect.spec.dart';
import 'package:dotto_app_api/app/v1/course_registration.pb.dart' as api;
import 'package:dotto_app_api/app/v1/makeup_class.connect.spec.dart';
import 'package:dotto_app_api/app/v1/makeup_class.pb.dart' as api;
import 'package:dotto_app_api/app/v1/room.pb.dart' as api;
import 'package:dotto_app_api/app/v1/room_change.connect.spec.dart';
import 'package:dotto_app_api/app/v1/room_change.pb.dart' as api;
import 'package:dotto_app_api/app/v1/subject.pb.dart' as api;
import 'package:dotto_app_api/google/type/date.pb.dart' as api;

import 'api_subject.dart';
import 'fake_app_api_transport.dart';

/// RPC 境界で科目と授業変更の応答を返す。
final class FakeCourseNoticeServer {
  new() {
    _transport
      ..on(
        CourseRegistrationService.listCourseRegistrations,
        (_) => api.ListCourseRegistrationsResponse(
          courseRegistrations: [
            for (final id in registeredSubjectIds)
              api.CourseRegistration(
                id: 'registration-$id',
                subject: subject(id),
              ),
          ],
        ),
      )
      ..on(CancelledClassService.listCancelledClasses, (request) {
        _throwIfFailing();
        return api.ListCancelledClassesResponse(
          cancelledClasses: _filter(
            cancellations,
            request.subjectIds,
            (e) => e.subject.id,
          ),
        );
      })
      ..on(MakeupClassService.listMakeupClasses, (request) {
        _throwIfFailing();
        return api.ListMakeupClassesResponse(
          makeupClasses: _filter(
            makeups,
            request.subjectIds,
            (e) => e.subject.id,
          ),
        );
      })
      ..on(RoomChangeService.listRoomChanges, (request) {
        _throwIfFailing();
        return api.ListRoomChangesResponse(
          roomChanges: _filter(
            roomChanges,
            request.subjectIds,
            (e) => e.subject.id,
          ),
        );
      });
  }

  final _transport = FakeAppApiTransport();
  List<String> registeredSubjectIds = ['s1'];
  bool shouldFail = false;
  List<api.CancelledClass> cancellations = [
    cancellation('cancel-1', 's1'),
    cancellation('cancel-2', 's2'),
  ];
  List<api.MakeupClass> makeups = [makeup('makeup-1', 's1')];
  List<api.RoomChange> roomChanges = [roomChange('change-1', 's1')];

  FakeAppApiTransport get transport => _transport;

  void _throwIfFailing() {
    if (shouldFail) {
      throw connect.ConnectException(connect.Code.internal, 'server error');
    }
  }

  static List<T> _filter<T>(
    List<T> items,
    List<String> subjectIds,
    String Function(T) subjectIdOf,
  ) => [
    for (final item in items)
      if (subjectIds.isEmpty || subjectIds.contains(subjectIdOf(item))) item,
  ];

  static api.Subject subject(String id) =>
      apiSubjectSummary(id, name: id == 's1' ? '数学' : '英語');

  static api.CancelledClass cancellation(String id, String subjectId) =>
      api.CancelledClass(
        id: id,
        subject: subject(subjectId),
        date: api.Date(year: 2026, month: 4, day: 1),
        period: api.Period.PERIOD_1,
        comment: '  休講連絡  ',
      );

  static api.MakeupClass makeup(String id, String subjectId) => api.MakeupClass(
    id: id,
    subject: subject(subjectId),
    date: api.Date(year: 2026, month: 4, day: 2),
    period: api.Period.PERIOD_2,
    comment: '補講連絡',
  );

  static api.RoomChange roomChange(String id, String subjectId) =>
      api.RoomChange(
        id: id,
        subject: subject(subjectId),
        date: api.Date(year: 2026, month: 4, day: 3),
        period: api.Period.PERIOD_3,
        originalRoom: api.Room(
          id: 'r1',
          name: 'R101',
          floor: api.RoomFloor.ROOM_FLOOR_1,
        ),
        newRoom: api.Room(
          id: 'r2',
          name: 'R202',
          floor: api.RoomFloor.ROOM_FLOOR_2,
        ),
      );
}
