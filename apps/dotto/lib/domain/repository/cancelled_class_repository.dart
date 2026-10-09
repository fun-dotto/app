import 'package:dotto/domain/entity/course_notice.dart';

abstract interface class CancelledClassRepository {
  Future<List<CourseNotice>> fetchAll({List<String>? subjectIds});
}
