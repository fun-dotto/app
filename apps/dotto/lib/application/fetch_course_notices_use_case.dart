import 'package:dotto/application/service/course_notice_service.dart';
import 'package:dotto/domain/entity/course_notice.dart';
import 'package:dotto/domain/entity/course_notice_scope.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'fetch_course_notices_use_case.g.dart';

final class FetchCourseNoticesUseCase {
  const new(this._service);
  final CourseNoticeService _service;
  Future<List<CourseNotice>> call(CourseNoticeScope scope) =>
      _service.fetch(scope);
}

@riverpod
FetchCourseNoticesUseCase fetchCourseNoticesUseCase(Ref ref) =>
    FetchCourseNoticesUseCase(ref.watch(courseNoticeServiceProvider));
