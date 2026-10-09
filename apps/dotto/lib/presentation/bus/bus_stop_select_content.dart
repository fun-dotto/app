import 'package:dotto/domain/entity/bus_schedule_stop.dart';
import 'package:material_ui/material_ui.dart';

/// 選択できるバス停の一覧。
final class BusStopSelectContent extends StatelessWidget {
  const new({required this.stops, required this.onStopSelected, super.key});

  final List<BusScheduleStop> stops;
  final ValueChanged<BusScheduleStop> onStopSelected;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        for (final stop in stops)
          ListTile(title: Text(stop.name), onTap: () => onStopSelected(stop)),
      ],
    );
  }
}
