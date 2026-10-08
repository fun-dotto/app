import 'package:freezed_annotation/freezed_annotation.dart';

part 'bus_stop.freezed.dart';

@freezed
abstract class BusStop with _$BusStop {
  const factory({required String id, required String name}) = _BusStop;
}
