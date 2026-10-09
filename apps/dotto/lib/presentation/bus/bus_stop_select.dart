import 'package:dotto/l10n/app_localizations.dart';
import 'package:dotto/l10n/app_localizations_ja.dart';
import 'package:dotto/presentation/bus/bus_schedule_state.dart';
import 'package:dotto/presentation/bus/bus_stop_select_content.dart';
import 'package:dotto/presentation/bus/selected_bus_stop_state.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';

final class BusStopSelectScreen extends HookConsumerWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context) ?? AppLocalizationsJa();
    final busState = ref.watch(busScheduleStateProvider);
    final isSaving = useState(false);
    return Scaffold(
      appBar: AppBar(title: Text(l10n.busStopSelectTitle)),
      body: switch (busState) {
        AsyncData(:final value) => BusStopSelectContent(
          stops: value.allStops
              .where((stop) => stop.selectable ?? true)
              .toList(),
          onStopSelected: (stop) async {
            if (isSaving.value) return;
            isSaving.value = true;
            final didSave = await ref
                .read(selectedBusStopStateProvider.notifier)
                .selectBusStop(stop);
            if (!context.mounted) return;
            isSaving.value = false;
            if (didSave) {
              Navigator.of(context).pop();
            } else {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(l10n.busError)));
            }
          },
        ),
        AsyncError() => Center(child: Text(l10n.busError)),
        _ => const Center(child: CircularProgressIndicator()),
      },
    );
  }
}
