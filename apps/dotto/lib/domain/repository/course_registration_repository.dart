import 'package:dotto/domain/entity/course_registration.dart';
import 'package:dotto/domain/entity/semester.dart';

abstract interface class CourseRegistrationRepository {
  Future<List<CourseRegistration>> getCourseRegistrations(
    List<Semester> semesters,
  );
  Future<void> registerCourse(String subjectId);
  Future<void> unregisterCourse(String id);
}
