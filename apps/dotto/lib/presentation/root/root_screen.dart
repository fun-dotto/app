import 'dart:io';

import 'package:dotto/application/open_external_link_use_case.dart';
import 'package:dotto/application/record_notification_prompt_use_case.dart';
import 'package:dotto/application/report_error_use_case.dart';
import 'package:dotto/application/should_prompt_notification_use_case.dart';
import 'package:dotto/application/synchronize_push_token_use_case.dart';
import 'package:dotto/domain/entity/flags.dart';
import 'package:dotto/domain/entity/notification_alert_status.dart';
import 'package:dotto/l10n/app_localizations.dart';
import 'package:dotto/l10n/app_localizations_ja.dart';
import 'package:dotto/presentation/common/auth_account_state.dart';
import 'package:dotto/presentation/common/error_view.dart';
import 'package:dotto/presentation/common/loading_view.dart';
import 'package:dotto/presentation/common/notification_alert_status_state.dart';
import 'package:dotto/presentation/common/onboarding/onboarding_screen.dart';
import 'package:dotto/presentation/common/tab_item.dart';
import 'package:dotto/presentation/common/use_flag.dart';
import 'package:dotto/presentation/root/invalid_app_version_screen.dart';
import 'package:dotto/presentation/root/push_token_state.dart';
import 'package:dotto/presentation/root/root_app_tutorial_state.dart';
import 'package:dotto/presentation/root/root_app_version_state.dart';
import 'package:dotto/presentation/root/root_initialization_state.dart';
import 'package:dotto/router/routes/app_routes.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';

final class RootScreen extends HookConsumerWidget {
  const new({required this.navigationShell, super.key});

  final StatefulNavigationShell navigationShell;

  List<TabItem> _activeTabs({required bool isFunchEnabled}) {
    final baseTabs = TabItem.v2;
    if (isFunchEnabled) {
      return baseTabs;
    }
    return baseTabs
        .map((tab) => tab == TabItem.funch ? TabItem.subject : tab)
        .toList();
  }

  void _scheduleAlertsIfNeeded(
    BuildContext context,
    WidgetRef ref,
    ValueNotifier<bool> hasShownUpdateAlert,
    ValueNotifier<bool> hasShownNotificationAlert,
    VoidCallback onCompleted,
  ) {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      try {
        // 同一フレーム内で複数のコールバックが積まれたときに重複表示しない
        // よう、コールバック実行時点の最新状態を再取得して判定する。
        if (!context.mounted) return;
        final latest = ref.read(rootAppVersionStateProvider).asData?.value;
        if (latest == null) return;

        final alerts = (
          hasShownUpdateAlert: hasShownUpdateAlert.value,
          hasShownNotificationAlert: hasShownNotificationAlert.value,
        );
        if (!latest.isLatestAppVersion && !alerts.hasShownUpdateAlert) {
          hasShownUpdateAlert.value = true;
          await showDialog<void>(
            context: context,
            builder: (context) => _UpdateAlertDialog(
              appStorePageUrl: latest.appStorePageUrl,
              currentAppVersion: latest.currentAppVersion,
              latestAppVersion: latest.latestAppVersion,
            ),
          );
        }

        if (!context.mounted) return;
        if (hasShownNotificationAlert.value) {
          return;
        }

        try {
          final status = await ref.read(
            notificationAlertStatusStateProvider.future,
          );
          if (!context.mounted) return;
          if (hasShownNotificationAlert.value) {
            return;
          }
          if (status.shouldPromptUser &&
              await ref.read(shouldPromptNotificationUseCaseProvider)()) {
            if (!context.mounted) return;
            if (hasShownNotificationAlert.value) return;
            hasShownNotificationAlert.value = true;
            await ref.read(recordNotificationPromptUseCaseProvider)();
            if (!context.mounted) return;
            await showDialog<void>(
              context: context,
              builder: (context) => _NotificationAlertDialog(status: status),
            );
          } else {
            hasShownNotificationAlert.value = true;
          }
        } on Exception catch (error, stackTrace) {
          await ref.read(reportErrorUseCaseProvider)(
            error,
            stackTrace,
            reason: 'notificationAlertStatusStateProvider read failed',
          );
          hasShownNotificationAlert.value = true;
        }
      } finally {
        onCompleted();
      }
    });
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useEffect(() {
      final listener = AppLifecycleListener(
        onResume: () => ref.invalidate(notificationAlertStatusStateProvider),
      );
      return listener.dispose;
    }, const []);

    final isSchedulingAlerts = useRef(false);
    final hasShownUpdateAlert = useState(false);
    final hasShownNotificationAlert = useState(false);
    ref
      ..listen(authAccountStateProvider, (prev, next) async {
        final previousAccount = prev?.asData?.value;
        final account = next.asData?.value;
        if (account == null || previousAccount?.id == account.id) return;
        try {
          await ref.read(synchronizePushTokenUseCaseProvider)();
        } on Exception catch (error, stack) {
          await ref.read(reportErrorUseCaseProvider)(
            error,
            stack,
            reason: '通知トークンの同期に失敗',
          );
        }
      })
      ..listen(pushTokenStateProvider, (_, next) async {
        if (next case AsyncError(:final error, :final stackTrace)) {
          await ref.read(reportErrorUseCaseProvider)(
            error,
            stackTrace,
            reason: '通知トークンの更新監視に失敗',
          );
          return;
        }
        if (ref.read(authAccountStateProvider).asData?.value == null) return;
        if (next case AsyncData(:final value)) {
          try {
            await ref.read(synchronizePushTokenUseCaseProvider)(value);
          } on Exception catch (error, stack) {
            await ref.read(reportErrorUseCaseProvider)(
              error,
              stack,
              reason: '通知トークンの更新に失敗',
            );
          }
        }
      });

    final initialization = ref.watch(rootInitializationStateProvider);
    final appTutorial = ref.watch(rootAppTutorialStateProvider);
    final appVersion = ref.watch(rootAppVersionStateProvider);
    final isFunchEnabled = useFlag(Flags.funch);
    final activeTabs = _activeTabs(isFunchEnabled: isFunchEnabled);

    if (initialization.hasError ||
        appTutorial.hasError ||
        appVersion.hasError) {
      return const Scaffold(body: ErrorView());
    }
    if (initialization.isLoading ||
        appTutorial.isLoading ||
        appVersion.isLoading) {
      return const Scaffold(body: LoadingView());
    }
    final hasShownAppTutorial = appTutorial.asData?.value;
    final currentVersion = appVersion.asData?.value;
    if (hasShownAppTutorial == null || currentVersion == null) {
      return const Scaffold(resizeToAvoidBottomInset: false);
    }
    if (!hasShownAppTutorial) {
      return OnboardingScreen(
        onDismissed: ref
            .read(rootAppTutorialStateProvider.notifier)
            .onAppTutorialDismissed,
      );
    }
    if (!currentVersion.isValidAppVersion) {
      return InvalidAppVersionScreen(
        appStorePageUrl: currentVersion.appStorePageUrl,
        currentAppVersion: currentVersion.currentAppVersion,
        latestAppVersion: currentVersion.latestAppVersion,
      );
    }

    if (!isSchedulingAlerts.value) {
      isSchedulingAlerts.value = true;
      _scheduleAlertsIfNeeded(
        context,
        ref,
        hasShownUpdateAlert,
        hasShownNotificationAlert,
        () => isSchedulingAlerts.value = false,
      );
    }

    final selectedTab = tabForBranchIndex(navigationShell.currentIndex);
    final selectedIndex = activeTabs.indexOf(selectedTab);
    final navigationBarSelectedIndex = selectedIndex < 0 ? 0 : selectedIndex;

    return PopScope(
      canPop: Platform.isIOS,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;
        final router = GoRouter.of(context);
        if (router.canPop()) {
          router.pop();
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: navigationShell,
        bottomNavigationBar: NavigationBar(
          backgroundColor: switch (appFlavor) {
            'dev' => Colors.blue.withValues(alpha: 0.15),
            'stg' => Colors.orange.withValues(alpha: 0.15),
            _ => null,
          },
          onDestinationSelected: (index) {
            final tab = activeTabs[index];
            final branchIndex = branchIndexForTab(tab);
            navigationShell.goBranch(
              branchIndex,
              initialLocation: branchIndex == navigationShell.currentIndex,
            );
          },
          selectedIndex: navigationBarSelectedIndex,
          destinations: activeTabs.map((tab) {
            return NavigationDestination(
              selectedIcon: Icon(tab.selectedIcon),
              icon: Icon(tab.icon),
              label: tab.label,
            );
          }).toList(),
        ),
      ),
    );
  }
}

