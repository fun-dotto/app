import 'package:dotto_app_api/app/v1/course_registration.connect.spec.dart';
import 'package:dotto_app_api/app/v1/course_registration.pb.dart';
import 'package:dotto_app_api/app/v1/timetable_item.connect.spec.dart';
import 'package:dotto_app_api/app/v1/timetable_item.pb.dart';

import 'app_api_fixtures.dart';
import 'fake_app_api.dart';

/// 履修登録APIの登録結果をメモリ内に保存する。
final class FakeCourseRegistrationApi {
  new({this.initialRegisteredIds = const []}) {
    for (final id in initialRegisteredIds) {
      registrations[id] = courseRegistrationFixture(id, name: id);
    }
    api
      ..on(
        CourseRegistrationService.listCourseRegistrations,
        (_) => ListCourseRegistrationsResponse(
          courseRegistrations: registrations.values,
        ),
      )
      ..on(
        TimetableItemService.listTimetableItems,
        (_) => ListTimetableItemsResponse(
          timetableItems: [
            for (final id in ['first', 'second', 'target'])
              mondayFirstTimetableItemFixture(
                id,
                subjectSummaryFixture(id, name: id),
              ),
          ],
        ),
      )
      ..on(CourseRegistrationService.createCourseRegistration, (request) {
        final registration = courseRegistrationFixture(
          request.subjectId,
          name: request.subjectId,
        );
        registrations[request.subjectId] = registration;
        return CreateCourseRegistrationResponse(
          courseRegistration: registration,
        );
      })
      ..on(CourseRegistrationService.deleteCourseRegistration, (request) {
        if (request.id == 'registration-target') {
          registrations.remove('target');
        }
        return DeleteCourseRegistrationResponse();
      });
  }
  final List<String> initialRegisteredIds;
  final api = FakeAppApi();
  final registrations = <String, CourseRegistration>{};
}
