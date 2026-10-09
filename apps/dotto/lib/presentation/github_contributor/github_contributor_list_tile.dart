import 'package:dotto/application/open_external_link_use_case.dart';
import 'package:dotto/domain/entity/github_profile.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';

final class GitHubContributorListTile extends HookConsumerWidget {
  const new({required this.profile, super.key});

  final GitHubProfile profile;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      leading: CircleAvatar(
        radius: 20,
        backgroundImage: NetworkImage(profile.avatarUrl),
        backgroundColor: Colors.grey.shade200,
      ),
      title: Text(profile.login),
      onTap: () => ref.read(openExternalLinkUseCaseProvider)(profile.htmlUrl),
    );
  }
}
