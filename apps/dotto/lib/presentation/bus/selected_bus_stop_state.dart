import 'package:dotto/application/fetch_selected_bus_stop_use_case.dart';
import 'package:dotto/application/save_selected_bus_stop_use_case.dart';
import 'package:dotto/domain/entity/bus_schedule_stop.dart';
import 'package:dotto/domain/entity/domain_error.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'selected_bus_stop_state.g.dart';

@riverpod
final class SelectedBusStopState extends _$SelectedBusStopState {
  @override
  Future<BusScheduleStop> build() =>
      ref.watch(fetchSelectedBusStopUseCaseProvider)();
  Future<bool> selectBusStop(BusScheduleStop stop) async {
    try {
      await ref.read(saveSelectedBusStopUseCaseProvider)(stop);
      state = AsyncData(stop);
      return true;
    } on DomainError catch (error, stackTrace) {
      state = AsyncError<BusScheduleStop>(error, stackTrace);
      return false;
    }
  }
}
