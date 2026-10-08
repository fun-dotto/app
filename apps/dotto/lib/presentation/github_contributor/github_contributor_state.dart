import 'package:dotto/application/fetch_github_contributors_use_case.dart';
import 'package:dotto/domain/entity/github_profile.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'github_contributor_state.g.dart';

@riverpod
final class GitHubContributorState extends _$GitHubContributorState {
  @override
  Future<List<GitHubProfile>> build() =>
      ref.watch(fetchGitHubContributorsUseCaseProvider)();

  /// 表示中の一覧を残したまま再取得する。
  Future<void> refresh() async {
    state = await AsyncValue.guard(
      ref.read(fetchGitHubContributorsUseCaseProvider).call,
    );
  }
}
