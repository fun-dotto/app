import 'package:dotto/application/fetch_course_resources_use_case.dart';
import 'package:dotto/domain/entity/course_resources.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'course_resources_state.g.dart';

@riverpod
final class CourseResourcesState extends _$CourseResourcesState {
  @override
  CourseResources build() => ref.watch(fetchCourseResourcesUseCaseProvider)();
}
