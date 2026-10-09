import 'package:dotto/application/search_subjects_use_case.dart';
import 'package:dotto/domain/entity/subject_filter.dart';
import 'package:dotto/domain/entity/subject_summary.dart';
import 'package:dotto/presentation/common/is_authenticated.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'search_subject_state.g.dart';

@riverpod
final class SearchSubjectState extends _$SearchSubjectState {
  int _latestRequest = 0;
  @override
  Future<List<SubjectSummary>> build() async => const [];
  Future<void> search({
    required String query,
    required SubjectFilter filter,
  }) async {
    final request = ++_latestRequest;
    state = const AsyncLoading();
    final result = await AsyncValue.guard(
      () => ref.read(searchSubjectsUseCaseProvider)(
        query: query,
        filter: filter,
        isAuthenticated: ref.read(isAuthenticatedProvider),
      ),
    );
    if (ref.mounted && request == _latestRequest) state = result;
  }

  void clear() {
    _latestRequest++;
    state = const AsyncData([]);
  }
}
