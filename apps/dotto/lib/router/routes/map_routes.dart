import 'package:dotto/feature/map/map_screen.dart';
import 'package:dotto/router/routes/app_routes.dart';
import 'package:dotto/router/routes/setting_routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
