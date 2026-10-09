import 'package:dotto/data/course_link_repository_impl.dart';
import 'package:dotto/domain/entity/course_link_event.dart';
import 'package:dotto/domain/repository/course_link_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'open_course_link_use_case.g.dart';

@riverpod
OpenCourseLinkUseCase openCourseLinkUseCase(Ref ref) =>
    OpenCourseLinkUseCase(ref.watch(courseLinkRepositoryProvider));

final class OpenCourseLinkUseCase {
  const new(this._repository);
  final CourseLinkRepository _repository;
  Future<bool> call(String url, {CourseLinkEvent? event}) =>
      _repository.open(url, event: event);
}
