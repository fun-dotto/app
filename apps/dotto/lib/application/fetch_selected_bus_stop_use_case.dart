import 'package:dotto/data/bus_schedule_repository_impl.dart';
import 'package:dotto/domain/entity/bus_schedule_stop.dart';
import 'package:dotto/domain/repository/bus_schedule_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'fetch_selected_bus_stop_use_case.g.dart';

final class FetchSelectedBusStopUseCase {
  const new(this._repository);
  final BusScheduleRepository _repository;
  Future<BusScheduleStop> call() => _repository.fetchSelectedStop();
}

@riverpod
FetchSelectedBusStopUseCase fetchSelectedBusStopUseCase(Ref ref) =>
    FetchSelectedBusStopUseCase(ref.watch(busScheduleRepositoryProvider));
