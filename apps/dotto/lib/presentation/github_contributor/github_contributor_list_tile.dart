import 'package:dotto/domain/entity/github_profile.dart';
import 'package:material_ui/material_ui.dart';

final class GitHubContributorListTile extends StatelessWidget {
  const new({required this.profile, required this.onTap, super.key});

  final GitHubProfile profile;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 20,
        backgroundImage: NetworkImage(profile.avatarUrl),
        backgroundColor: Colors.grey.shade200,
      ),
      title: Text(profile.login),
      onTap: onTap,
    );
  }
}
