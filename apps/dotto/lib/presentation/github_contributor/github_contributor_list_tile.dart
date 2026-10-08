import 'package:dotto/domain/entity/github_profile.dart';
import 'package:dotto/helper/url_launcher_helper.dart';
import 'package:material_ui/material_ui.dart';

final class GitHubContributorListTile extends StatelessWidget {
  const new({required this.profile, super.key});

  final GitHubProfile profile;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 20,
        backgroundImage: NetworkImage(profile.avatarUrl),
        backgroundColor: Colors.grey.shade200,
      ),
      title: Text(profile.login),
      onTap: () => launchUrlSafely(profile.htmlUrl),
    );
  }
}
