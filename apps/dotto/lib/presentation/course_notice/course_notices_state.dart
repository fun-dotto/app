import 'package:dotto/application/fetch_course_notices_use_case.dart';
import 'package:dotto/domain/entity/course_notice.dart';
import 'package:dotto/domain/entity/course_notice_scope.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'course_notices_state.g.dart';

@riverpod
final class CourseNoticesState extends _$CourseNoticesState {
  @override
  Future<List<CourseNotice>> build(CourseNoticeScope scope) =>
      ref.watch(fetchCourseNoticesUseCaseProvider)(scope);
  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref.read(fetchCourseNoticesUseCaseProvider)(scope),
    );
  }
}
