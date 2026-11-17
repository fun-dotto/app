import 'package:dotto/l10n/app_localizations.dart';
import 'package:dotto/l10n/app_localizations_ja.dart';
import 'package:dotto/presentation/bus/bus_screen.dart';
import 'package:dotto/presentation/bus/bus_stop_select.dart';
import 'package:dotto/presentation/bus/bus_trip_screen.dart';
import 'package:dotto/router/routes/app_routes.dart';
import 'package:dotto_design_system/component/list_detail.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

/// 時刻表と便の詳細を、幅に応じて左右に並べる。
final class BusListDetailShellRouteData extends ShellRouteData {
  const new();

  @override
  Widget builder(BuildContext context, GoRouterState state, Widget navigator) {
    return DottoListDetail(list: const BusScreen(), detail: navigator);
  }
}

final class BusRouteData extends GoRouteData with $BusRouteData {
  const new();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return DottoListDetailRoot(
      placeholder: DottoListDetailPlaceholder(
        icon: Icons.directions_bus,
        message: (AppLocalizations.of(context) ?? AppLocalizationsJa())
            .busSelectTrip,
      ),
      child: const BusScreen(),
    );
  }
}

final class BusStopSelectRouteData extends GoRouteData
    with $BusStopSelectRouteData {
  const new();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const BusStopSelectScreen();
  }
}

final class BusTripRouteData extends GoRouteData with $BusTripRouteData {
  const new({required this.id});

  final String id;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BusTripScreen(id: id);
  }
}
