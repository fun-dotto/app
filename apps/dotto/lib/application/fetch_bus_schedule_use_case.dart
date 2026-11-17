import 'package:dotto/data/bus_schedule_api_repository_impl.dart';
import 'package:dotto/data/bus_schedule_repository_impl.dart';
import 'package:dotto/domain/entity/bus_schedule.dart';
import 'package:dotto/domain/repository/bus_schedule_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'fetch_bus_schedule_use_case.g.dart';

final class FetchBusScheduleUseCase {
  const new(this._repository, this._apiRepository);
  final BusScheduleRepository _repository;
  final BusScheduleRepository _apiRepository;

  /// [useApi] が true の場合は app-api から取得する。
  Future<BusSchedule> call({bool useApi = false}) =>
      (useApi ? _apiRepository : _repository).fetchSchedule();
}

@riverpod
FetchBusScheduleUseCase fetchBusScheduleUseCase(Ref ref) =>
    FetchBusScheduleUseCase(
      ref.watch(busScheduleRepositoryProvider),
      ref.watch(busScheduleApiRepositoryProvider),
    );
