import 'package:dotto/domain/tab_item.dart';
import 'package:dotto/feature/announcement/announcement_screen.dart';
import 'package:dotto/feature/bus/bus_screen.dart';
import 'package:dotto/feature/bus/bus_stop_select.dart';
import 'package:dotto/feature/bus/bus_timetable.dart';
import 'package:dotto/feature/course/course_cancellation_screen.dart';
import 'package:dotto/feature/course/course_customize_screen.dart';
import 'package:dotto/feature/course/course_registration_screen.dart';
import 'package:dotto/feature/course/course_screen.dart';
import 'package:dotto/feature/debug/debug_screen.dart';
import 'package:dotto/feature/funch/funch.dart';
import 'package:dotto/feature/github_contributor/github_contributor_screen.dart';
import 'package:dotto/feature/map/map_screen.dart';
import 'package:dotto/feature/onboarding/onboarding_screen.dart';
import 'package:dotto/feature/root/root_screen.dart';
import 'package:dotto/feature/setting/settings.dart';
import 'package:dotto/feature/setting/widget/license.dart';
import 'package:dotto/feature/subject/search_subject_screen.dart';
import 'package:dotto/feature/subject/subject_detail_screen.dart';
import 'package:dotto/repository/model/bus_trip.dart';
import 'package:dotto/widget/cloudflare_pdf_viewer.dart';
import 'package:dotto/widget/web_pdf_viewer.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

part 'app_routes.g.dart';

@TypedStatefulShellRoute<RootShellRouteData>(
  branches: <TypedStatefulShellBranch<StatefulShellBranchData>>[
    TypedStatefulShellBranch<CourseShellBranchData>(
      routes: <TypedRoute<RouteData>>[
        TypedGoRoute<CourseRouteData>(
          path: '/course',
          name: '/course',
          routes: <TypedRoute<RouteData>>[
            TypedGoRoute<CourseSubjectsRouteData>(
              path: 'subjects',
              name: '/course/subjects',
            ),
            TypedGoRoute<CourseSubjectDetailRouteData>(
              path: 'subjects/:id',
              name: '/course/subjects/:id',
            ),
            TypedGoRoute<CourseCancellationRouteData>(
              path: 'irregular_classes',
              name: '/course/irregular_classes',
            ),
            TypedGoRoute<CourseRegistrationRouteData>(
              path: 'registration',
              name: '/course/registration',
            ),
            TypedGoRoute<CourseCustomizeRouteData>(
              path: 'preferences',
              name: '/course/preferences',
            ),
            TypedGoRoute<CourseWebPdfViewerRouteData>(
              path: 'web_pdf_viewer',
              name: '/course/web_pdf_viewer',
            ),
          ],
        ),
      ],
    ),
    TypedStatefulShellBranch<FunchShellBranchData>(
      routes: <TypedRoute<RouteData>>[
        TypedGoRoute<FunchRouteData>(path: '/funch', name: '/funch'),
      ],
    ),
    TypedStatefulShellBranch<MapShellBranchData>(
      routes: <TypedRoute<RouteData>>[
        TypedGoRoute<MapRouteData>(path: '/map', name: '/map'),
      ],
    ),
    TypedStatefulShellBranch<BusShellBranchData>(
      routes: <TypedRoute<RouteData>>[
        TypedGoRoute<BusRouteData>(
          path: '/bus',
          name: '/bus',
          routes: <TypedRoute<RouteData>>[
            TypedGoRoute<BusStopSelectRouteData>(
              path: 'select_stop',
              name: '/bus/select_stop',
            ),
            TypedGoRoute<BusTimetableRouteData>(
              path: 'timetable',
              name: '/bus/timetable',
            ),
          ],
        ),
      ],
    ),
    TypedStatefulShellBranch<SettingShellBranchData>(
      routes: <TypedRoute<RouteData>>[
        TypedGoRoute<SettingsRouteData>(
          path: '/setting',
          name: '/setting',
          routes: <TypedRoute<RouteData>>[
            TypedGoRoute<AnnouncementsRouteData>(
              path: 'announcements',
              name: '/setting/announcements',
            ),
            TypedGoRoute<DevelopersRouteData>(
              path: 'developers',
              name: '/setting/developers',
            ),
            TypedGoRoute<SettingOnboardingRouteData>(
              path: 'onboarding',
              name: '/setting/onboarding',
            ),
            TypedGoRoute<SettingsLicenseRouteData>(
              path: 'licenses',
              name: '/setting/licenses',
            ),
            TypedGoRoute<DebugRouteData>(path: 'debug', name: '/setting/debug'),
          ],
        ),
      ],
    ),
    TypedStatefulShellBranch<SubjectShellBranchData>(
      routes: <TypedRoute<RouteData>>[
        TypedGoRoute<SubjectsRouteData>(
          path: '/subjects',
          name: '/subjects',
          routes: <TypedRoute<RouteData>>[
            TypedGoRoute<SubjectDetailRouteData>(
              path: ':id',
              name: '/subjects/:id',
              routes: <TypedRoute<RouteData>>[
                TypedGoRoute<SubjectPastExamPdfRouteData>(
                  path: 'past_exams',
                  name: '/subjects/:id/past_exams',
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  ],
)
final class RootShellRouteData extends StatefulShellRouteData {
  const RootShellRouteData();

  @override
  Widget builder(
    BuildContext context,
    GoRouterState state,
    StatefulNavigationShell navigationShell,
  ) {
    return RootScreen(navigationShell: navigationShell);
  }
}

final class CourseShellBranchData extends StatefulShellBranchData {
  const CourseShellBranchData();
}

final class FunchShellBranchData extends StatefulShellBranchData {
  const FunchShellBranchData();
}

final class MapShellBranchData extends StatefulShellBranchData {
  const MapShellBranchData();
}

final class BusShellBranchData extends StatefulShellBranchData {
  const BusShellBranchData();
}

final class SettingShellBranchData extends StatefulShellBranchData {
  const SettingShellBranchData();
}

final class SubjectShellBranchData extends StatefulShellBranchData {
  const SubjectShellBranchData();
}

final class CourseRouteData extends GoRouteData with $CourseRouteData {
  const CourseRouteData();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const CourseScreen();
  }
}

final class CourseSubjectsRouteData extends GoRouteData
    with $CourseSubjectsRouteData {
  const CourseSubjectsRouteData();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const SearchSubjectScreen();
  }
}

final class CourseSubjectDetailRouteData extends GoRouteData
    with $CourseSubjectDetailRouteData {
  const CourseSubjectDetailRouteData({required this.id});

  final String id;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return SubjectDetailScreen(id: id);
  }
}

final class CourseCancellationRouteData extends GoRouteData
    with $CourseCancellationRouteData {
  const CourseCancellationRouteData();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const CourseCancellationScreen();
  }
}

final class CourseRegistrationRouteData extends GoRouteData
    with $CourseRegistrationRouteData {
  const CourseRegistrationRouteData();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const CourseRegistrationScreen();
  }
}

final class CourseCustomizeRouteData extends GoRouteData
    with $CourseCustomizeRouteData {
  const CourseCustomizeRouteData();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const CourseCustomizeScreen();
  }
}

final class CourseWebPdfViewerRouteData extends GoRouteData
    with $CourseWebPdfViewerRouteData {
  const CourseWebPdfViewerRouteData({required this.url, this.filename});

  final String url;
  final String? filename;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return WebPdfViewer(url: url, filename: filename);
  }
}

