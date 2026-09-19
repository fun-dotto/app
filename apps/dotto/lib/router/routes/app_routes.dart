import 'package:dotto/domain/tab_item.dart';
import 'package:dotto/feature/root/root_screen.dart';
import 'package:dotto/router/routes/bus_routes.dart';
import 'package:dotto/router/routes/course_routes.dart';
import 'package:dotto/router/routes/funch_routes.dart';
import 'package:dotto/router/routes/map_routes.dart';
import 'package:dotto/router/routes/setting_routes.dart';
import 'package:dotto/router/routes/subject_routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

part 'app_routes.g.dart';

// Paths
//
// / → /course
//
// /course
// /course/preferences
// /course/personal-weekly-timetable
// /course/notice → /course/notice/cancellations
// /course/notice/cancellations
// /course/notice/makeups
// /course/notice/room-changes
// /course/subjects
// /course/subjects/:id → /course/subjects/:id/syllabus
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
// /subjects/:id → /subjects/:id/syllabus
// /subjects/:id/syllabus
// /subjects/:id/reviews
// /subjects/:id/reviews/new
// /subjects/:id/past-exams
// /subjects/:id/past-exams/:pastExamId
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
            TypedGoRoute<CourseNoticeRouteData>(
              path: 'notice',
              name: '/course/notice',
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
            ),
            TypedGoRoute<SubjectSyllabusRouteData>(
              path: ':id/syllabus',
              name: '/subjects/:id/syllabus',
            ),
            TypedGoRoute<SubjectReviewsRouteData>(
              path: ':id/reviews',
              name: '/subjects/:id/reviews',
              routes: <TypedRoute<RouteData>>[
                TypedGoRoute<SubjectReviewNewRouteData>(
                  path: 'new',
                  name: '/subjects/:id/reviews/new',
                ),
              ],
            ),
            TypedGoRoute<SubjectPastExamsRouteData>(
              path: ':id/past-exams',
              name: '/subjects/:id/past-exams',
              routes: <TypedRoute<RouteData>>[
                TypedGoRoute<SubjectPastExamRouteData>(
                  path: ':pastExamId',
                  name: '/subjects/:id/past-exams/:pastExamId',
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

/// タブとブランチの対応。上の `branches` に並べた順番と揃える。
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
