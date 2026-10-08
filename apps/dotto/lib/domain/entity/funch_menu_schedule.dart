import 'package:freezed_annotation/freezed_annotation.dart';
part 'funch_menu_schedule.freezed.dart';

@Freezed(makeCollectionsUnmodifiable: true)
abstract class FunchMenuSchedule with _$FunchMenuSchedule {
  const factory({
    required DateTime date,
    required List<int> commonMenuIds,
    required List<String> originalMenuIds,
  }) = _FunchMenuSchedule;
}
