import 'package:dotto/domain/entity/subject_summary.dart';
import 'package:dotto_app_api/app/v1/common.pbenum.dart' as api;
import 'package:dotto_app_api/app/v1/course_registration.connect.spec.dart';
import 'package:dotto_app_api/app/v1/course_registration.pb.dart' as api;
import 'package:dotto_app_api/app/v1/timetable_item.connect.spec.dart';
import 'package:dotto_app_api/app/v1/timetable_item.pb.dart' as api;
import 'package:dotto_app_api/google/type/dayofweek.pbenum.dart' as api;

import 'api_subject.dart';
import 'fake_app_api_transport.dart';

/// 履修登録を RPC 境界で保持するインメモリAPI。
final class FakeCourseApi {
  new({Set<String> registeredSubjectIds = const {}})
    : registeredSubjectIds = {...registeredSubjectIds} {
    transport
      ..on(
        CourseRegistrationService.listCourseRegistrations,
        (_) => api.ListCourseRegistrationsResponse(
          courseRegistrations: [
            for (final id in this.registeredSubjectIds) _registration(id),
          ],
        ),
      )
      ..on(
        TimetableItemService.listTimetableItems,
        (_) => api.ListTimetableItemsResponse(
          timetableItems: [
            for (final id in ['a', 'b', 'c'])
              api.TimetableItem(
                id: 'item-$id',
                subject: apiSubjectSummary(id),
                slot: api.TimetableItemSlot(
                  dayOfWeek: api.DayOfWeek.MONDAY,
                  period: api.Period.PERIOD_1,
                ),
              ),
          ],
        ),
      )
      ..on(CourseRegistrationService.createCourseRegistration, (request) {
        this.registeredSubjectIds.add(request.subjectId);
        return api.CreateCourseRegistrationResponse(
          courseRegistration: _registration(request.subjectId),
        );
      })
      ..on(CourseRegistrationService.deleteCourseRegistration, (request) {
        this.registeredSubjectIds.removeWhere(
          (id) => 'registration-$id' == request.id,
        );
        return api.DeleteCourseRegistrationResponse();
      });
  }

  final transport = FakeAppApiTransport();
  final Set<String> registeredSubjectIds;

  SubjectSummary subject(String id) =>
      SubjectSummary(id: id, name: '科目$id', faculties: const []);

  api.CourseRegistration _registration(String id) => api.CourseRegistration(
    id: 'registration-$id',
    subject: apiSubjectSummary(id),
  );
}
