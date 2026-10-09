import 'package:dotto/application/open_external_link_use_case.dart';
import 'package:dotto_design_system/component/button.dart';
import 'package:dotto_design_system/style/semantic_color.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';

final class InvalidAppVersionScreen extends HookConsumerWidget {
  const new({
    required this.appStorePageUrl,
    required this.currentAppVersion,
    required this.latestAppVersion,
    super.key,
  });

  final String appStorePageUrl;
  final String currentAppVersion;
  final String latestAppVersion;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Dottoのアップデートが必要です',
          style: Theme.of(context).textTheme.titleLarge
              ?.copyWith(color: SemanticColor.light.accentPrimary),
        ),
        centerTitle: false,
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 64,
          children: [
            Text(
              '現在のバージョン: $currentAppVersion\n最新バージョン: $latestAppVersion',
              textAlign: TextAlign.center,
            ),
            DottoButton(
              onPressed: () => ref.read(openExternalLinkUseCaseProvider)(
                appStorePageUrl,
                shouldOpenExternally: true,
              ),
              child: const Text('今すぐアップデート'),
            ),
          ],
        ),
      ),
    );
  }
}
