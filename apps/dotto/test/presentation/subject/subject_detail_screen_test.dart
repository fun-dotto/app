import 'package:dotto/data/api_client.dart';
import 'package:dotto/data/auth_data_source.dart';
import 'package:dotto/data/past_exam_data_source.dart';
import 'package:dotto/data/subject_data_source.dart';
import 'package:dotto/domain/entity/auth_account.dart';
import 'package:dotto/presentation/common/error_view.dart';
import 'package:dotto/presentation/subject/subject_detail_screen.dart';
import 'package:dotto/presentation/subject/subject_review_new_screen.dart';
import 'package:dotto_design_system/style/theme.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:openapi/openapi.dart';

import '../../helpers/fake_auth_data_source.dart';
import '../../helpers/fake_http_client_adapter.dart';
import '../../helpers/fake_past_exam_data_source.dart';
import '../../helpers/fake_subject_data_source.dart';
import '../../helpers/subject_json.dart';

const _account = AuthAccount(
  id: 'uid',
  name: '未来 太郎',
  email: 'b1000000@fun.ac.jp',
  avatarUrl: '',
);

/// [FakeSubjectDataSource] は過去問IDを `past-<lessonId>` として返す。
const _pastExamId = 'past-lesson';

FakeHttpClientAdapter _detailAdapter() => FakeHttpClientAdapter()
  ..on(
    'GET',
    '/v1/subjects/subject',
    (_) => FakeResponse(200, {
      'subject': subjectDetailJson(
        'subject',
        name: '情報処理演習',
        syllabus: syllabusJson(
          id: 'lesson',
          fields: {'summary': 'プログラミングの基礎を学ぶ'},
        ),
      ),
    }),
  )
  ..on(
    'GET',
    '/v1/users',
    (_) => const FakeResponse(200, {'user': <String, Object?>{}}),
  );

Future<void> _pump(
  WidgetTester tester,
  Widget child, {
  FakeHttpClientAdapter? adapter,
  FakeSubjectDataSource? subjectDataSource,
  AuthAccount? currentAccount,
  Map<String, List<String>> pastExams = const {},
}) async {
  await tester.pumpWidget(
    ProviderScope(
      retry: (_, _) => null,
      overrides: [
        apiClientProvider.overrideWithValue(
          Openapi(dio: fakeDio(adapter ?? _detailAdapter())),
        ),
        authDataSourceProvider.overrideWithValue(
          FakeAuthDataSource(currentAccount: currentAccount),
        ),
        subjectDataSourceProvider.overrideWithValue(
          subjectDataSource ?? FakeSubjectDataSource(),
        ),
        pastExamDataSourceProvider.overrideWithValue(
          FakePastExamDataSource(pastExams),
        ),
      ],
      child: MaterialApp(theme: DottoTheme.v2, home: child),
    ),
  );
  await tester.pumpAndSettle();
}

SubjectDetailScreen _detail({
  SubjectDetailTab initialTab = SubjectDetailTab.syllabus,
  ValueChanged<String>? onPastExamSelected,
}) => SubjectDetailScreen(
  id: 'subject',
  initialTab: initialTab,
  onPastExamSelected: onPastExamSelected ?? (_) {},
);

