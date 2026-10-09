import 'package:dotto/domain/entity/github_profile.dart';
import 'package:dotto/presentation/github_contributor/github_contributor_list_tile.dart';
import 'package:material_ui/material_ui.dart';

/// 開発者一覧の表示。
final class GitHubContributorContent extends StatelessWidget {
  const new({
    required this.contributors,
    required this.onRefresh,
    required this.onContributorTap,
    super.key,
  });

  final List<GitHubProfile> contributors;
  final RefreshCallback onRefresh;
  final ValueChanged<GitHubProfile> onContributorTap;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: ListView.separated(
        itemCount: contributors.length,
        separatorBuilder: (_, _) => const Divider(height: 0),
        itemBuilder: (_, index) => GitHubContributorListTile(
          profile: contributors[index],
          onTap: () => onContributorTap(contributors[index]),
        ),
      ),
    );
  }
}
