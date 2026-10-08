import 'dart:async';

import 'package:dotto/domain/entity/debug_tokens.dart';
import 'package:dotto/foundation/flag/flag.dart';
import 'package:dotto/foundation/flag/flags.dart';
import 'package:dotto/presentation/common/feature_flag.dart';
import 'package:dotto/presentation/common/flag_override_state.dart';
import 'package:dotto/presentation/debug/debug_tokens_state.dart';
import 'package:dotto/presentation/debug/flag_override_dialog.dart';
import 'package:dotto_design_system/component/list_section.dart';
import 'package:dotto_design_system/component/list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final class DebugScreen extends HookConsumerWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tokens = ref.watch(debugTokensStateProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Debug')),
      body: switch (tokens) {
        AsyncData(:final value) => _DebugContent(tokens: value),
        AsyncError(:final error) => Padding(
          padding: const EdgeInsets.all(16),
          child: Center(child: Text('$error')),
        ),
        _ => const Center(child: CircularProgressIndicator()),
      },
    );
  }
}

final class _DebugContent extends StatelessWidget {
  const new({required this.tokens});

  final DebugTokens tokens;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        spacing: 16,
        children: [
          DottoListSection(
            header: const Text('Token'),
            footer: const Text('タップするとクリップボードにコピーします。'),
            children: [
              _TokenTile(
                label: 'App Check Access Token',
                token: tokens.appCheckToken,
              ),
              _TokenTile(label: 'User ID Token', token: tokens.idToken),
              _TokenTile(label: 'FCM Token', token: tokens.fcmToken),
            ],
          ),
          const DottoListSection(
            header: Text('Environment'),
            children: [
              DottoListTile(
                firstLine: Text('Flavor'),
                secondLine: Text(appFlavor ?? 'Default'),
              ),
            ],
          ),
          DottoListSection(
            header: const Text('Feature Flag'),
            children: Flags.all.map((flag) => _FlagTile(flag: flag)).toList(),
          ),
        ],
      ),
    );
  }
}

final class _TokenTile extends StatelessWidget {
  const new({required this.label, required this.token});

  final String label;
  final String? token;

  @override
  Widget build(BuildContext context) {
    final token = this.token;
    return DottoListTile(
      firstLine: Text(label),
      secondLine: Text(
        token ?? '-',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      onTap: token == null
          ? null
          : () async {
              await Clipboard.setData(ClipboardData(text: token));
              if (!context.mounted) return;
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text('クリップボードにコピーしました')));
            },
    );
  }
}

final class _FlagTile extends HookConsumerWidget {
  const new({required this.flag});

  final Flag<Object> flag;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final override = ref.watch(flagOverrideStateProvider)[flag.key];
    final effectiveValue = ref.watch(featureFlagProvider(flag));

    return DottoListTile(
      firstLine: Text('${flag.description} Flag'),
      secondLine: Text(switch (override) {
        null => 'Use Remote Config',
        final override => 'Forced: $override',
      }),
      thirdLine: Text('Effective: $effectiveValue'),
      // 上書きできるのは bool のフラグのみ
      trailing: switch (flag) {
        Flag<bool>() => const DottoListTileTrailing.chevron(),
        _ => const DottoListTileTrailing.none(),
      },
      onTap: switch (flag) {
        final Flag<bool> boolFlag => () => unawaited(
          showDialog<void>(
            context: context,
            builder: (_) => FlagOverrideDialog(flag: boolFlag),
          ),
        ),
        _ => null,
      },
    );
  }
}
