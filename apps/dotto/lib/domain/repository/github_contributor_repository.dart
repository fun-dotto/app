import 'package:dotto/domain/entity/github_profile.dart';

abstract interface class GitHubContributorRepository {
  Future<List<GitHubProfile>> fetchAll();
}
