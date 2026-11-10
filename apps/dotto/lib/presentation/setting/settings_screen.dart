import 'dart:async';

import 'package:dotto/application/open_external_link_use_case.dart';
import 'package:dotto/domain/entity/dotto_user.dart';
import 'package:dotto/extension/edge_insets_extension.dart';
import 'package:dotto/l10n/app_localizations.dart';
import 'package:dotto/presentation/common/notification_alert_status_label.dart';
import 'package:dotto/presentation/common/notification_alert_status_state.dart';
import 'package:dotto/presentation/common/use_localization.dart';
import 'package:dotto/presentation/common/user_state.dart';
import 'package:dotto/presentation/setting/app_links_state.dart';
import 'package:dotto/presentation/setting/app_version_footer.dart';
import 'package:dotto/presentation/setting/user_info_tile.dart';
import 'package:dotto/presentation/setting/user_profile_section.dart';
import 'package:dotto/router/routes/setting_routes.dart';
import 'package:dotto_design_system/component/button.dart';
import 'package:dotto_design_system/component/dialog.dart';
import 'package:dotto_design_system/component/dotto_app_bar.dart';
import 'package:dotto_design_system/component/list_section.dart';
import 'package:dotto_design_system/component/list_tile.dart';
import 'package:dotto_design_system/style/semantic_color.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';

final class SettingsScreen extends HookConsumerWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = useLocalization();
    final user = ref.watch(userStateProvider);

    ref.listen(userStateProvider, (previous, next) {
      final wasSignedOut =
          previous?.value == null && !(previous?.hasError ?? false);
      if (wasSignedOut && next.hasError) {
        unawaited(_showSignInErrorDialog(context, l10n));
      }
    });

    return Scaffold(
      appBar: DottoAppBar(
        title: Text(
          l10n.settingsTitle,
          style: Theme.of(context).textTheme.titleLarge
              ?.copyWith(color: SemanticColor.light.accentPrimary),
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16).withBottomBarInset(context),
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

  Future<void> _showSignInErrorDialog(
    BuildContext context,
    AppLocalizations l10n,
  ) {
    return showDialog<void>(
      context: context,
      builder: (dialogContext) => DottoDialog(
        type: .alert,
        title: l10n.settingsSignInFailedTitle,
        message: l10n.settingsSignInFailedMessage,
        actionButtons: [
          DottoButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: Text(l10n.settingsOk),
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
    final l10n = useLocalization();
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
                l10n,
                onConfirmed: () => unawaited(notifier.signOut()),
              ),
            ),
    );
  }

  Future<void> _showSignOutConfirmDialog(
    BuildContext context,
    AppLocalizations l10n, {
    required VoidCallback onConfirmed,
  }) {
    return showDialog<void>(
      context: context,
      builder: (dialogContext) => DottoDialog(
        type: .plain,
        title: l10n.settingsSignOutConfirmTitle,
        message: '',
        actionButtons: [
          DottoButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            type: .outlined,
            child: Text(l10n.settingsCancel),
          ),
          DottoButton(
            onPressed: () {
              Navigator.of(dialogContext).pop();
              onConfirmed();
            },
            child: Text(l10n.settingsSignOut),
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
    final l10n = useLocalization();
    final appLinks = ref.watch(appLinksStateProvider);
    final notificationStatus = ref.watch(notificationAlertStatusStateProvider);

    return DottoListSection(
      header: Text(l10n.settingsAboutApp),
      footer: const AppVersionFooter(),
      children: [
        _LinkTile(
          title: l10n.settingsAnnouncements,
          icon: Icons.notifications,
          onTap: () => const AnnouncementsRouteData().push<void>(context),
        ),
        DottoListTile(
          firstLine: Text(l10n.settingsNotifications),
          leading: const Icon(Icons.notifications_active),
          secondLine: Text(
            notificationStatus.value?.localizedLabel(l10n) ??
                l10n.settingsNotificationChecking,
          ),
          trailing: const DottoListTileTrailing.chevron(),
          onTap: () => ref
              .read(notificationAlertStatusStateProvider.notifier)
              .openSystemSettings(),
        ),
        _LinkTile(
          title: l10n.settingsSendFeedback,
          icon: Icons.messenger_rounded,
          onTap: () => ref.read(openExternalLinkUseCaseProvider)(
            appLinks.feedbackFormUrl,
          ),
        ),
        _LinkTile(
          title: l10n.settingsDevelopers,
          icon: Icons.person,
          onTap: () => const DevelopersRouteData().push<void>(context),
        ),
        _LinkTile(
          title: l10n.settingsHowToUse,
          icon: Icons.assignment,
          onTap: () => const SettingOnboardingRouteData().push<void>(context),
        ),
        _LinkTile(
          title: l10n.settingsTermsOfService,
          icon: Icons.verified_user,
          onTap: () => ref.read(openExternalLinkUseCaseProvider)(
            appLinks.termsOfServiceUrl,
          ),
        ),
        _LinkTile(
          title: l10n.settingsPrivacyPolicy,
          icon: Icons.admin_panel_settings,
          onTap: () => ref.read(openExternalLinkUseCaseProvider)(
            appLinks.privacyPolicyUrl,
          ),
        ),
        _LinkTile(
          title: l10n.settingsLicenses,
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
