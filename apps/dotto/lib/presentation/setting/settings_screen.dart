import 'dart:async';

import 'package:dotto/application/open_external_link_use_case.dart';
import 'package:dotto/domain/entity/domain_error.dart';
import 'package:dotto/presentation/common/notification_alert_status_state.dart';
import 'package:dotto/presentation/common/user_state.dart';
import 'package:dotto/presentation/setting/app_build_info_state.dart';
import 'package:dotto/presentation/setting/app_links_state.dart';
import 'package:dotto/presentation/setting/settings_content.dart';
import 'package:dotto/router/routes/setting_routes.dart';
import 'package:dotto_design_system/component/button.dart';
import 'package:dotto_design_system/component/dialog.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';

final class SettingsScreen extends HookConsumerWidget {
  const new({super.key});

  static const _debuggableFlavors = {'prd', 'stg', 'dev'};

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userStateProvider);
    final userNotifier = ref.read(userStateProvider.notifier);
    final appLinks = ref.watch(appLinksStateProvider);
    final notificationStatus = ref.watch(notificationAlertStatusStateProvider);
    final buildInfo = ref.watch(appBuildInfoStateProvider);
    final canOpenDebugScreen =
        kDebugMode || _debuggableFlavors.contains(appFlavor);

    ref.listen(userStateProvider, (previous, next) {
      final wasSignedOut =
          previous?.value == null && !(previous?.hasError ?? false);
      if (wasSignedOut && next.hasError) {
        unawaited(_showSignInErrorDialog(context));
      }
    });

    // 保存に失敗しても表示は元に戻るため、失敗したことだけを伝える
    Future<void> saveProfile(Future<void> Function() update) async {
      try {
        await update();
      } on DomainError {
        if (!context.mounted) return;
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('保存に失敗しました')));
      }
    }

    void openLink(String url) =>
        unawaited(ref.read(openExternalLinkUseCaseProvider)(url));

    return SettingsContent(
      user: user.value,
      isUserLoading: user.isLoading,
      notificationStatusLabel: notificationStatus.value?.label,
      versionLabel: switch (buildInfo) {
        AsyncData(:final value) => '${value.version} (${value.buildNumber})',
        _ => '',
      },
      onAccountTap: user.value == null
          ? () => unawaited(userNotifier.signIn())
          : () => unawaited(
              _showSignOutConfirmDialog(
                context,
                onConfirmed: () => unawaited(userNotifier.signOut()),
              ),
            ),
      onGradeSelected: (grade) =>
          saveProfile(() => userNotifier.setGrade(grade)),
      onCourseSelected: (course) =>
          saveProfile(() => userNotifier.setCourse(course)),
      onClassSelected: (class_) =>
          saveProfile(() => userNotifier.setClass(class_)),
      onAnnouncementsTap: () =>
          unawaited(const AnnouncementsRouteData().push<void>(context)),
      onNotificationTap: () => unawaited(
        ref
            .read(notificationAlertStatusStateProvider.notifier)
            .openSystemSettings(),
      ),
      onFeedbackTap: () => openLink(appLinks.feedbackFormUrl),
      onDevelopersTap: () =>
          unawaited(const DevelopersRouteData().push<void>(context)),
      onOnboardingTap: () =>
          unawaited(const SettingOnboardingRouteData().push<void>(context)),
      onTermsOfServiceTap: () => openLink(appLinks.termsOfServiceUrl),
      onPrivacyPolicyTap: () => openLink(appLinks.privacyPolicyUrl),
      onLicenseTap: () =>
          unawaited(const SettingsLicenseRouteData().push<void>(context)),
      onVersionTap: canOpenDebugScreen
          ? () => unawaited(const DebugRouteData().push<void>(context))
          : null,
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
