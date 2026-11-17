import 'package:dotto/presentation/announcement/announcement_detail_screen.dart';
import 'package:dotto/presentation/announcement/announcement_screen.dart';
import 'package:dotto/presentation/common/onboarding/onboarding_screen.dart';
import 'package:dotto/presentation/debug/debug_screen.dart';
import 'package:dotto/presentation/github_contributor/github_contributor_screen.dart';
import 'package:dotto/presentation/setting/settings_license_screen.dart';
import 'package:dotto/presentation/setting/settings_screen.dart';
import 'package:dotto/router/routes/app_routes.dart';
import 'package:dotto_design_system/component/list_detail.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

/// 設定の項目一覧と各項目の画面を、幅に応じて左右に並べる。
final class SettingListDetailShellRouteData extends ShellRouteData {
  const new();

  @override
  Widget builder(BuildContext context, GoRouterState state, Widget navigator) {
    return DottoListDetail(list: const SettingsScreen(), detail: navigator);
  }
}

final class SettingsRouteData extends GoRouteData with $SettingsRouteData {
  const new();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const DottoListDetailRoot(
      placeholder: DottoListDetailPlaceholder(
        icon: Icons.settings,
        message: '項目を選択してください',
      ),
      child: SettingsScreen(),
    );
  }
}

final class AnnouncementsRouteData extends GoRouteData
    with $AnnouncementsRouteData {
  const new();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const AnnouncementScreen();
  }
}

final class AnnouncementDetailRouteData extends GoRouteData
    with $AnnouncementDetailRouteData {
  const new({required this.id});

  final String id;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return AnnouncementDetailScreen(id: id);
  }
}

final class DevelopersRouteData extends GoRouteData with $DevelopersRouteData {
  const new();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const GitHubContributorScreen();
  }
}

final class SettingOnboardingRouteData extends GoRouteData
    with $SettingOnboardingRouteData {
  const new();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    // 一覧と詳細を並べると設定タブの中に ShellRoute が入れ子になり、
    // pop の対象がブランチ側の Navigator になって閉じられないため、
    // 設定の一覧へ明示的に戻す。
    return OnboardingScreen(
      onDismissed: () => const SettingsRouteData().go(context),
    );
  }
}

final class SettingsLicenseRouteData extends GoRouteData
    with $SettingsLicenseRouteData {
  const new();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const SettingsLicenseScreen();
  }
}

final class DebugRouteData extends GoRouteData with $DebugRouteData {
  const new();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const DebugScreen();
  }
}
