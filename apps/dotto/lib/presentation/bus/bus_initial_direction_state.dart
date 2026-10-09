import 'package:dotto/application/fetch_bus_initial_direction_use_case.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'bus_initial_direction_state.g.dart';

@riverpod
final class BusInitialDirectionState extends _$BusInitialDirectionState {
  @override
  Future<bool> build() => ref.watch(fetchBusInitialDirectionUseCaseProvider)();
}
