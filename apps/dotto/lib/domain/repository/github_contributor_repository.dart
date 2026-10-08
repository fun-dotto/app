import 'package:dotto/domain/github_profile.dart';

abstract interface class GitHubContributorRepository {
  Future<List<GitHubProfile>> fetchAll();
}