void main() {
  testWidgets('科目名とシラバスを表示する', (tester) async {
    await _pump(tester, _detail());

    expect(find.text('情報処理演習'), findsOneWidget);
    expect(find.text('プログラミングの基礎を学ぶ'), findsOneWidget);
  });

  testWidgets('科目の取得に失敗したらエラーを表示する', (tester) async {
    await _pump(tester, _detail(), adapter: FakeHttpClientAdapter());

    expect(find.text('科目情報の読み込みに失敗しました。'), findsOneWidget);
  });

  group('レビュー', () {
    testWidgets('レビューがなければその旨を表示する', (tester) async {
      await _pump(tester, _detail(initialTab: SubjectDetailTab.reviews));

      expect(find.text('フィードバックがありません'), findsOneWidget);
    });

    testWidgets('平均評価と件数、コメントを表示する', (tester) async {
      final dataSource = FakeSubjectDataSource();
      await dataSource.writeFeedback(
        userId: 'a',
        lessonId: 'lesson',
        score: 5,
        comment: 'とても良い',
      );
      await dataSource.writeFeedback(
        userId: 'b',
        lessonId: 'lesson',
        score: 2,
        comment: '',
      );

      await _pump(
        tester,
        _detail(initialTab: SubjectDetailTab.reviews),
        subjectDataSource: dataSource,
      );

      expect(find.text('3.5'), findsOneWidget);
      expect(find.text('2件のフィードバック'), findsOneWidget);
      expect(find.text('とても良い'), findsOneWidget);
    });

    testWidgets('レビューの取得に失敗したらエラーを表示する', (tester) async {
      await _pump(
        tester,
        _detail(initialTab: SubjectDetailTab.reviews),
        subjectDataSource: FakeSubjectDataSource()..shouldFail = true,
      );

      expect(find.byType(ErrorView), findsOneWidget);
    });

    testWidgets('未ログインで投稿しようとするとログインを促す', (tester) async {
      await _pump(tester, _detail(initialTab: SubjectDetailTab.reviews));

      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();

      expect(find.text('Googleアカウント (@fun.ac.jp) による認証が必要です。'), findsOneWidget);
    });

    testWidgets('評価を選ばずに投稿すると入力を促す', (tester) async {
      await _pump(
        tester,
        _detail(initialTab: SubjectDetailTab.reviews),
        currentAccount: _account,
      );
      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();

      await tester.tap(find.text('投稿する'));
      await tester.pumpAndSettle();

      // 投稿画面と下の画面の両方の Scaffold に表示される
      expect(find.text('満足度を入力してください。'), findsWidgets);
    });

    testWidgets('評価とコメントを投稿すると一覧に反映する', (tester) async {
      await _pump(
        tester,
        _detail(initialTab: SubjectDetailTab.reviews),
        currentAccount: _account,
      );
      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.star).at(3));
      await tester.enterText(find.byType(TextFormField), '課題が多い');
      await tester.tap(find.text('投稿する'));
      await tester.pumpAndSettle();

      expect(find.text('フィードバックを投稿しました。'), findsOneWidget);
      expect(find.text('課題が多い'), findsOneWidget);
      expect(find.text('4.0'), findsOneWidget);
    });

    testWidgets('投稿を閉じると何も投稿しない', (tester) async {
      await _pump(
        tester,
        _detail(initialTab: SubjectDetailTab.reviews),
        currentAccount: _account,
      );
      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.close));
      await tester.pumpAndSettle();

      expect(find.text('フィードバックがありません'), findsOneWidget);
      expect(find.text('フィードバックを投稿しました。'), findsNothing);
    });
  });

  group('過去問', () {
    testWidgets('未ログインではログインを促す', (tester) async {
      await _pump(tester, _detail(initialTab: SubjectDetailTab.pastExams));

      expect(find.text('Googleアカウント (@fun.ac.jp) による認証が必要です'), findsOneWidget);
    });

    testWidgets('過去問がなければその旨を表示する', (tester) async {
      await _pump(
        tester,
        _detail(initialTab: SubjectDetailTab.pastExams),
        currentAccount: _account,
      );

      expect(find.text('過去問はありません'), findsOneWidget);
    });

    testWidgets('過去問をファイル名で一覧し、選ぶとオブジェクトキーを通知する', (tester) async {
      String? selected;
      await _pump(
        tester,
        _detail(
          initialTab: SubjectDetailTab.pastExams,
          onPastExamSelected: (key) => selected = key,
        ),
        currentAccount: _account,
        pastExams: {
          _pastExamId: ['$_pastExamId/2024_期末.pdf'],
        },
      );

      await tester.tap(find.text('2024_期末.pdf'));

      expect(selected, '$_pastExamId/2024_期末.pdf');
    });
  });

  testWidgets('レビュー投稿画面を科目のシラバスIDで開く', (tester) async {
    final dataSource = FakeSubjectDataSource();
    await _pump(
      tester,
      const SubjectReviewNewScreen(id: 'subject'),
      subjectDataSource: dataSource,
      currentAccount: _account,
    );

    await tester.tap(find.byIcon(Icons.star).last);
    await tester.tap(find.text('投稿する'));
    await tester.pumpAndSettle();

    expect(await dataSource.readFeedbacks('lesson'), hasLength(1));
  });
}
