import 'package:dotto/application/open_external_link_use_case.dart';
import 'package:dotto/presentation/common/use_localization.dart';
import 'package:dotto_design_system/component/button.dart';
import 'package:dotto_design_system/component/dotto_app_bar.dart';
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
    final l10n = useLocalization();
    return Scaffold(
      appBar: DottoAppBar(
        title: Text(
          l10n.invalidAppVersionTitle,
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
              l10n.rootVersionComparison(currentAppVersion, latestAppVersion),
              textAlign: TextAlign.center,
            ),
            DottoButton(
              onPressed: () => ref.read(openExternalLinkUseCaseProvider)(
                appStorePageUrl,
                shouldOpenExternally: true,
              ),
              child: Text(l10n.rootUpdateNow),
            ),
          ],
        ),
      ),
    );
  }
}
