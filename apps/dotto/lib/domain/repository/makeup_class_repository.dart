import 'package:dotto/domain/entity/course_notice.dart';

abstract interface class MakeupClassRepository {
  Future<List<CourseNotice>> fetchAll({List<String>? subjectIds});
}
