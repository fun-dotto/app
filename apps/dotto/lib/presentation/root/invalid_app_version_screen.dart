import 'dart:async';

import 'package:dotto/application/open_external_link_use_case.dart';
import 'package:dotto/presentation/root/invalid_app_version_content.dart';
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
    return InvalidAppVersionContent(
      currentAppVersion: currentAppVersion,
      latestAppVersion: latestAppVersion,
      onUpdate: () => unawaited(
        ref.read(openExternalLinkUseCaseProvider)(
          appStorePageUrl,
          shouldOpenExternally: true,
        ),
      ),
    );
  }
}
