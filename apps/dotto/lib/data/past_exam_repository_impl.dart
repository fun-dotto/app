import 'package:dotto/data/domain_error_mapper.dart';
import 'package:dotto/data/past_exam_data_source.dart';
import 'package:dotto/domain/repository/past_exam_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'past_exam_repository_impl.g.dart';

@riverpod
PastExamRepository pastExamRepository(Ref ref) =>
    PastExamRepositoryImpl(ref.watch(pastExamDataSourceProvider));

final class PastExamRepositoryImpl implements PastExamRepository {
  const new(this._source);
  final PastExamDataSource _source;
  @override
  Future<List<String>> fetchKeys(String pastExamId) async {
    try {
      return List.unmodifiable(await _source.fetchKeys(pastExamId));
    } on Exception catch (e, stackTrace) {
      throw mapDomainError(e: e, stackTrace: stackTrace);
    }
  }
}
