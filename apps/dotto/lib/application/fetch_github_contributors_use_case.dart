import 'package:dotto/data/github_contributor_repository_impl.dart';
import 'package:dotto/domain/github_contributor_repository.dart';
import 'package:dotto/domain/github_profile.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'fetch_github_contributors_use_case.g.dart';

/// 開発者一覧として、Bot を除いたコントリビューターを貢献数の多い順に取得する。
final class FetchGitHubContributorsUseCase {
  const new(this._repository);

  static const _userType = 'User';

  final GitHubContributorRepository _repository;

  Future<List<GitHubProfile>> call() async {
    final contributors = await _repository.fetchAll();
    return List.unmodifiable(
      contributors
          .where((contributor) => contributor.type == _userType)
          .toList()
        ..sort((a, b) => b.contributions.compareTo(a.contributions)),
    );
  }
}

@riverpod
FetchGitHubContributorsUseCase fetchGitHubContributorsUseCase(Ref ref) =>
    FetchGitHubContributorsUseCase(
      ref.watch(gitHubContributorRepositoryProvider),
    );
