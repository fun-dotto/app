import 'dart:async';

import 'package:dotto/domain/dotto_user.dart';
import 'package:dotto/helper/url_launcher_helper.dart';
import 'package:dotto/presentation/common/notification_alert_status_state.dart';
import 'package:dotto/presentation/common/user_state.dart';
import 'package:dotto/presentation/setting/app_links_state.dart';
import 'package:dotto/presentation/setting/app_version_footer.dart';
import 'package:dotto/presentation/setting/user_info_tile.dart';
import 'package:dotto/presentation/setting/user_profile_section.dart';
import 'package:dotto/router/routes/setting_routes.dart';
import 'package:dotto_design_system/component/button.dart';
import 'package:dotto_design_system/component/dialog.dart';
import 'package:dotto_design_system/component/list_section.dart';
import 'package:dotto_design_system/component/list_tile.dart';
import 'package:dotto_design_system/style/semantic_color.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final class SettingsScreen extends HookConsumerWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userStateProvider);

    ref.listen(userStateProvider, (previous, next) {
      final wasSignedOut =
          previous?.value == null && !(previous?.hasError ?? false);
      if (wasSignedOut && next.hasError) {
        unawaited(_showSignInErrorDialog(context));
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '設定',
          style: Theme.of(context).textTheme.titleLarge
              ?.copyWith(color: SemanticColor.light.accentPrimary),
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          spacing: 16,
          children: [
            _AccountTile(user: user),
            if (user.value case final DottoUser value)
              UserProfileSection(user: value),
            const _AboutAppSection(),
          ],
        ),
      ),
    );
  }

  Future<void> _showSignInErrorDialog(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (dialogContext) => DottoDialog(
        type: .alert,
        title: 'ログインに失敗しました',
        message: '時間をおいてもう一度お試しください。',
        actionButtons: [
          DottoButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}

/// ログイン状態を表示し、タップでログイン・ログアウトする。
final class _AccountTile extends HookConsumerWidget {
  const new({required this.user});

  final AsyncValue<DottoUser?> user;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(userStateProvider.notifier);
    final signedInUser = user.value;

    return UserInfoTile(
      user: signedInUser,
      isLoading: user.isLoading,
      onTap: signedInUser == null
          ? () => unawaited(notifier.signIn())
          : () => unawaited(
              _showSignOutConfirmDialog(
                context,
                onConfirmed: () => unawaited(notifier.signOut()),
              ),
            ),
    );
  }

  Future<void> _showSignOutConfirmDialog(
    BuildContext context, {
    required VoidCallback onConfirmed,
  }) {
    return showDialog<void>(
      context: context,
      builder: (dialogContext) => DottoDialog(
        type: .plain,
        title: 'ログアウトしますか？',
        message: '',
        actionButtons: [
          DottoButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            type: .outlined,
            child: const Text('キャンセル'),
          ),
          DottoButton(
            onPressed: () {
              Navigator.of(dialogContext).pop();
              onConfirmed();
            },
            child: const Text('ログアウト'),
          ),
        ],
      ),
    );
  }
}

final class _AboutAppSection extends HookConsumerWidget {
  const new();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appLinks = ref.watch(appLinksStateProvider);
    final notificationStatus = ref.watch(notificationAlertStatusStateProvider);

    return DottoListSection(
      header: const Text('アプリについて'),
      footer: const AppVersionFooter(),
      children: [
        _LinkTile(
          title: 'お知らせ',
          icon: Icons.notifications,
          onTap: () => const AnnouncementsRouteData().push<void>(context),
        ),
        DottoListTile(
          firstLine: const Text('通知'),
          leading: const Icon(Icons.notifications_active),
          secondLine: Text(notificationStatus.value?.label ?? '確認中'),
          trailing: const DottoListTileTrailing.chevron(),
          onTap: () => ref
              .read(notificationAlertStatusStateProvider.notifier)
              .openSystemSettings(),
        ),
        _LinkTile(
          title: 'フィードバックを送る',
          icon: Icons.messenger_rounded,
          onTap: () => launchUrlSafely(appLinks.feedbackFormUrl),
        ),
        _LinkTile(
          title: '開発者',
          icon: Icons.person,
          onTap: () => const DevelopersRouteData().push<void>(context),
        ),
        _LinkTile(
          title: 'アプリの使い方',
          icon: Icons.assignment,
          onTap: () => const SettingOnboardingRouteData().push<void>(context),
        ),
        _LinkTile(
          title: '利用規約',
          icon: Icons.verified_user,
          onTap: () => launchUrlSafely(appLinks.termsOfServiceUrl),
        ),
        _LinkTile(
          title: 'プライバシーポリシー',
          icon: Icons.admin_panel_settings,
          onTap: () => launchUrlSafely(appLinks.privacyPolicyUrl),
        ),
        _LinkTile(
          title: 'ライセンス',
          icon: Icons.info,
          onTap: () => const SettingsLicenseRouteData().push<void>(context),
        ),
      ],
    );
  }
}

final class _LinkTile extends StatelessWidget {
  const new({required this.title, required this.icon, required this.onTap});

  final String title;
  final IconData icon;
  final Future<Object?> Function() onTap;

  @override
  Widget build(BuildContext context) {
    return DottoListTile(
      firstLine: Text(title),
      leading: Icon(icon),
      trailing: const DottoListTileTrailing.chevron(),
      onTap: () async => await onTap(),
    );
  }
}
