import 'dart:async';

import 'package:dotto/domain/entity/flags.dart';
import 'package:dotto/presentation/common/feature_flag.dart';
import 'package:dotto/presentation/common/flag_override_state.dart';
import 'package:dotto/presentation/debug/debug_content.dart';
import 'package:dotto/presentation/debug/debug_tokens_state.dart';
import 'package:dotto/presentation/debug/flag_override_dialog.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';

final class DebugScreen extends HookConsumerWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tokens = ref.watch(debugTokensStateProvider);
    final overrides = ref.watch(flagOverrideStateProvider);
    final flags = [
      for (final flag in Flags.all)
        (
          flag: flag,
          override: overrides[flag.key],
          effectiveValue: ref.watch(featureFlagProvider(flag)),
        ),
    ];

    Future<void> copyToken(String token) async {
      await Clipboard.setData(ClipboardData(text: token));
      if (!context.mounted) return;
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('クリップボードにコピーしました')));
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Debug')),
      body: switch (tokens) {
        AsyncData(:final value) => DebugContent(
          tokens: value,
          flavor: appFlavor,
          flags: flags,
          onTokenTap: (token) => unawaited(copyToken(token)),
          onFlagTap: (flag) => unawaited(
            showDialog<void>(
              context: context,
              builder: (_) => FlagOverrideDialog(flag: flag),
            ),
          ),
        ),
        AsyncError(:final error) => Padding(
          padding: const EdgeInsets.all(16),
          child: Center(child: Text('$error')),
        ),
        _ => const Center(child: CircularProgressIndicator()),
      },
    );
  }
}
