// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_routes.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [$rootShellRouteData];

RouteBase get $rootShellRouteData => StatefulShellRouteData.$route(
  factory: $RootShellRouteDataExtension._fromState,
  branches: [
    StatefulShellBranchData.$branch(
      routes: [
        GoRouteData.$route(
          path: '/course',
          name: '/course',
          factory: $CourseRouteData._fromState,
          routes: [
            GoRouteData.$route(
              path: 'subjects',
              name: '/course/subjects',
              factory: $CourseSubjectsRouteData._fromState,
            ),
            GoRouteData.$route(
              path: 'subjects/:id',
              name: '/course/subjects/:id',
              factory: $CourseSubjectDetailRouteData._fromState,
            ),
            GoRouteData.$route(
              path: 'irregular_classes',
              name: '/course/irregular_classes',
              factory: $CourseCancellationRouteData._fromState,
            ),
            GoRouteData.$route(
              path: 'registration',
              name: '/course/registration',
              factory: $CourseRegistrationRouteData._fromState,
            ),
            GoRouteData.$route(
              path: 'preferences',
              name: '/course/preferences',
              factory: $CourseCustomizeRouteData._fromState,
            ),
            GoRouteData.$route(
              path: 'web_pdf_viewer',
              name: '/course/web_pdf_viewer',
              factory: $CourseWebPdfViewerRouteData._fromState,
            ),
          ],
        ),
      ],
    ),
    StatefulShellBranchData.$branch(
      routes: [
        GoRouteData.$route(
          path: '/funch',
          name: '/funch',
          factory: $FunchRouteData._fromState,
        ),
      ],
    ),
    StatefulShellBranchData.$branch(
      routes: [
        GoRouteData.$route(
          path: '/map',
          name: '/map',
          factory: $MapRouteData._fromState,
        ),
      ],
    ),
    StatefulShellBranchData.$branch(
      routes: [
        GoRouteData.$route(
          path: '/bus',
          name: '/bus',
          factory: $BusRouteData._fromState,
          routes: [
            GoRouteData.$route(
              path: 'select_stop',
              name: '/bus/select_stop',
              factory: $BusStopSelectRouteData._fromState,
            ),
            GoRouteData.$route(
              path: 'timetable',
              name: '/bus/timetable',
              factory: $BusTimetableRouteData._fromState,
            ),
          ],
        ),
      ],
    ),
    StatefulShellBranchData.$branch(
      routes: [
        GoRouteData.$route(
          path: '/setting',
          name: '/setting',
          factory: $SettingsRouteData._fromState,
          routes: [
            GoRouteData.$route(
              path: 'announcements',
              name: '/setting/announcements',
              factory: $AnnouncementsRouteData._fromState,
            ),
            GoRouteData.$route(
              path: 'developers',
              name: '/setting/developers',
              factory: $DevelopersRouteData._fromState,
            ),
            GoRouteData.$route(
              path: 'onboarding',
              name: '/setting/onboarding',
              factory: $SettingOnboardingRouteData._fromState,
            ),
            GoRouteData.$route(
              path: 'licenses',
              name: '/setting/licenses',
              factory: $SettingsLicenseRouteData._fromState,
            ),
            GoRouteData.$route(
              path: 'debug',
              name: '/setting/debug',
              factory: $DebugRouteData._fromState,
            ),
          ],
        ),
      ],
    ),
    StatefulShellBranchData.$branch(
      routes: [
        GoRouteData.$route(
          path: '/subjects',
          name: '/subjects',
          factory: $SubjectsRouteData._fromState,
          routes: [
            GoRouteData.$route(
              path: ':id',
              name: '/subjects/:id',
              factory: $SubjectDetailRouteData._fromState,
              routes: [
                GoRouteData.$route(
                  path: 'past_exams',
                  name: '/subjects/:id/past_exams',
                  factory: $SubjectPastExamPdfRouteData._fromState,
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  ],
);

extension $RootShellRouteDataExtension on RootShellRouteData {
  static RootShellRouteData _fromState(GoRouterState state) =>
      const RootShellRouteData();
}

mixin $CourseRouteData on GoRouteData {
  static CourseRouteData _fromState(GoRouterState state) =>
      const CourseRouteData();

  @override
  String get location => GoRouteData.$location('/course');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $CourseSubjectsRouteData on GoRouteData {
  static CourseSubjectsRouteData _fromState(GoRouterState state) =>
      const CourseSubjectsRouteData();

  @override
  String get location => GoRouteData.$location('/course/subjects');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $CourseSubjectDetailRouteData on GoRouteData {
  static CourseSubjectDetailRouteData _fromState(GoRouterState state) =>
      CourseSubjectDetailRouteData(id: state.pathParameters['id']!);

  CourseSubjectDetailRouteData get _self =>
      this as CourseSubjectDetailRouteData;

  @override
  String get location => GoRouteData.$location(
    '/course/subjects/${Uri.encodeComponent(_self.id)}',
  );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $CourseCancellationRouteData on GoRouteData {
  static CourseCancellationRouteData _fromState(GoRouterState state) =>
      const CourseCancellationRouteData();

  @override
  String get location => GoRouteData.$location('/course/irregular_classes');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $CourseRegistrationRouteData on GoRouteData {
  static CourseRegistrationRouteData _fromState(GoRouterState state) =>
      const CourseRegistrationRouteData();

  @override
  String get location => GoRouteData.$location('/course/registration');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $CourseCustomizeRouteData on GoRouteData {
  static CourseCustomizeRouteData _fromState(GoRouterState state) =>
      const CourseCustomizeRouteData();

  @override
  String get location => GoRouteData.$location('/course/preferences');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $CourseWebPdfViewerRouteData on GoRouteData {
  static CourseWebPdfViewerRouteData _fromState(GoRouterState state) =>
      CourseWebPdfViewerRouteData(
        url: state.uri.queryParameters['url']!,
        filename: state.uri.queryParameters['filename'],
      );

  CourseWebPdfViewerRouteData get _self => this as CourseWebPdfViewerRouteData;

  @override
  String get location => GoRouteData.$location(
    '/course/web_pdf_viewer',
    queryParams: {
      'url': _self.url,
      if (_self.filename != null) 'filename': _self.filename,
    },
  );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $FunchRouteData on GoRouteData {
  static FunchRouteData _fromState(GoRouterState state) =>
      const FunchRouteData();

  @override
  String get location => GoRouteData.$location('/funch');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $MapRouteData on GoRouteData {
  static MapRouteData _fromState(GoRouterState state) => const MapRouteData();

  @override
  String get location => GoRouteData.$location('/map');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $BusRouteData on GoRouteData {
  static BusRouteData _fromState(GoRouterState state) => const BusRouteData();

  @override
  String get location => GoRouteData.$location('/bus');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $BusStopSelectRouteData on GoRouteData {
  static BusStopSelectRouteData _fromState(GoRouterState state) =>
      const BusStopSelectRouteData();

  @override
  String get location => GoRouteData.$location('/bus/select_stop');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $BusTimetableRouteData on GoRouteData {
  static BusTimetableRouteData _fromState(GoRouterState state) =>
      BusTimetableRouteData(
        route: state.uri.queryParameters['route'],
        $extra: state.extra as BusTrip?,
      );

  BusTimetableRouteData get _self => this as BusTimetableRouteData;

  @override
  String get location => GoRouteData.$location(
    '/bus/timetable',
    queryParams: {if (_self.route != null) 'route': _self.route},
  );

  @override
  void go(BuildContext context) => context.go(location, extra: _self.$extra);

  @override
  Future<T?> push<T>(BuildContext context) =>
      context.push<T>(location, extra: _self.$extra);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location, extra: _self.$extra);

  @override
  void replace(BuildContext context) =>
      context.replace(location, extra: _self.$extra);
}

mixin $SettingsRouteData on GoRouteData {
  static SettingsRouteData _fromState(GoRouterState state) =>
      const SettingsRouteData();

  @override
  String get location => GoRouteData.$location('/setting');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $AnnouncementsRouteData on GoRouteData {
  static AnnouncementsRouteData _fromState(GoRouterState state) =>
      const AnnouncementsRouteData();

  @override
  String get location => GoRouteData.$location('/setting/announcements');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $DevelopersRouteData on GoRouteData {
  static DevelopersRouteData _fromState(GoRouterState state) =>
      const DevelopersRouteData();

  @override
  String get location => GoRouteData.$location('/setting/developers');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $SettingOnboardingRouteData on GoRouteData {
  static SettingOnboardingRouteData _fromState(GoRouterState state) =>
      const SettingOnboardingRouteData();

  @override
  String get location => GoRouteData.$location('/setting/onboarding');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $SettingsLicenseRouteData on GoRouteData {
  static SettingsLicenseRouteData _fromState(GoRouterState state) =>
      const SettingsLicenseRouteData();

  @override
  String get location => GoRouteData.$location('/setting/licenses');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $DebugRouteData on GoRouteData {
  static DebugRouteData _fromState(GoRouterState state) =>
      const DebugRouteData();

  @override
  String get location => GoRouteData.$location('/setting/debug');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $SubjectsRouteData on GoRouteData {
  static SubjectsRouteData _fromState(GoRouterState state) =>
      const SubjectsRouteData();

  @override
  String get location => GoRouteData.$location('/subjects');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $SubjectDetailRouteData on GoRouteData {
  static SubjectDetailRouteData _fromState(GoRouterState state) =>
      SubjectDetailRouteData(id: state.pathParameters['id']!);

  SubjectDetailRouteData get _self => this as SubjectDetailRouteData;

  @override
  String get location =>
      GoRouteData.$location('/subjects/${Uri.encodeComponent(_self.id)}');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $SubjectPastExamPdfRouteData on GoRouteData {
  static SubjectPastExamPdfRouteData _fromState(GoRouterState state) =>
      SubjectPastExamPdfRouteData(
        id: state.pathParameters['id']!,
        url: state.uri.queryParameters['url']!,
        filename: state.uri.queryParameters['filename'],
      );

  SubjectPastExamPdfRouteData get _self => this as SubjectPastExamPdfRouteData;

  @override
  String get location => GoRouteData.$location(
    '/subjects/${Uri.encodeComponent(_self.id)}/past_exams',
    queryParams: {
      'url': _self.url,
      if (_self.filename != null) 'filename': _self.filename,
    },
  );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}
