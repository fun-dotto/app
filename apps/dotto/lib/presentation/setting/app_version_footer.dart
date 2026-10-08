import 'dart:async';

import 'package:dotto/presentation/setting/app_build_info_state.dart';
import 'package:dotto/router/routes/setting_routes.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// アプリのバージョン表示。
///
/// 開発用ビルドではタップで Debug 画面を開ける。
final class AppVersionFooter extends HookConsumerWidget {
  const new({super.key});

  static const _debuggableFlavors = {'prd', 'stg', 'dev'};

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final buildInfo = ref.watch(appBuildInfoStateProvider);
    final canOpenDebugScreen =
        kDebugMode || _debuggableFlavors.contains(appFlavor);

    return GestureDetector(
      onTap: canOpenDebugScreen
          ? () => unawaited(const DebugRouteData().push<void>(context))
          : null,
      child: Text(switch (buildInfo) {
        AsyncData(:final value) => '${value.version} (${value.buildNumber})',
        _ => '',
      }),
    );
  }
}
