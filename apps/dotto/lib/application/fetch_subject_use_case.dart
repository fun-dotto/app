import 'package:dotto/data/subject_repository_impl.dart';
import 'package:dotto/domain/entity/subject.dart';
import 'package:dotto/domain/repository/subject_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'fetch_subject_use_case.g.dart';

@riverpod
FetchSubjectUseCase fetchSubjectUseCase(Ref ref) =>
    FetchSubjectUseCase(ref.watch(subjectRepositoryProvider));

final class FetchSubjectUseCase {
  const new(this._repository);
  final SubjectRepository _repository;
  Future<Subject> call(String id) => _repository.getSubject(id);
}
