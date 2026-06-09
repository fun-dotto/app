import 'dart:async';

import 'package:app_links/app_links.dart';
import 'package:dotto/helper/logger.dart';
import 'package:dotto/router/routes/app_routes.dart';
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
    routes: $appRoutes,
    observers: [
      FirebaseAnalyticsObserver(analytics: FirebaseAnalytics.instance),
    ],
  );
}

@Riverpod(keepAlive: true)
StreamSubscription<Uri> appDeepLinkSubscription(Ref ref) {
  final router = ref.watch(appRouterProvider);
  final logger = ref.watch(loggerProvider);
  final appLinks = AppLinks();

  Future<void> routeTo(Uri uri) async {
    final location = _routeLocationFromUri(uri);
    if (location == null) {
      return;
    }
    router.go(location);
  }

  unawaited(
    appLinks
        .getInitialLink()
        .then((uri) async {
          if (uri != null) {
            await routeTo(uri);
          }
        })
        .onError<Object>((error, stackTrace) async {
          await logger.logError(error, stackTrace);
        }),
  );

  final subscription = appLinks.uriLinkStream.listen(routeTo)
    ..onError((Object error, StackTrace stackTrace) async {
      await logger.logError(error, stackTrace);
    });
  ref.onDispose(subscription.cancel);
  return subscription;
}

String? _routeLocationFromUri(Uri uri) {
  final isWebLink = uri.scheme == 'http' || uri.scheme == 'https';
  final path = isWebLink
      ? (uri.path.isEmpty ? '/' : uri.path)
      : switch ((uri.host, uri.path)) {
          (final host, final path) when host.isNotEmpty && path.isNotEmpty =>
            '/$host$path',
          (final host, _) when host.isNotEmpty => '/$host',
          (_, final path) when path.isNotEmpty => path,
          _ => '/',
        };
  if (!path.startsWith('/')) {
    return null;
  }
  final query = uri.hasQuery ? '?${uri.query}' : '';
  final fragment = uri.hasFragment ? '#${uri.fragment}' : '';
  return '$path$query$fragment';
}
