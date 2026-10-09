import 'package:dotto/domain/entity/course_notice.dart';

abstract interface class RoomChangeRepository {
  Future<List<CourseNotice>> fetchAll({List<String>? subjectIds});
}
