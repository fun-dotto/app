import 'package:dotto/api/api_client.dart';
import 'package:dotto/domain/entity/day_of_week.dart';
import 'package:dotto/domain/entity/period.dart';
import 'package:dotto/domain/entity/timetable_item.dart';
import 'package:dotto/domain/entity/timetable_semester.dart';
import 'package:dotto/presentation/course/select_course_screen.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:openapi/openapi.dart' hide TimetableItem;

import '../../helpers/fake_course_api.dart';
import '../../helpers/fake_http_client_adapter.dart';

Future<void> _pumpSelection(
  WidgetTester tester,
  FakeCourseApi api, {
  required bool isAdded,
}) async {
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        apiClientProvider.overrideWithValue(Openapi(dio: fakeDio(api.adapter))),
      ],
      child: MaterialApp(
        home: SelectCourseScreen(
          TimetableSemester.values.first,
          DayOfWeek.monday,
          Period.first,
          [
            TimetableItem(
              id: 'item-c',
              slot: null,
              subject: api.subject('c'),
              isAddedToTimetable: isAdded,
            ),
          ],
        ),
      ),
    ),
  );
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('科目を追加して履修登録へ反映する', (tester) async {
    final api = FakeCourseApi();
    await _pumpSelection(tester, api, isAdded: false);

    await tester.tap(find.text('追加'));
    await tester.pumpAndSettle();

    expect(api.registeredSubjectIds, {'c'});
  });

  testWidgets('登録済み科目を削除して履修登録から取り除く', (tester) async {
    final api = FakeCourseApi(registeredSubjectIds: {'c'});
    await _pumpSelection(tester, api, isAdded: true);

    await tester.tap(find.text('削除'));
    await tester.pumpAndSettle();

    expect(api.registeredSubjectIds, isEmpty);
  });

  testWidgets('同じコマの3科目目は追加せず上限を表示する', (tester) async {
    final api = FakeCourseApi(registeredSubjectIds: {'a', 'b'});
    await _pumpSelection(tester, api, isAdded: false);

    await tester.tap(find.text('追加'));
    await tester.pumpAndSettle();

    expect(api.registeredSubjectIds, {'a', 'b'});
    expect(find.text('1つのコマに2科目以上を設定できません'), findsOneWidget);
  });
}
