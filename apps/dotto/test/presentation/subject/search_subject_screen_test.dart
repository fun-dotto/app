import 'package:dotto/data/api_client.dart';
import 'package:dotto/data/auth_data_source.dart';
import 'package:dotto/domain/entity/auth_account.dart';
import 'package:dotto/presentation/subject/search_subject_screen.dart';
import 'package:dotto_design_system/style/theme.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:openapi/openapi.dart';

import '../../helpers/fake_auth_data_source.dart';
import '../../helpers/fake_course_api.dart';
import '../../helpers/fake_http_client_adapter.dart';
import '../../helpers/subject_json.dart';

const _account = AuthAccount(
  id: 'uid',
  name: '未来 太郎',
  email: 'b1000000@fun.ac.jp',
  avatarUrl: '',
);

Future<void> _pump(
  WidgetTester tester,
  FakeHttpClientAdapter adapter, {
  AuthAccount? currentAccount,
  ValueChanged<String>? onSubjectSelected,
}) async {
  await tester.pumpWidget(
    ProviderScope(
      retry: (_, _) => null,
      overrides: [
        apiClientProvider.overrideWithValue(Openapi(dio: fakeDio(adapter))),
        authDataSourceProvider.overrideWithValue(
          FakeAuthDataSource(currentAccount: currentAccount),
        ),
      ],
      child: MaterialApp(
        theme: DottoTheme.v2,
        home: SearchSubjectScreen(
          onSubjectSelected: onSubjectSelected ?? (_) {},
        ),
      ),
    ),
  );
  await tester.pumpAndSettle();
}

void _onSubjects(
  FakeHttpClientAdapter adapter,
  List<Map<String, Object?>> Function(Map<String, dynamic> query) subjects,
) {
  adapter.on(
    'GET',
    '/v1/subjects',
    (options) =>
        FakeResponse(200, {'subjects': subjects(options.queryParameters)}),
  );
}

/// 時間割が空の状態で科目検索に応答するアダプターを作る。
FakeHttpClientAdapter _subjectAdapter([
  List<Map<String, Object?>> Function(Map<String, dynamic> query)? subjects,
]) {
  final adapter = FakeHttpClientAdapter()
    ..on(
      'GET',
      '/v1/timetableItems',
      (_) => const FakeResponse(200, {'timetableItems': <Object>[]}),
    );
  if (subjects != null) _onSubjects(adapter, subjects);
  return adapter;
}

Future<void> _search(WidgetTester tester, String query) async {
  await tester.enterText(find.byType(TextField), query);
  await tester.testTextInput.receiveAction(TextInputAction.done);
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('科目名で検索すると開講時期・単位・担当教員を表示する', (tester) async {
    final adapter = _subjectAdapter(
      (query) => [
        subjectSummaryJson(
          'a',
          name: '${query['q']}入門',
          faculties: [
            subjectFacultyJson('主担当', isPrimary: true),
            subjectFacultyJson('副担当'),
          ],
        ),
        subjectSummaryJson(
          'b',
          name: '担当未定',
          faculties: [subjectFacultyJson('教員A'), subjectFacultyJson('教員B')],
        ),
      ],
    );
    await _pump(tester, adapter);

    await _search(tester, '情報');

    expect(find.text('情報入門'), findsOneWidget);
    expect(find.text('前期 2単位\n主担当 他1名'), findsOneWidget);
    expect(find.text('前期 2単位\n教員A 他1名'), findsOneWidget);
  });

  testWidgets('科目を選ぶとその科目IDを通知する', (tester) async {
    final adapter = _subjectAdapter((_) => [subjectSummaryJson('a')]);
    String? selected;
    await _pump(tester, adapter, onSubjectSelected: (id) => selected = id);
    await _search(tester, '科目');

    await tester.tap(find.text('科目a'));

    expect(selected, 'a');
  });

  testWidgets('検索に失敗したらエラーを表示する', (tester) async {
    await _pump(tester, _subjectAdapter());

    await _search(tester, '科目');

    expect(find.text('科目の検索に失敗しました。'), findsOneWidget);
  });

  testWidgets('絞り込み条件を選ぶと再検索し、該当がなければその旨を表示する', (tester) async {
    final adapter = _subjectAdapter((_) => []);
    await _pump(tester, adapter);

    await tester.tap(find.text('開講時期・必修/選択・分類'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('教養'));
    await tester.pumpAndSettle();

    expect(find.text('科目が見つかりませんでした'), findsOneWidget);
    expect(find.text('教養区分'), findsOneWidget);
  });

  testWidgets('条件をクリアすると絞り込みと検索結果を初期化する', (tester) async {
    final adapter = _subjectAdapter((_) => []);
    await _pump(tester, adapter);
    await tester.tap(find.text('コース/領域・学年・クラス'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('学部1年'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('条件をクリア'));
    await tester.pumpAndSettle();

    expect(find.text('科目が見つかりませんでした'), findsNothing);
    final clearButton = tester.widget<TextButton>(
      find.widgetWithText(TextButton, '条件をクリア'),
    );
    expect(clearButton.onPressed, isNull);
  });

  testWidgets('ログイン中は検索結果から履修登録できる', (tester) async {
    final api = FakeCourseApi();
    _onSubjects(api.adapter, (_) => [subjectSummaryJson('a')]);
    await _pump(tester, api.adapter, currentAccount: _account);
    await _search(tester, '科目');

    await tester.tap(find.byTooltip('履修登録'));
    await tester.pumpAndSettle();

    expect(api.registeredSubjectIds, {'a'});
    expect(find.byTooltip('履修解除'), findsOneWidget);
  });

  testWidgets('ログイン中は検索結果から履修解除できる', (tester) async {
    final api = FakeCourseApi(registeredSubjectIds: {'a'});
    _onSubjects(api.adapter, (_) => [subjectSummaryJson('a')]);
    await _pump(tester, api.adapter, currentAccount: _account);
    await _search(tester, '科目');

    await tester.tap(find.byTooltip('履修解除'));
    await tester.pumpAndSettle();

    expect(api.registeredSubjectIds, isEmpty);
    expect(find.byTooltip('履修登録'), findsOneWidget);
  });

  testWidgets('履修登録に失敗したら通知する', (tester) async {
    final api = FakeCourseApi();
    _onSubjects(api.adapter, (_) => [subjectSummaryJson('x')]);
    await _pump(tester, api.adapter, currentAccount: _account);
    await _search(tester, '科目');
    api.adapter.on(
      'POST',
      '/v1/courseRegistrations',
      (_) => const FakeResponse(500),
    );

    await tester.tap(find.byTooltip('履修登録'));
    await tester.pumpAndSettle();

    expect(find.text('履修登録の更新に失敗しました'), findsOneWidget);
  });

  testWidgets('未ログインでは履修登録ボタンを表示しない', (tester) async {
    final adapter = _subjectAdapter((_) => [subjectSummaryJson('a')]);
    await _pump(tester, adapter);

    await _search(tester, '科目');

    expect(find.byTooltip('履修登録'), findsNothing);
  });
}