final class _UpdateAlertDialog extends HookConsumerWidget {
  const new({
    required this.appStorePageUrl,
    required this.currentAppVersion,
    required this.latestAppVersion,
  });
  final String appStorePageUrl;
  final String currentAppVersion;
  final String latestAppVersion;
  @override
  Widget build(BuildContext context, WidgetRef ref) => AlertDialog(
    title: Text(
      (AppLocalizations.of(context) ?? AppLocalizationsJa()).rootUpdateRequired,
    ),
    content: Text(
      (AppLocalizations.of(context) ?? AppLocalizationsJa())
          .rootVersionComparison(currentAppVersion, latestAppVersion),
    ),
    actions: [
      TextButton(
        onPressed: () => Navigator.of(context).pop(),
        child: Text(
          (AppLocalizations.of(context) ?? AppLocalizationsJa()).rootLater,
        ),
      ),
      TextButton(
        onPressed: () => ref.read(openExternalLinkUseCaseProvider)(
          appStorePageUrl,
          shouldOpenExternally: true,
        ),
        child: Text(
          (AppLocalizations.of(context) ?? AppLocalizationsJa()).rootUpdateNow,
        ),
      ),
    ],
  );
}

final class _NotificationAlertDialog extends HookConsumerWidget {
  const new({required this.status});
  final NotificationAlertStatus status;
  @override
  Widget build(BuildContext context, WidgetRef ref) => AlertDialog(
    title: Text(
      (AppLocalizations.of(context) ?? AppLocalizationsJa())
          .rootEnableNotifications,
    ),
    content: Text(switch (status) {
      NotificationAlertStatus.denied =>
        (AppLocalizations.of(context) ?? AppLocalizationsJa())
            .rootNotificationDenied,
      NotificationAlertStatus.provisional =>
        (AppLocalizations.of(context) ?? AppLocalizationsJa())
            .rootNotificationProvisional,
      NotificationAlertStatus.alertDisabled =>
        (AppLocalizations.of(context) ?? AppLocalizationsJa())
            .rootNotificationAlertDisabled,
      NotificationAlertStatus.enabled ||
      NotificationAlertStatus.notDetermined => '',
    }),
    actions: [
      TextButton(
        onPressed: () => Navigator.of(context).pop(),
        child: Text(
          (AppLocalizations.of(context) ?? AppLocalizationsJa()).rootLater,
        ),
      ),
      TextButton(
        onPressed: () async {
          Navigator.of(context).pop();
          await ref
              .read(notificationAlertStatusStateProvider.notifier)
              .openSystemSettings();
        },
        child: Text(
          (AppLocalizations.of(context) ?? AppLocalizationsJa())
              .rootOpenSettings,
        ),
      ),
    ],
  );
}
