import 'package:dotto/feature/funch/funch.dart';
import 'package:dotto/router/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final class FunchRouteData extends GoRouteData with $FunchRouteData {
  const FunchRouteData();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const FunchScreen();
  }
}
