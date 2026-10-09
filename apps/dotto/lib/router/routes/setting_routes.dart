import 'package:dotto/presentation/announcement/announcement_detail_screen.dart';
import 'package:dotto/presentation/announcement/announcement_screen.dart';
import 'package:dotto/presentation/common/onboarding/onboarding_screen.dart';
import 'package:dotto/presentation/debug/debug_screen.dart';
import 'package:dotto/presentation/github_contributor/github_contributor_screen.dart';
import 'package:dotto/presentation/setting/settings_license_screen.dart';
import 'package:dotto/presentation/setting/settings_screen.dart';
import 'package:dotto/router/routes/app_routes.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

final class SettingsRouteData extends GoRouteData with $SettingsRouteData {
  const new();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const SettingsScreen();
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
    return OnboardingScreen(onDismissed: () => context.pop());
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
