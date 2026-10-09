import 'package:dotto/data/user_preference_repository_impl.dart';
import 'package:dotto/domain/entity/timetable_period_style.dart';
import 'package:dotto/domain/repository/user_preference_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'save_timetable_period_style_use_case.g.dart';

@riverpod
SaveTimetablePeriodStyleUseCase saveTimetablePeriodStyleUseCase(Ref ref) =>
    SaveTimetablePeriodStyleUseCase(
      ref.watch(userPreferenceRepositoryProvider),
    );

final class SaveTimetablePeriodStyleUseCase {
  const new(this._repository);
  final UserPreferenceRepository _repository;
  Future<void> call(TimetablePeriodStyle style) =>
      _repository.saveTimetablePeriodStyle(style);
}
