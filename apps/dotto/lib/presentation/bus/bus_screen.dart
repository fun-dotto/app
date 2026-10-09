import 'dart:async';

import 'package:dotto/l10n/app_localizations.dart';
import 'package:dotto/l10n/app_localizations_ja.dart';
import 'package:dotto/presentation/bus/bus_content.dart';
import 'package:dotto/presentation/bus/bus_initial_direction_state.dart';
import 'package:dotto/presentation/bus/bus_initial_weekday_state.dart';
import 'package:dotto/presentation/bus/bus_schedule_state.dart';
import 'package:dotto/presentation/bus/selected_bus_stop_state.dart';
import 'package:dotto/presentation/common/use_tab_controller.dart';
import 'package:dotto/router/routes/bus_routes.dart';
import 'package:flutter_hooks/flutter_hooks.dart' hide useTabController;
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';

final class BusScreen extends HookConsumerWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context) ?? AppLocalizationsJa();
    final state = ref.watch(busScheduleStateProvider);
    final selectedStopState = ref.watch(selectedBusStopStateProvider);
    final selectedStop = selectedStopState.value;
    final initialDirection = ref
        .watch(busInitialDirectionStateProvider)
        .asData
        ?.value;
    final initialWeekday = ref
        .watch(busInitialWeekdayStateProvider)
        .asData
        ?.value;
    final direction = useState(true);
    final hasChangedDirection = useState(false);
    final hasChangedWeekday = useState(false);
    final isApplyingInitialWeekday = useRef(false);
    final isTo = direction.value;
    final myBusStopName = selectedStop?.name ?? '';
    final currentTime = useState(DateTime.now());
    final tabController = useTabController(initialLength: 2);
    useEffect(() {
      if (initialDirection != null && !hasChangedDirection.value) {
        direction.value = initialDirection;
      }
      return null;
    }, [initialDirection]);
    useEffect(() {
      if (initialWeekday != null && !hasChangedWeekday.value) {
        isApplyingInitialWeekday.value = true;
        tabController.index = initialWeekday ? 0 : 1;
        isApplyingInitialWeekday.value = false;
      }
      return null;
    }, [initialWeekday]);
    useEffect(() {
      void listener() {
        if (!isApplyingInitialWeekday.value) hasChangedWeekday.value = true;
      }

      tabController.addListener(listener);
      return () => tabController.removeListener(listener);
    }, [tabController]);
    useEffect(() {
      final timer = Timer.periodic(const Duration(seconds: 30), (_) {
        currentTime.value = DateTime.now();
      });
      return timer.cancel;
    }, const []);
    return BusContent(
      isTo: isTo,
      myBusStopName: myBusStopName,
      tabController: tabController,
      onDirectionSwapped: () {
        hasChangedDirection.value = true;
        direction.value = !direction.value;
      },
      onBusStopTap: () =>
          unawaited(const BusStopSelectRouteData().push<void>(context)),
      onWeekdayTabTap: () => hasChangedWeekday.value = true,
      body: switch ((state, selectedStopState)) {
        (AsyncData(:final value), AsyncData()) when selectedStop != null =>
          BusTripTabView(
            schedule: value,
            stop: selectedStop,
            isTo: isTo,
            currentTime: currentTime.value,
            tabController: tabController,
            onTripTap: (id) =>
                unawaited(BusTripRouteData(id: id.value).push<void>(context)),
          ),
        (AsyncError(), _) ||
        (_, AsyncError()) => Center(child: Text(l10n.busError)),
        _ => const Center(child: CircularProgressIndicator()),
      },
    );
  }
}
