import 'package:dotto/data/app_api_transport.dart';
import 'package:dotto/data/auth_data_source.dart';
import 'package:dotto/domain/entity/auth_account.dart';
import 'package:dotto/presentation/subject/search_subject_screen.dart';
import 'package:dotto_app_api/app/v1/course_registration.connect.spec.dart';
import 'package:dotto_app_api/app/v1/subject.connect.spec.dart';
import 'package:dotto_app_api/app/v1/subject.pb.dart' as pb;
import 'package:dotto_app_api/app/v1/timetable_item.connect.spec.dart';
import 'package:dotto_app_api/app/v1/timetable_item.pb.dart' as pb;
import 'package:dotto_design_system/style/theme.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import '../../helpers/api_subject.dart';
import '../../helpers/fake_app_api_transport.dart';
import '../../helpers/fake_auth_data_source.dart';
import '../../helpers/fake_course_api.dart';

const _account = AuthAccount(
  id: 'uid',
  name: '未来 太郎',
  email: 'b1000000@fun.ac.jp',
  avatarUrl: '',
);

Future<void> _pump(
  WidgetTester tester,
  FakeAppApiTransport transport, {
  AuthAccount? currentAccount,
  ValueChanged<String>? onSubjectSelected,
}) async {
  await tester.pumpWidget(
    ProviderScope(
      retry: (_, _) => null,
      overrides: [
        appApiTransportProvider.overrideWithValue(transport),
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
  FakeAppApiTransport transport,
  List<pb.Subject> Function(pb.ListSubjectsRequest request) subjects,
) {
  transport.on(
    SubjectService.listSubjects,
    (request) => pb.ListSubjectsResponse(subjects: subjects(request)),
  );
}

/// 時間割が空の状態で科目検索に応答する Transport を作る。
FakeAppApiTransport _subjectTransport([
  List<pb.Subject> Function(pb.ListSubjectsRequest request)? subjects,
]) {
  final transport = FakeAppApiTransport()
    ..on(
      TimetableItemService.listTimetableItems,
      (_) => pb.ListTimetableItemsResponse(),
    );
  if (subjects != null) _onSubjects(transport, subjects);
  return transport;
}

Future<void> _search(WidgetTester tester, String query) async {
  await tester.enterText(find.byType(TextField), query);
  await tester.testTextInput.receiveAction(TextInputAction.done);
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('科目名で検索すると開講時期・単位・担当教員を表示する', (tester) async {
    final transport = _subjectTransport(
      (request) => [
        apiSubjectSummary(
          'a',
          name: '${request.query}入門',
          faculties: [
            apiSubjectFaculty('主担当', isPrimary: true),
            apiSubjectFaculty('副担当'),
          ],
        ),
        apiSubjectSummary(
          'b',
          name: '担当未定',
          faculties: [apiSubjectFaculty('教員A'), apiSubjectFaculty('教員B')],
        ),
      ],
    );
    await _pump(tester, transport);

    await _search(tester, '情報');

    expect(find.text('情報入門'), findsOneWidget);
    expect(find.text('前期 2単位\n主担当 他1名'), findsOneWidget);
    expect(find.text('前期 2単位\n教員A 他1名'), findsOneWidget);
  });

  testWidgets('科目を選ぶとその科目IDを通知する', (tester) async {
    final transport = _subjectTransport((_) => [apiSubjectSummary('a')]);
    String? selected;
    await _pump(tester, transport, onSubjectSelected: (id) => selected = id);
    await _search(tester, '科目');

    await tester.tap(find.text('科目a'));

    expect(selected, 'a');
  });

  testWidgets('検索に失敗したらエラーを表示する', (tester) async {
    await _pump(tester, _subjectTransport());

    await _search(tester, '科目');

    expect(find.text('科目の検索に失敗しました。'), findsOneWidget);
  });

  testWidgets('絞り込み条件を選ぶと再検索し、該当がなければその旨を表示する', (tester) async {
    final transport = _subjectTransport((_) => []);
    await _pump(tester, transport);

    await tester.tap(find.text('開講時期・必修/選択・分類'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('教養'));
    await tester.pumpAndSettle();

    expect(find.text('科目が見つかりませんでした'), findsOneWidget);
    expect(find.text('教養区分'), findsOneWidget);
  });

  testWidgets('条件をクリアすると絞り込みと検索結果を初期化する', (tester) async {
    final transport = _subjectTransport((_) => []);
    await _pump(tester, transport);
    await tester.tap(find.text('コース/領域・学年・クラス'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('学部1年'));
    await tester.pumpAndSettle();

    await tester.tap(find.byTooltip('条件をクリア'));
    await tester.pumpAndSettle();

    expect(find.text('科目が見つかりませんでした'), findsNothing);
    final clearButton = tester.widget<IconButton>(
      find.ancestor(
        of: find.byIcon(Icons.filter_alt_off),
        matching: find.byType(IconButton),
      ),
    );
    expect(clearButton.onPressed, isNull);
  });

  testWidgets('ログイン中は検索結果から履修登録できる', (tester) async {
    final api = FakeCourseApi();
    _onSubjects(api.transport, (_) => [apiSubjectSummary('a')]);
    await _pump(tester, api.transport, currentAccount: _account);
    await _search(tester, '科目');

    await tester.tap(find.byTooltip('履修登録'));
    await tester.pumpAndSettle();

    expect(api.registeredSubjectIds, {'a'});
    expect(find.byTooltip('履修解除'), findsOneWidget);
  });

  testWidgets('ログイン中は検索結果から履修解除できる', (tester) async {
    final api = FakeCourseApi(registeredSubjectIds: {'a'});
    _onSubjects(api.transport, (_) => [apiSubjectSummary('a')]);
    await _pump(tester, api.transport, currentAccount: _account);
    await _search(tester, '科目');

    await tester.tap(find.byTooltip('履修解除'));
    await tester.pumpAndSettle();

    expect(api.registeredSubjectIds, isEmpty);
    expect(find.byTooltip('履修登録'), findsOneWidget);
  });

  testWidgets('履修登録に失敗したら通知する', (tester) async {
    final api = FakeCourseApi();
    _onSubjects(api.transport, (_) => [apiSubjectSummary('x')]);
    await _pump(tester, api.transport, currentAccount: _account);
    await _search(tester, '科目');
    api.transport.fail(CourseRegistrationService.createCourseRegistration);

    await tester.tap(find.byTooltip('履修登録'));
    await tester.pumpAndSettle();

    expect(find.text('履修登録の更新に失敗しました'), findsOneWidget);
  });

  testWidgets('未ログインでは履修登録ボタンを表示しない', (tester) async {
    final transport = _subjectTransport((_) => [apiSubjectSummary('a')]);
    await _pump(tester, transport);

    await _search(tester, '科目');

    expect(find.byTooltip('履修登録'), findsNothing);
  });
}
