import 'package:dotto/helper/s3_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'past_exam_data_source.g.dart';

@riverpod
PastExamDataSource pastExamDataSource(Ref ref) => const PastExamDataSource();

/// オブジェクトストレージの過去問一覧へアクセスする。
class PastExamDataSource {
  const new();
  Future<List<String>> fetchKeys(String prefix) =>
      S3Repository().getListObjectsKey(url: prefix);
}
