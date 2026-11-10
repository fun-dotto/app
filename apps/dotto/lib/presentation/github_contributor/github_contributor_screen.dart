import 'package:dotto/presentation/common/error_view.dart';
import 'package:dotto/presentation/common/loading_view.dart';
import 'package:dotto/presentation/common/use_localization.dart';
import 'package:dotto/presentation/github_contributor/github_contributor_list_tile.dart';
import 'package:dotto/presentation/github_contributor/github_contributor_state.dart';
import 'package:dotto_design_system/component/dotto_app_bar.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';

final class GitHubContributorScreen extends HookConsumerWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = useLocalization();
    final contributors = ref.watch(gitHubContributorStateProvider);

    return Scaffold(
      appBar: DottoAppBar(title: Text(l10n.settingsDevelopers)),
      body: switch (contributors) {
        AsyncData(:final value) => RefreshIndicator(
          onRefresh: ref.read(gitHubContributorStateProvider.notifier).refresh,
          child: ListView.separated(
            itemCount: value.length,
            separatorBuilder: (_, _) => const Divider(height: 0),
            itemBuilder: (_, index) =>
                GitHubContributorListTile(profile: value[index]),
          ),
        ),
        AsyncError() => const ErrorView(),
        _ => const LoadingView(),
      },
    );
  }
}
