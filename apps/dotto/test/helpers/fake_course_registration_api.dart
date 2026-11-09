import 'package:dotto_app_api/app/v1/common.pbenum.dart' as api;
import 'package:dotto_app_api/app/v1/course_registration.connect.spec.dart';
import 'package:dotto_app_api/app/v1/course_registration.pb.dart' as api;
import 'package:dotto_app_api/app/v1/timetable_item.connect.spec.dart';
import 'package:dotto_app_api/app/v1/timetable_item.pb.dart' as api;
import 'package:dotto_app_api/google/type/dayofweek.pbenum.dart' as api;

import 'api_subject.dart';
import 'fake_app_api_transport.dart';

/// 履修登録APIの登録結果をメモリ内に保存する。
final class FakeCourseRegistrationApi {
  new({this.initialRegisteredIds = const []}) {
    for (final id in initialRegisteredIds) {
      registrations[id] = _registration(id);
    }
    transport
      ..on(
        CourseRegistrationService.listCourseRegistrations,
        (_) => api.ListCourseRegistrationsResponse(
          courseRegistrations: registrations.values,
        ),
      )
      ..on(
        TimetableItemService.listTimetableItems,
        (_) => api.ListTimetableItemsResponse(
          timetableItems: [
            for (final id in ['first', 'second', 'target'])
              api.TimetableItem(
                id: id,
                subject: apiSubjectSummary(id, name: id),
                slot: api.TimetableItemSlot(
                  dayOfWeek: api.DayOfWeek.MONDAY,
                  period: api.Period.PERIOD_1,
                ),
              ),
          ],
        ),
      )
      ..on(CourseRegistrationService.createCourseRegistration, (request) {
        final registration = _registration(request.subjectId);
        registrations[request.subjectId] = registration;
        return api.CreateCourseRegistrationResponse(
          courseRegistration: registration,
        );
      })
      ..on(CourseRegistrationService.deleteCourseRegistration, (request) {
        registrations.removeWhere((_, value) => value.id == request.id);
        return api.DeleteCourseRegistrationResponse();
      });
  }
  final List<String> initialRegisteredIds;
  final transport = FakeAppApiTransport();
  final registrations = <String, api.CourseRegistration>{};
  api.CourseRegistration _registration(String id) => api.CourseRegistration(
    id: 'registration-$id',
    subject: apiSubjectSummary(id, name: id),
  );
}
