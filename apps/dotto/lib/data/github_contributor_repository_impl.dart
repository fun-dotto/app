import 'package:dio/dio.dart';
import 'package:dotto/data/github_api_client.dart';
import 'package:dotto/domain/domain_error.dart';
import 'package:dotto/domain/github_contributor_repository.dart';
import 'package:dotto/domain/github_profile.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'github_contributor_repository_impl.g.dart';

@riverpod
GitHubContributorRepository gitHubContributorRepository(Ref ref) =>
    GitHubContributorRepositoryImpl(ref.watch(gitHubApiClientProvider));

final class GitHubContributorRepositoryImpl
    implements GitHubContributorRepository {
  const new(this._client);

  static const _contributorsPath = '/repos/fun-dotto/dotto/contributors';

  /// GitHub API が type を返さない場合は、人のアカウントとして扱う。
  static const _defaultType = 'User';

  final Dio _client;

  @override
  Future<List<GitHubProfile>> fetchAll() async {
    try {
      final response = await _client.get<List<Object?>>(_contributorsPath);
      final data = response.data;
      if (data == null) {
        throw const DomainError(
          type: DomainErrorType.invalidResponse,
          message: 'Failed to get contributors',
        );
      }
      return List.unmodifiable(data.map(_toGitHubProfile));
    } on DomainError {
      rethrow;
    } on Exception catch (e, stackTrace) {
      throw DomainError.fromException(e: e, stackTrace: stackTrace);
    }
  }

  GitHubProfile _toGitHubProfile(Object? json) {
    return switch (json) {
      {
        'id': final int id,
        'login': final String login,
        'avatar_url': final String avatarUrl,
        'html_url': final String htmlUrl,
        'contributions': final int contributions,
      } =>
        GitHubProfile(
          id: id.toString(),
          login: login,
          avatarUrl: avatarUrl,
          htmlUrl: htmlUrl,
          contributions: contributions,
          type: switch (json['type']) {
            final String type => type,
            _ => _defaultType,
          },
        ),
      _ => throw const DomainError(
        type: DomainErrorType.invalidResponse,
        message: 'Invalid contributor response',
      ),
    };
  }
}
