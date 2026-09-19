import 'package:dotto/router/routes/app_routes.dart';
import 'package:dotto/router/routes/course_routes.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_router.g.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>(
  debugLabel: 'rootNavigator',
);

@Riverpod(keepAlive: true)
GoRouter appRouter(Ref ref) {
  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: const CourseRouteData().location,
    redirect: (context, state) => appRedirectLocation(state.uri),
    routes: $appRoutes,
    observers: [
      FirebaseAnalyticsObserver(analytics: FirebaseAnalytics.instance),
    ],
  );
}

String? appRedirectLocation(Uri uri) {
  if (uri.path == '/') {
    return const CourseRouteData().location;
  }
  return null;
}
