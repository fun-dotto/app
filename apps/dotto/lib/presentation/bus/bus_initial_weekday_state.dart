import 'package:dotto/application/fetch_bus_initial_weekday_use_case.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'bus_initial_weekday_state.g.dart';

@riverpod
final class BusInitialWeekdayState extends _$BusInitialWeekdayState {
  @override
  Future<bool> build() => ref.watch(fetchBusInitialWeekdayUseCaseProvider)();
}
