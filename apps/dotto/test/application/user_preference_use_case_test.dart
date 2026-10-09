import 'package:dotto/application/fetch_user_preference_use_case.dart';
import 'package:dotto/application/save_timetable_period_style_use_case.dart';
import 'package:dotto/domain/entity/timetable_period_style.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  test('未設定の時限表示は時限のみとする', () async {
    SharedPreferences.setMockInitialValues({});
    final container = ProviderContainer();
    addTearDown(container.dispose);

    final preference = await container.read(
      fetchUserPreferenceUseCaseProvider,
    )();

    expect(preference.timetablePeriodStyle, TimetablePeriodStyle.numberOnly);
  });

  test('保存した時限表示を次回の取得に反映する', () async {
    SharedPreferences.setMockInitialValues({});
    final container = ProviderContainer();
    addTearDown(container.dispose);
    final style = TimetablePeriodStyle.values.last;

    await container.read(saveTimetablePeriodStyleUseCaseProvider)(style);

    expect(
      (await container.read(
        fetchUserPreferenceUseCaseProvider,
      )()).timetablePeriodStyle,
      style,
    );
  });
}
