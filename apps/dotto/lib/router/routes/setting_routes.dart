import 'package:dotto/feature/announcement/announcement_detail_screen.dart';
import 'package:dotto/feature/announcement/announcement_screen.dart';
import 'package:dotto/feature/debug/debug_screen.dart';
import 'package:dotto/feature/github_contributor/github_contributor_screen.dart';
import 'package:dotto/feature/onboarding/onboarding_screen.dart';
import 'package:dotto/feature/setting/settings.dart';
import 'package:dotto/feature/setting/widget/license.dart';
import 'package:dotto/router/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final class SettingsRouteData extends GoRouteData with $SettingsRouteData {
  const SettingsRouteData();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const SettingsScreen();
  }
}

final class AnnouncementsRouteData extends GoRouteData
    with $AnnouncementsRouteData {
  const AnnouncementsRouteData();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const AnnouncementScreen();
  }
}

final class AnnouncementDetailRouteData extends GoRouteData
    with $AnnouncementDetailRouteData {
  const AnnouncementDetailRouteData({required this.id});

  final String id;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return AnnouncementDetailScreen(id: id);
  }
}

final class DevelopersRouteData extends GoRouteData with $DevelopersRouteData {
  const DevelopersRouteData();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const GitHubContributorScreen();
  }
}

final class SettingOnboardingRouteData extends GoRouteData
    with $SettingOnboardingRouteData {
  const SettingOnboardingRouteData();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return OnboardingScreen(onDismissed: () => context.pop());
  }
}

final class SettingsLicenseRouteData extends GoRouteData
    with $SettingsLicenseRouteData {
  const SettingsLicenseRouteData();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const SettingsLicenseScreen();
  }
}

final class DebugRouteData extends GoRouteData with $DebugRouteData {
  const DebugRouteData();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const DebugScreen();
  }
}
