import 'package:dotto/feature/bus/bus_screen.dart';
import 'package:dotto/feature/bus/bus_stop_select.dart';
import 'package:dotto/feature/bus/bus_trip_screen.dart';
import 'package:dotto/router/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
