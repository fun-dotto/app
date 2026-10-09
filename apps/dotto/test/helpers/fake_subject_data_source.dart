import 'package:dotto/data/subject_data_source.dart';

/// Firestore とローカルシラバスの代わりにレビューを保存する。
final class FakeSubjectDataSource implements SubjectDataSource {
  final _feedbacks = <String, Map<String, dynamic>>{};
  bool shouldFail = false;
  @override
  Future<String?> readPastExamId(String lessonId) async => 'past-$lessonId';
  @override
  Future<List<Map<String, dynamic>>> readFeedbacks(String lessonId) async {
    if (shouldFail) throw const FormatException('invalid feedback');
    return [
      for (final value in _feedbacks.values)
        if (value['lessonId'] == lessonId) value,
    ];
  }

  @override
  Future<void> writeFeedback({
    required String userId,
    required String lessonId,
    required int score,
    required String comment,
  }) async {
    _feedbacks['$userId:$lessonId'] = {
      'lessonId': lessonId,
      'score': score,
      'detail': comment,
    };
  }
}