final class FunchRouteData extends GoRouteData with $FunchRouteData {
  const FunchRouteData();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const FunchScreen();
  }
}

final class MapRouteData extends GoRouteData with $MapRouteData {
  const MapRouteData();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return MapScreen(
      onGoToSettingButtonTapped: () => const SettingsRouteData().go(context),
    );
  }
}

final class BusRouteData extends GoRouteData with $BusRouteData {
  const BusRouteData();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const BusScreen();
  }
}

final class BusStopSelectRouteData extends GoRouteData
    with $BusStopSelectRouteData {
  const BusStopSelectRouteData();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const BusStopSelectScreen();
  }
}

final class BusTimetableRouteData extends GoRouteData
    with $BusTimetableRouteData {
  const BusTimetableRouteData({this.route, this.$extra});

  final String? route;
  final BusTrip? $extra;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    final busTrip = $extra;
    if (busTrip == null) {
      return _MissingRouteExtraScreen(title: route ?? 'バス時刻表');
    }
    return BusTimetableScreen(busTrip);
  }
}

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

final class SubjectsRouteData extends GoRouteData with $SubjectsRouteData {
  const SubjectsRouteData();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const SearchSubjectScreen();
  }
}

final class SubjectDetailRouteData extends GoRouteData
    with $SubjectDetailRouteData {
  const SubjectDetailRouteData({required this.id});

  final String id;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return SubjectDetailScreen(id: id);
  }
}

final class SubjectPastExamPdfRouteData extends GoRouteData
    with $SubjectPastExamPdfRouteData {
  const SubjectPastExamPdfRouteData({
    required this.id,
    required this.url,
    this.filename,
  });

  final String id;
  final String url;
  final String? filename;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return CloudflarePdfViewer(url: url, filename: filename);
  }
}

final class _MissingRouteExtraScreen extends StatelessWidget {
  const _MissingRouteExtraScreen({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: const Center(child: Text('この画面を開くための情報が不足しています。')),
    );
  }
}

int branchIndexForTab(TabItem tab) => switch (tab) {
  TabItem.course => 0,
  TabItem.funch => 1,
  TabItem.map => 2,
  TabItem.bus => 3,
  TabItem.setting => 4,
  TabItem.subject => 5,
};

TabItem tabForBranchIndex(int index) => switch (index) {
  0 => TabItem.course,
  1 => TabItem.funch,
  2 => TabItem.map,
  3 => TabItem.bus,
  4 => TabItem.setting,
  5 => TabItem.subject,
  _ => TabItem.course,
};
