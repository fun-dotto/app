abstract interface class PastExamRepository {
  Future<List<String>> fetchKeys(String pastExamId);
}
