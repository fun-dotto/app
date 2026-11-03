import 'package:dotto/domain/entity/subject_summary.dart';
import 'package:dotto_app_api/app/v1/course_registration.connect.spec.dart';
import 'package:dotto_app_api/app/v1/course_registration.pb.dart';
import 'package:dotto_app_api/app/v1/timetable_item.connect.spec.dart';
import 'package:dotto_app_api/app/v1/timetable_item.pb.dart';

import 'app_api_fixtures.dart';
import 'fake_app_api.dart';

/// 履修登録を API 境界で保持するインメモリAPI。
final class FakeCourseApi {
  new({Set<String> registeredSubjectIds = const {}})
    : registeredSubjectIds = {...registeredSubjectIds} {
    api
      ..on(
        CourseRegistrationService.listCourseRegistrations,
        (_) => ListCourseRegistrationsResponse(
          courseRegistrations: [
            for (final id in this.registeredSubjectIds)
              courseRegistrationFixture(id),
          ],
        ),
      )
      ..on(
        TimetableItemService.listTimetableItems,
        (_) => ListTimetableItemsResponse(
          timetableItems: [
            for (final id in ['a', 'b', 'c'])
              mondayFirstTimetableItemFixture(
                'item-$id',
                subjectSummaryFixture(id),
              ),
          ],
        ),
      )
      ..on(CourseRegistrationService.createCourseRegistration, (request) {
        this.registeredSubjectIds.add(request.subjectId);
        return CreateCourseRegistrationResponse(
          courseRegistration: courseRegistrationFixture(request.subjectId),
        );
      })
      ..on(CourseRegistrationService.deleteCourseRegistration, (request) {
        this.registeredSubjectIds.remove(
          request.id.replaceFirst('registration-', ''),
        );
        return DeleteCourseRegistrationResponse();
      });
  }

  final api = FakeAppApi();
  final Set<String> registeredSubjectIds;

  SubjectSummary subject(String id) =>
      SubjectSummary(id: id, name: '科目$id', faculties: const []);
}
