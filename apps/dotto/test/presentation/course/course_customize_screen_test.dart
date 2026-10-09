import 'package:dotto/domain/entity/user_preference_keys.dart';
import 'package:dotto/presentation/course/course_customize_screen.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  testWidgets('時間割の時刻表示スイッチを切り替えて保存する', (tester) async {
    SharedPreferences.setMockInitialValues({});
    await tester.pumpWidget(
      const ProviderScope(child: MaterialApp(home: CourseCustomizeScreen())),
    );
    await tester.pumpAndSettle();
    expect(
      tester.widget<SwitchListTile>(find.byType(SwitchListTile)).value,
      isFalse,
    );

    await tester.tap(find.byType(SwitchListTile));
    await tester.pumpAndSettle();

    expect(
      tester.widget<SwitchListTile>(find.byType(SwitchListTile)).value,
      isTrue,
    );
    final preferences = await SharedPreferences.getInstance();
    expect(
      preferences.getString(UserPreferenceKeys.timetablePeriodStyle.key),
      'number_and_time',
    );
  });
}
