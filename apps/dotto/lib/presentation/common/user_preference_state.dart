import 'package:dotto/application/fetch_user_preference_use_case.dart';
import 'package:dotto/application/save_timetable_period_style_use_case.dart';
import 'package:dotto/domain/entity/dotto_user_preference.dart';
import 'package:dotto/domain/entity/timetable_period_style.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_preference_state.g.dart';

@riverpod
final class UserPreferenceState extends _$UserPreferenceState {
  @override
  Future<DottoUserPreference> build() =>
      ref.watch(fetchUserPreferenceUseCaseProvider)();

  Future<void> setTimetablePeriodStyle(TimetablePeriodStyle style) async {
    final next = await AsyncValue.guard(() async {
      await ref.read(saveTimetablePeriodStyleUseCaseProvider)(style);
      return await ref.read(fetchUserPreferenceUseCaseProvider)();
    });
    if (ref.mounted) state = next;
  }
}
