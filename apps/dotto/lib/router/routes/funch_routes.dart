import 'package:dotto/feature/funch/funch.dart';
import 'package:dotto/router/routes/app_routes.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

final class FunchRouteData extends GoRouteData with $FunchRouteData {
  const new();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const FunchScreen();
  }
}
