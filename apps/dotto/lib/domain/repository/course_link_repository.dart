import 'package:dotto/domain/entity/course_link_event.dart';

abstract interface class CourseLinkRepository {
  Future<bool> open(String url, {CourseLinkEvent? event});
}
