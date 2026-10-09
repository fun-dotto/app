import 'package:dotto/domain/entity/course_resources.dart';

abstract interface class CourseResourceRepository {
  CourseResources fetch();
}
