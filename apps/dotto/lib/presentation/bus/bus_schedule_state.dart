import 'package:dotto/application/fetch_bus_schedule_use_case.dart';
import 'package:dotto/domain/entity/bus_schedule.dart';
import 'package:dotto/domain/entity/flags.dart';
import 'package:dotto/presentation/common/feature_flag.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'bus_schedule_state.g.dart';

@riverpod
final class BusScheduleState extends _$BusScheduleState {
  @override
  Future<BusSchedule> build() => ref.watch(fetchBusScheduleUseCaseProvider)(
    useApi: ref.watch(featureFlagProvider(Flags.busApi)),
  );
}
