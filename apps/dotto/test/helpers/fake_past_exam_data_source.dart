import 'package:dotto/data/past_exam_data_source.dart';

final class FakePastExamDataSource implements PastExamDataSource {
  const new(this.keys);
  final Map<String, List<String>> keys;
  @override
  Future<List<String>> fetchKeys(String prefix) async => keys[prefix] ?? [];
}
