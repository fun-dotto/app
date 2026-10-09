import 'package:dotto/data/course_resource_repository_impl.dart';
import 'package:dotto/domain/entity/course_resources.dart';
import 'package:dotto/domain/repository/course_resource_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'fetch_course_resources_use_case.g.dart';

@riverpod
FetchCourseResourcesUseCase fetchCourseResourcesUseCase(Ref ref) =>
    FetchCourseResourcesUseCase(ref.watch(courseResourceRepositoryProvider));

final class FetchCourseResourcesUseCase {
  const new(this._repository);
  final CourseResourceRepository _repository;
  CourseResources call() => _repository.fetch();
}
