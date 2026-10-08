import 'package:dotto/domain/entity/bus_schedule_trip.dart';
import 'package:dotto/helper/date_formatter.dart';
import 'package:dotto/l10n/app_localizations.dart';
import 'package:dotto/l10n/app_localizations_ja.dart';
import 'package:dotto_design_system/style/semantic_color.dart';
import 'package:material_ui/material_ui.dart';

final class BusTimetableScreen extends StatelessWidget {
  const new(this.busTrip, {super.key});
  final BusScheduleTrip busTrip;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context) ?? AppLocalizationsJa();
    return Scaffold(
      appBar: AppBar(title: Text(busTrip.route)),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ListView(
          children: busTrip.stops.map((busTripStop) {
            final terminal = busTripStop.terminal;
            return IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                spacing: 16,
                children: [
                  SizedBox(
                    width: 48,
                    child: Center(
                      child: Text(
                        DateFormatter.busTime(busTripStop.time),
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ),
                  ),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: 12,
                        decoration: BoxDecoration(
                          color: SemanticColor.light.accentPrimary,
                        ),
                      ),
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: SemanticColor.light.backgroundSecondary,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ],
                  ),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            busTripStop.stop.name,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          if (terminal != null)
                            Text(
                              l10n.busTerminal(terminal.toString()),
                              style: Theme.of(context).textTheme.labelMedium,
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
