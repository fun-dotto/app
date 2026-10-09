import 'package:dotto/domain/entity/github_profile.dart';
import 'package:dotto/presentation/github_contributor/github_contributor_content.dart';
import 'package:flutter/widgets.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

// 画像はネットワークから取得しないよう、空の URL とする (背景色のみ表示される)。
const _contributors = [
  GitHubProfile(
    id: '1',
    login: 'dotto-dev',
    avatarUrl: '',
    htmlUrl: 'https://github.com/dotto-dev',
    contributions: 100,
    type: 'User',
  ),
  GitHubProfile(
    id: '2',
    login: 'a-very-long-github-user-name-for-layout-check',
    avatarUrl: '',
    htmlUrl: 'https://github.com/a-very-long-github-user-name-for-layout-check',
    contributions: 10,
    type: 'User',
  ),
];

@widgetbook.UseCase(name: 'Default', type: GitHubContributorContent)
Widget gitHubContributorContentDefault(BuildContext context) =>
    GitHubContributorContent(
      contributors: _contributors,
      onRefresh: () async {},
      onContributorTap: (_) {},
    );

@widgetbook.UseCase(name: 'Empty', type: GitHubContributorContent)
Widget gitHubContributorContentEmpty(BuildContext context) =>
    GitHubContributorContent(
      contributors: const [],
      onRefresh: () async {},
      onContributorTap: (_) {},
    );
