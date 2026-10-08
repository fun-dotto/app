import 'package:dotto/data/bus_schedule_repository_impl.dart';
import 'package:dotto/domain/repository/bus_schedule_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'fetch_bus_initial_weekday_use_case.g.dart';

final class FetchBusInitialWeekdayUseCase {
  const new(this._repository);
  final BusScheduleRepository _repository;
  Future<bool> call() => _repository.fetchInitialWeekday();
}

@riverpod
FetchBusInitialWeekdayUseCase fetchBusInitialWeekdayUseCase(Ref ref) =>
    FetchBusInitialWeekdayUseCase(ref.watch(busScheduleRepositoryProvider));
