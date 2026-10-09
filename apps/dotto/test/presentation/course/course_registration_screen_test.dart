import 'package:dotto/data/api_client.dart';
import 'package:dotto/presentation/course/course_registration_screen.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:openapi/openapi.dart';

import '../../helpers/fake_course_api.dart';
import '../../helpers/fake_http_client_adapter.dart';

Future<void> _pump(WidgetTester tester, FakeHttpClientAdapter adapter) async {
  await tester.pumpWidget(
    ProviderScope(
      retry: (_, _) => null,
      overrides: [
        apiClientProvider.overrideWithValue(Openapi(dio: fakeDio(adapter))),
      ],
      child: const MaterialApp(home: CourseRegistrationScreen()),
    ),
  );
  await tester.pumpAndSettle();
}

/// 月曜1限のコマ。[FakeCourseApi] の科目はすべてこのコマに開講される。
Finder get _mondayFirstPeriod => find.byIcon(Icons.add).first;

void main() {
  testWidgets('履修中の科目を週間時間割のコマに表示する', (tester) async {
    final api = FakeCourseApi(registeredSubjectIds: {'a'});

    await _pump(tester, api.adapter);

    expect(find.text('科目a'), findsOneWidget);
    expect(find.text('科目b'), findsNothing);
  });

  testWidgets('コマを選ぶと開講科目を一覧し、追加すると時間割に反映する', (tester) async {
    final api = FakeCourseApi();
    await _pump(tester, api.adapter);

    await tester.tap(_mondayFirstPeriod);
    await tester.pumpAndSettle();
    expect(find.text('前期 月曜1限'), findsOneWidget);
    await tester.tap(find.text('追加').at(1));
    await tester.pumpAndSettle();

    expect(api.registeredSubjectIds, {'b'});
    expect(find.text('科目b'), findsOneWidget);
  });

  testWidgets('取得に失敗したらエラーを表示する', (tester) async {
    await _pump(tester, FakeHttpClientAdapter());

    expect(find.text('データの取得に失敗しました'), findsOneWidget);
  });
}
