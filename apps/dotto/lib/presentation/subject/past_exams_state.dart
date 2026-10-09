import 'package:dotto/application/fetch_past_exams_use_case.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'past_exams_state.g.dart';

@riverpod
final class PastExamsState extends _$PastExamsState {
  @override
  Future<List<String>> build(String pastExamId) =>
      ref.watch(fetchPastExamsUseCaseProvider)(pastExamId);
}
