import 'dart:async';

import 'package:dotto/domain/tab_item.dart';
import 'package:dotto/feature/announcement/announcement_detail_screen.dart';
import 'package:dotto/feature/announcement/announcement_screen.dart';
import 'package:dotto/feature/bus/bus_screen.dart';
import 'package:dotto/feature/bus/bus_stop_select.dart';
import 'package:dotto/feature/bus/bus_trip_screen.dart';
import 'package:dotto/feature/course/course_cancellation_screen.dart';
import 'package:dotto/feature/course/course_customize_screen.dart';
import 'package:dotto/feature/course/course_document_screen.dart';
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
import 'package:dotto/feature/subject/subject_detail_past_exam_screen.dart';
import 'package:dotto/feature/subject/subject_detail_screen.dart';
import 'package:dotto/feature/subject/subject_review_new_screen.dart';
import 'package:dotto/widget/cloudflare_pdf_viewer.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

part 'app_routes.g.dart';

// アプリが持つパスの一覧。
//
// /course
// /course/preferences
// /course/personal-weekly-timetable
// /course/notice/cancellations
// /course/notice/makeups
// /course/notice/room-changes
// /course/subjects
// /course/subjects/:id → /course/subjects/:id/syllabus へリダイレクト
// /course/subjects/:id/syllabus
// /course/subjects/:id/reviews
// /course/subjects/:id/reviews/new
// /course/subjects/:id/past-exams
// /course/subjects/:id/past-exams/:pastExamId
// /course/calendars/:year
// /course/timetables/:year/spring
// /course/timetables/:year/fall
//
// /funch
//
// /map
// /map/rooms/:id
//
// /bus
// /bus/stop-selection
// /bus/trips/:id
//
// /setting
// /setting/announcements
// /setting/announcements/:id
// /setting/developers
// /setting/onboarding
// /setting/licenses
// /setting/debug
//
// 科目検索タブ（学食タブの代替として表示されるタブ）用のパス。
// /subjects
// /subjects/:id
// /subjects/:id/past_exams
@TypedStatefulShellRoute<RootShellRouteData>(
  branches: <TypedStatefulShellBranch<StatefulShellBranchData>>[
    TypedStatefulShellBranch<CourseShellBranchData>(
      routes: <TypedRoute<RouteData>>[
        TypedGoRoute<CourseRouteData>(
          path: '/course',
          name: '/course',
          routes: <TypedRoute<RouteData>>[
            TypedGoRoute<CourseCustomizeRouteData>(
              path: 'preferences',
              name: '/course/preferences',
            ),
            TypedGoRoute<CourseRegistrationRouteData>(
              path: 'personal-weekly-timetable',
              name: '/course/personal-weekly-timetable',
            ),
            TypedGoRoute<CourseNoticeCancellationsRouteData>(
              path: 'notice/cancellations',
              name: '/course/notice/cancellations',
            ),
            TypedGoRoute<CourseNoticeMakeupsRouteData>(
              path: 'notice/makeups',
              name: '/course/notice/makeups',
            ),
            TypedGoRoute<CourseNoticeRoomChangesRouteData>(
              path: 'notice/room-changes',
              name: '/course/notice/room-changes',
            ),
            TypedGoRoute<CourseSubjectsRouteData>(
              path: 'subjects',
              name: '/course/subjects',
            ),
            TypedGoRoute<CourseSubjectDetailRouteData>(
              path: 'subjects/:id',
              name: '/course/subjects/:id',
            ),
            TypedGoRoute<CourseSubjectSyllabusRouteData>(
              path: 'subjects/:id/syllabus',
              name: '/course/subjects/:id/syllabus',
            ),
            TypedGoRoute<CourseSubjectReviewsRouteData>(
              path: 'subjects/:id/reviews',
              name: '/course/subjects/:id/reviews',
              routes: <TypedRoute<RouteData>>[
                TypedGoRoute<CourseSubjectReviewNewRouteData>(
                  path: 'new',
                  name: '/course/subjects/:id/reviews/new',
                ),
              ],
            ),
            TypedGoRoute<CourseSubjectPastExamsRouteData>(
              path: 'subjects/:id/past-exams',
              name: '/course/subjects/:id/past-exams',
              routes: <TypedRoute<RouteData>>[
                TypedGoRoute<CourseSubjectPastExamRouteData>(
                  path: ':pastExamId',
                  name: '/course/subjects/:id/past-exams/:pastExamId',
                ),
              ],
            ),
            TypedGoRoute<CourseCalendarRouteData>(
              path: 'calendars/:year',
              name: '/course/calendars/:year',
            ),
            TypedGoRoute<CourseSpringTimetableRouteData>(
              path: 'timetables/:year/spring',
              name: '/course/timetables/:year/spring',
            ),
            TypedGoRoute<CourseFallTimetableRouteData>(
              path: 'timetables/:year/fall',
              name: '/course/timetables/:year/fall',
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
        // マップ画面自体が部屋の詳細を表示するため、/map の子ではなく
        // 同じブランチの別ルートとして定義し、マップを二重に積まない。
        TypedGoRoute<MapRoomRouteData>(
          path: '/map/rooms/:id',
          name: '/map/rooms/:id',
        ),
      ],
    ),
    TypedStatefulShellBranch<BusShellBranchData>(
      routes: <TypedRoute<RouteData>>[
        TypedGoRoute<BusRouteData>(
          path: '/bus',
          name: '/bus',
          routes: <TypedRoute<RouteData>>[
            TypedGoRoute<BusStopSelectRouteData>(
              path: 'stop-selection',
              name: '/bus/stop-selection',
            ),
            TypedGoRoute<BusTripRouteData>(
              path: 'trips/:id',
              name: '/bus/trips/:id',
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
              routes: <TypedRoute<RouteData>>[
                TypedGoRoute<AnnouncementDetailRouteData>(
                  path: ':id',
                  name: '/setting/announcements/:id',
                ),
              ],
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

final class CourseCustomizeRouteData extends GoRouteData
    with $CourseCustomizeRouteData {
  const CourseCustomizeRouteData();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const CourseCustomizeScreen();
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

final class CourseNoticeCancellationsRouteData extends GoRouteData
    with $CourseNoticeCancellationsRouteData {
  const CourseNoticeCancellationsRouteData();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const CourseCancellationScreen(
      initialTab: CourseNoticeTab.cancellations,
    );
  }
}

final class CourseNoticeMakeupsRouteData extends GoRouteData
    with $CourseNoticeMakeupsRouteData {
  const CourseNoticeMakeupsRouteData();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const CourseCancellationScreen(initialTab: CourseNoticeTab.makeups);
  }
}

final class CourseNoticeRoomChangesRouteData extends GoRouteData
    with $CourseNoticeRoomChangesRouteData {
  const CourseNoticeRoomChangesRouteData();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const CourseCancellationScreen(
      initialTab: CourseNoticeTab.roomChanges,
    );
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

/// 科目詳細のパスは常にタブ付きのパスへ寄せる。
final class CourseSubjectDetailRouteData extends GoRouteData
    with $CourseSubjectDetailRouteData {
  const CourseSubjectDetailRouteData({required this.id});

  final String id;

  @override
  FutureOr<String?> redirect(BuildContext context, GoRouterState state) {
    return CourseSubjectSyllabusRouteData(id: id).location;
  }
}

final class CourseSubjectSyllabusRouteData extends GoRouteData
    with $CourseSubjectSyllabusRouteData {
  const CourseSubjectSyllabusRouteData({required this.id});

  final String id;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return _courseSubjectDetail(
      context,
      id: id,
      tab: SubjectDetailTab.syllabus,
    );
  }
}

final class CourseSubjectReviewsRouteData extends GoRouteData
    with $CourseSubjectReviewsRouteData {
  const CourseSubjectReviewsRouteData({required this.id});

  final String id;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return _courseSubjectDetail(context, id: id, tab: SubjectDetailTab.reviews);
  }
}

final class CourseSubjectReviewNewRouteData extends GoRouteData
    with $CourseSubjectReviewNewRouteData {
  const CourseSubjectReviewNewRouteData({required this.id});

  final String id;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return SubjectReviewNewScreen(id: id);
  }
}

final class CourseSubjectPastExamsRouteData extends GoRouteData
    with $CourseSubjectPastExamsRouteData {
  const CourseSubjectPastExamsRouteData({required this.id});

  final String id;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return _courseSubjectDetail(
      context,
      id: id,
      tab: SubjectDetailTab.pastExams,
    );
  }
}

final class CourseSubjectPastExamRouteData extends GoRouteData
    with $CourseSubjectPastExamRouteData {
  const CourseSubjectPastExamRouteData({
    required this.id,
    required this.pastExamId,
  });

  final String id;

  /// 過去問PDFのオブジェクトキー。
  final String pastExamId;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return CloudflarePdfViewer(
      url: pastExamId,
      filename: pastExamFileName(pastExamId),
    );
  }
}

final class CourseCalendarRouteData extends GoRouteData
    with $CourseCalendarRouteData {
  const CourseCalendarRouteData({required this.year});

  final int year;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return CourseDocumentScreen(
      document: CourseDocument.officialCalendar,
      year: year,
    );
  }
}

final class CourseSpringTimetableRouteData extends GoRouteData
    with $CourseSpringTimetableRouteData {
  const CourseSpringTimetableRouteData({required this.year});

  final int year;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return CourseDocumentScreen(
      document: CourseDocument.springTimetable,
      year: year,
    );
  }
}

final class CourseFallTimetableRouteData extends GoRouteData
    with $CourseFallTimetableRouteData {
  const CourseFallTimetableRouteData({required this.year});

  final int year;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return CourseDocumentScreen(
      document: CourseDocument.fallTimetable,
      year: year,
    );
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

final class MapRoomRouteData extends GoRouteData with $MapRoomRouteData {
  const MapRoomRouteData({required this.id});

  final String id;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return MapScreen(
      focusedRoomId: id,
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

final class BusTripRouteData extends GoRouteData with $BusTripRouteData {
  const BusTripRouteData({required this.id});

  final String id;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BusTripScreen(id: id);
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
    return SubjectDetailScreen(
      id: id,
      initialTab: SubjectDetailTab.syllabus,
      onPastExamSelected: (objectKey) => unawaited(
        SubjectPastExamPdfRouteData(
          id: id,
          url: objectKey,
          filename: pastExamFileName(objectKey),
        ).push<void>(context),
      ),
    );
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

/// 講義タブの科目詳細を、指定したタブを開いた状態で構築する。
Widget _courseSubjectDetail(
  BuildContext context, {
  required String id,
  required SubjectDetailTab tab,
}) {
  return SubjectDetailScreen(
    id: id,
    initialTab: tab,
    onPastExamSelected: (objectKey) => unawaited(
      CourseSubjectPastExamRouteData(
        id: id,
        pastExamId: objectKey,
      ).push<void>(context),
    ),
  );
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
