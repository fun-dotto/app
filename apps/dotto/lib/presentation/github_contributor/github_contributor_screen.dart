import 'package:dotto/presentation/common/error_view.dart';
import 'package:dotto/presentation/common/loading_view.dart';
import 'package:dotto/presentation/github_contributor/github_contributor_list_tile.dart';
import 'package:dotto/presentation/github_contributor/github_contributor_state.dart';
import 'package:dotto_design_system/component/content.dart';
import 'package:dotto_design_system/component/dotto_app_bar.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';

final class GitHubContributorScreen extends HookConsumerWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final contributors = ref.watch(gitHubContributorStateProvider);

    return Scaffold(
      appBar: const DottoAppBar(title: Text('開発者')),
      body: switch (contributors) {
        AsyncData(:final value) => RefreshIndicator(
          onRefresh: ref.read(gitHubContributorStateProvider.notifier).refresh,
          child: DottoContentInsets(
            margin: false,
            builder: (_, insets) => ListView.separated(
              padding: insets + MediaQuery.paddingOf(context),
              itemCount: value.length,
              separatorBuilder: (_, _) => const Divider(height: 0),
              itemBuilder: (_, index) =>
                  GitHubContributorListTile(profile: value[index]),
            ),
          ),
        ),
        AsyncError() => const ErrorView(),
        _ => const LoadingView(),
      },
    );
  }
}
