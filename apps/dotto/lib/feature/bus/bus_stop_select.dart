import 'package:dotto/feature/bus/bus_reducer.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';

final class BusStopSelectScreen extends ConsumerWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final busState = ref.watch(busReducerProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('バス停選択')),
      body: busState.when(
        data: (state) {
          return ListView(
            children: state.allStops
                .where((busStop) => busStop.selectable ?? true)
                .map(
                  (e) => ListTile(
                    onTap: () async {
                      await ref
                          .read(busReducerProvider.notifier)
                          .selectBusStop(e);
                      if (context.mounted) {
                        Navigator.of(context).pop();
                      }
                    },
                    title: Text(e.name),
                  ),
                )
                .toList(),
          );
        },
        error: (error, stackTrace) => const SizedBox.shrink(),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
