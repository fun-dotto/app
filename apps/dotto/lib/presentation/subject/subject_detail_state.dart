import 'package:dotto/application/fetch_subject_use_case.dart';
import 'package:dotto/domain/entity/subject.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'subject_detail_state.g.dart';

@riverpod
final class SubjectDetailState extends _$SubjectDetailState {
  @override
  Future<Subject> build(String id) =>
      ref.watch(fetchSubjectUseCaseProvider)(id);
}
