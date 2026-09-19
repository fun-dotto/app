import 'package:dotto/foundation/flag/feature_flag.dart';
import 'package:dotto/foundation/flag/flag.dart';
import 'package:dotto/foundation/flag/flag_overrides.dart';
import 'package:dotto/foundation/flag/flags.dart';
import 'package:dotto/repository/feature_flag_repository.dart';
import 'package:dotto_design_system/component/list_section.dart';
import 'package:dotto_design_system/component/list_tile.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final class DebugScreen extends HookConsumerWidget {
  const DebugScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appCheckToken = useFuture(
      useMemoized(() => FirebaseAppCheck.instance.getToken()),
    );
    final idToken = useFuture(
      useMemoized(() => FirebaseAuth.instance.currentUser?.getIdToken()),
    );
    final fcmToken = useFuture(
      useMemoized(() => FirebaseMessaging.instance.getToken()),
    );
    final overrides = ref.watch(flagOverridesProvider);

    Future<void> copyToClipboard(String? value) async {
      if (value == null) {
        return;
      }
      await Clipboard.setData(ClipboardData(text: value));
      if (!context.mounted) {
        return;
      }
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('クリップボードにコピーしました')));
    }

    DottoListTile tokenTile(String label, String? token) {
      return DottoListTile(
        firstLine: Text(label),
        secondLine: Text(
          token ?? '-',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        onTap: () async => copyToClipboard(token),
      );
    }

    Future<void> showFlagOverridePicker(Flag<bool> flag) async {
      final notifier = ref.read(flagOverridesProvider.notifier);
      final override = overrides[flag.key];
      final remoteConfigValue = ref
          .read(featureFlagRepositoryProvider)
          .get(flag);

      await showDialog<void>(
        context: context,
        builder: (dialogContext) => SimpleDialog(
          title: Text('${flag.description} Override'),
          children: [
            SimpleDialogOption(
              onPressed: () async {
                Navigator.of(dialogContext).pop();
                await notifier.setOverride(flag, value: null);
              },
              child: ListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('Use Remote Config'),
                subtitle: Text('Remote Config: $remoteConfigValue'),
                trailing: override == null ? const Icon(Icons.check) : null,
              ),
            ),
            SimpleDialogOption(
              onPressed: () async {
                Navigator.of(dialogContext).pop();
                await notifier.setOverride(flag, value: true);
              },
              child: ListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('Force true'),
                trailing: override == true ? const Icon(Icons.check) : null,
              ),
            ),
            SimpleDialogOption(
              onPressed: () async {
                Navigator.of(dialogContext).pop();
                await notifier.setOverride(flag, value: false);
              },
              child: ListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('Force false'),
                trailing: override == false ? const Icon(Icons.check) : null,
              ),
            ),
          ],
        ),
      );
    }

    DottoListTile flagTile(Flag<Object> flag) {
      final override = overrides[flag.key];
      final effectiveValue = ref.watch(featureFlagProvider(flag));
      // bool のフラグだけ上書きできる。
      final boolFlag = flag is Flag<bool> ? flag : null;

      return DottoListTile(
        firstLine: Text('${flag.description} Flag'),
        secondLine: Text(switch (override) {
          null => 'Use Remote Config',
          _ => 'Forced: $override',
        }),
        thirdLine: Text('Effective: $effectiveValue'),
        trailing: boolFlag == null
            ? const DottoListTileTrailing.none()
            : const DottoListTileTrailing.chevron(),
        onTap: boolFlag == null
            ? null
            : () async => showFlagOverridePicker(boolFlag),
      );
    }

    if (appCheckToken.connectionState == ConnectionState.waiting ||
        idToken.connectionState == ConnectionState.waiting ||
        fcmToken.connectionState == ConnectionState.waiting) {
      return Scaffold(
        appBar: AppBar(title: const Text('Debug')),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    if (appCheckToken.hasError || idToken.hasError || fcmToken.hasError) {
      return Scaffold(
        appBar: AppBar(title: const Text('Debug')),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Center(child: Text('${appCheckToken.error ?? idToken.error}')),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Debug')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          spacing: 16,
          children: [
            DottoListSection(
              header: const Text('Token'),
              footer: const Text('タップするとクリップボードにコピーします。'),
              children: [
                tokenTile('App Check Access Token', appCheckToken.data),
                tokenTile('User ID Token', idToken.data),
                tokenTile('FCM Token', fcmToken.data),
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
              children: Flags.all.map(flagTile).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
