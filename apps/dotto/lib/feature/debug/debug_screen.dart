import 'package:dotto/controller/feature_flag_controller.dart';
import 'package:dotto/foundation/flag.dart';
import 'package:dotto/foundation/flags.dart';
import 'package:dotto/repository/feature_flag_repository.dart';
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

    Widget flagTile(Flag<Object> flag) {
      final override = overrides[flag.key];
      final effectiveValue = ref.watch(featureFlagProvider(flag));

      return ListTile(
        title: Text('${flag.description} Flag'),
        subtitle: Text(switch (override) {
          null => 'Use Remote Config',
          _ => 'Forced: $override',
        }),
        trailing: Text('Effective: $effectiveValue'),
        onTap: flag is Flag<bool> ? () => showFlagOverridePicker(flag) : null,
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
      body: ListView(
        children: [
          ListTile(
            title: const Text('App Check Access Token'),
            subtitle: Text(
              appCheckToken.data ?? '-',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            trailing: IconButton(
              icon: const Icon(Icons.copy),
              onPressed: () async {
                if (appCheckToken.data == null) return;
                await Clipboard.setData(
                  ClipboardData(text: appCheckToken.data ?? ''),
                );
                if (!context.mounted) return;
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('クリップボードにコピーしました')),
                );
              },
            ),
          ),
          ListTile(
            title: const Text('User ID Token'),
            subtitle: Text(
              idToken.data ?? '-',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            trailing: IconButton(
              icon: const Icon(Icons.copy),
              onPressed: () async {
                if (idToken.data == null) return;
                await Clipboard.setData(
                  ClipboardData(text: idToken.data ?? ''),
                );
                if (!context.mounted) return;
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('クリップボードにコピーしました')),
                );
              },
            ),
          ),
          ListTile(
            title: const Text('FCM Token'),
            subtitle: Text(
              fcmToken.data ?? '-',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            trailing: IconButton(
              icon: const Icon(Icons.copy),
              onPressed: () async {
                if (fcmToken.data == null) return;
                await Clipboard.setData(
                  ClipboardData(text: fcmToken.data ?? ''),
                );
                if (!context.mounted) return;
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('クリップボードにコピーしました')),
                );
              },
            ),
          ),
          const ListTile(
            title: Text('Environment'),
            trailing: Text(appFlavor ?? 'Default'),
          ),
          ...Flags.all.map(flagTile),
        ],
      ),
    );
  }
}
