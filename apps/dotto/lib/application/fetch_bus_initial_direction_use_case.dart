import 'package:dotto/data/bus_schedule_repository_impl.dart';
import 'package:dotto/domain/repository/bus_schedule_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'fetch_bus_initial_direction_use_case.g.dart';

final class FetchBusInitialDirectionUseCase {
  const new(this._repository);
  final BusScheduleRepository _repository;
  Future<bool> call() => _repository.fetchInitialDirection();
}

@riverpod
FetchBusInitialDirectionUseCase fetchBusInitialDirectionUseCase(Ref ref) =>
    FetchBusInitialDirectionUseCase(ref.watch(busScheduleRepositoryProvider));
