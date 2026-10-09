import 'dart:async';

import 'package:dotto/application/open_external_link_use_case.dart';
import 'package:dotto/presentation/common/error_view.dart';
import 'package:dotto/presentation/common/loading_view.dart';
import 'package:dotto/presentation/github_contributor/github_contributor_content.dart';
import 'package:dotto/presentation/github_contributor/github_contributor_state.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';

final class GitHubContributorScreen extends HookConsumerWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final contributors = ref.watch(gitHubContributorStateProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('開発者')),
      body: switch (contributors) {
        AsyncData(:final value) => GitHubContributorContent(
          contributors: value,
          onRefresh: ref.read(gitHubContributorStateProvider.notifier).refresh,
          onContributorTap: (profile) => unawaited(
            ref.read(openExternalLinkUseCaseProvider)(profile.htmlUrl),
          ),
        ),
        AsyncError() => const ErrorView(),
        _ => const LoadingView(),
      },
    );
  }
}
