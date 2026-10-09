import 'package:dotto/data/s3_data_source.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'past_exam_data_source.g.dart';

@riverpod
PastExamDataSource pastExamDataSource(Ref ref) =>
    PastExamDataSource(ref.watch(s3DataSourceProvider));

/// オブジェクトストレージの過去問一覧へアクセスする。
class PastExamDataSource {
  const new(this._storage);
  final S3DataSource _storage;
  Future<List<String>> fetchKeys(String prefix) =>
      _storage.getListObjectsKey(url: prefix);
}
