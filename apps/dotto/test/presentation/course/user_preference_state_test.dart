import 'package:dotto/domain/entity/timetable_period_style.dart';
import 'package:dotto/presentation/common/user_preference_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  test('時間割の時刻表示設定を保存して別の画面でも読み取れる', () async {
    SharedPreferences.setMockInitialValues({});
    final container = ProviderContainer();
    addTearDown(container.dispose);
    final subscription = container.listen(
      userPreferenceStateProvider,
      (_, _) {},
    );
    addTearDown(subscription.close);
    await container.read(userPreferenceStateProvider.future);

    await container
        .read(userPreferenceStateProvider.notifier)
        .setTimetablePeriodStyle(TimetablePeriodStyle.numberAndTime);
    final nextContainer = ProviderContainer();
    addTearDown(nextContainer.dispose);
    final saved = await nextContainer.read(userPreferenceStateProvider.future);

    expect(saved.timetablePeriodStyle, TimetablePeriodStyle.numberAndTime);
  });
}
