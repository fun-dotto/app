import 'package:dotto/domain/entity/bus_trip_id.dart';
import 'package:dotto/l10n/app_localizations.dart';
import 'package:dotto/l10n/app_localizations_ja.dart';
import 'package:dotto/presentation/bus/bus_schedule_state.dart';
import 'package:dotto/presentation/bus/bus_trip_content.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';

/// バス便の時刻表画面。
///
/// URL上の便ID（[BusTripId]）から対象の便を解決して表示する。
final class BusTripScreen extends HookConsumerWidget {
  const new({required this.id, super.key});

  final String id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context) ?? AppLocalizationsJa();
    final state = ref.watch(busScheduleStateProvider);
    final tripId = BusTripId.tryParse(id);

    return switch (state) {
      AsyncData(:final value) => () {
        final busTrip = tripId == null ? null : value.tripOf(tripId);
        if (busTrip == null) {
          return _BusMessage(message: l10n.busTripNotFound);
        }
        return BusTripContent(busTrip: busTrip);
      }(),
      AsyncError() => _BusMessage(message: l10n.busLoadError),
      _ => const Scaffold(body: Center(child: CircularProgressIndicator())),
    };
  }
}

final class _BusMessage extends StatelessWidget {
  const new({required this.message});
  final String message;
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context) ?? AppLocalizationsJa();
    return Scaffold(
      appBar: AppBar(title: Text(l10n.busTimetableTitle)),
      body: Center(child: Text(message)),
    );
  }
}
