import 'package:dotto/data/api_client.dart';
import 'package:dotto/data/auth_data_source.dart';
import 'package:dotto/data/clock.dart';
import 'package:dotto/data/remote_config_data_source.dart';
import 'package:dotto/domain/entity/auth_account.dart';
import 'package:dotto/domain/entity/flags.dart';
import 'package:dotto/domain/service/timetable_date_service.dart';
import 'package:dotto/foundation/config/remote_configs.dart';
import 'package:dotto/foundation/log/logger.dart';
import 'package:dotto/helper/date_formatter.dart';
import 'package:dotto/helper/datetime.dart';
import 'package:dotto/presentation/course/course_screen.dart';
import 'package:dotto_design_system/style/theme.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:material_ui/material_ui.dart';
import 'package:openapi/openapi.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../helpers/fake_auth_data_source.dart';
import '../../helpers/fake_http_client_adapter.dart';
import '../../helpers/fake_logger.dart';
import '../../helpers/fake_remote_config_data_source.dart';
import '../../helpers/fake_url_launcher.dart';
import '../../helpers/route_recorder.dart';
import '../../helpers/subject_json.dart';

const _account = AuthAccount(
  id: 'uid',
  name: '未来 太郎',
  email: 'b1000000@fun.ac.jp',
  avatarUrl: '',
);

/// 画面が初期表示する日付。画面は実時刻を使うため、時計も実時刻に揃える。
final DateTime _today = const TimetableDateService().initialDate(
  DateTime.now(),
);

FakeHttpClientAdapter _adapter({List<Map<String, Object?>> items = const []}) =>
    FakeHttpClientAdapter()
      ..on(
        'GET',
        '/v1/users',
        (_) => const FakeResponse(200, {'user': <String, Object?>{}}),
      )
      ..on(
        'GET',
        '/v1/personalCalendarItems',
        (_) => FakeResponse(200, {'personalCalendarItems': items}),
      );

Future<FakeUrlLauncher> _pump(
  WidgetTester tester, {
  FakeHttpClientAdapter? adapter,
  AuthAccount? currentAccount,
  AuthAccount? accountToSignIn,
  Map<String, Object?> remoteConfig = const {},
  bool canOpenUrl = true,
}) async {
  SharedPreferences.setMockInitialValues({});
  final launcher = FakeUrlLauncher(canOpen: canOpenUrl)..install(addTearDown);
  await tester.pumpWidget(
    ProviderScope(
      retry: (_, _) => null,
      overrides: [
        apiClientProvider.overrideWithValue(
          Openapi(dio: fakeDio(adapter ?? _adapter())),
        ),
        authDataSourceProvider.overrideWithValue(
          FakeAuthDataSource(
            currentAccount: currentAccount,
            accountToSignIn: accountToSignIn,
          ),
        ),
        clockProvider.overrideWithValue(DateTime.now),
        loggerProvider.overrideWithValue(FakeLogger()),
        remoteConfigDataSourceProvider.overrideWithValue(
          FakeRemoteConfigDataSource()..values.addAll(remoteConfig),
        ),
      ],
      child: MaterialApp.router(
        theme: DottoTheme.v2,
        routerConfig: routeRecorder(
          const CourseScreen(),
          childPaths: const [
            'preferences',
            'personal-weekly-timetable',
            'subjects',
            'subjects/:id/syllabus',
            'notice/cancellations',
            'calendars/:year',
            'timetables/:year/spring',
            'timetables/:year/fall',
          ],
        ),
      ),
    ),
  );
  await tester.pumpAndSettle();
  return launcher;
}

Future<void> _tapAndSettle(WidgetTester tester, Finder finder) async {
  await tester.ensureVisible(finder);
  await tester.pumpAndSettle();
  await tester.tap(finder);
  await tester.pumpAndSettle();
}

void main() {
  setUpAll(() => initializeDateFormatting('ja'));

  group('未ログイン', () {
    testWidgets('ログインを促し、ログインが必要なリンクを表示しない', (tester) async {
      await _pump(tester);

      expect(find.text('ログインして時間割機能を使う'), findsOneWidget);
      expect(find.text('HOPE'), findsOneWidget);
      expect(find.text('学生ポータル'), findsOneWidget);
      expect(find.text('Macサポート'), findsNothing);
      expect(find.text('休講・補講'), findsNothing);
    });

    testWidgets('ログインすると時間割を表示する', (tester) async {
      await _pump(tester, accountToSignIn: _account);

      await _tapAndSettle(tester, find.text('ログインして時間割機能を使う'));

      expect(find.text('1週間の時間割'), findsOneWidget);
      expect(find.text('Macサポート'), findsOneWidget);
    });
  });

  group('ログイン中', () {
    testWidgets('今日の時間割に休講と教室を表示する', (tester) async {
      await _pump(
        tester,
        currentAccount: _account,
        adapter: _adapter(
          items: [
            {
              'date': DateFormatter.date(_today),
              'period': 'Period2',
              'status': 'Cancelled',
              'subject': subjectSummaryJson('a', name: 'プログラミング'),
              'rooms': [
                {'id': '301', 'name': '情報工房', 'floor': 'Floor3'},
              ],
            },
          ],
        ),
      );

      expect(find.text('プログラミング'), findsOneWidget);
      expect(find.text('休講'), findsOneWidget);
      expect(find.text('情報工房'), findsOneWidget);
    });

    testWidgets('時間割の科目を選ぶとシラバスへ遷移する', (tester) async {
      await _pump(
        tester,
        currentAccount: _account,
        adapter: _adapter(
          items: [
            {
              'date': DateFormatter.date(_today),
              'period': 'Period1',
              'status': 'Normal',
              'subject': subjectSummaryJson('a', name: 'プログラミング'),
              'rooms': <Object>[],
            },
          ],
        ),
      );

      await _tapAndSettle(tester, find.text('プログラミング'));

      expect(find.text('/course/subjects/a/syllabus'), findsOneWidget);
    });

    testWidgets('別の日付を選ぶとその日の時間割を表示する', (tester) async {
      // 同じ週の別の平日を選ぶ
      final nextDay = _today.add(
        Duration(days: _today.weekday == DateTime.monday ? 1 : -1),
      );
      await _pump(
        tester,
        currentAccount: _account,
        adapter: _adapter(
          items: [
            {
              'date': DateFormatter.date(nextDay),
              'period': 'Period1',
              'status': 'Makeup',
              'subject': subjectSummaryJson('b', name: '線形代数'),
              'rooms': <Object>[],
            },
          ],
        ),
      );
      expect(find.text('線形代数'), findsNothing);

      await tester.tap(find.text(DateFormatter.dayOfMonth(nextDay)).first);
      await tester.pumpAndSettle();

      expect(find.text('線形代数'), findsOneWidget);
      expect(find.text('補講'), findsOneWidget);
    });

    testWidgets('時間割の取得に失敗したらエラーを表示する', (tester) async {
      final adapter = _adapter()
        ..on(
          'GET',
          '/v1/personalCalendarItems',
          (_) => const FakeResponse(500),
        );

      await _pump(tester, currentAccount: _account, adapter: adapter);

      expect(find.text('データの取得に失敗しました'), findsOneWidget);
    });

    testWidgets('1週間の時間割へ遷移する', (tester) async {
      await _pump(tester, currentAccount: _account);

      await _tapAndSettle(tester, find.text('1週間の時間割'));

      expect(find.text('/course/personal-weekly-timetable'), findsOneWidget);
    });

    testWidgets('休講・補講の一覧へ遷移する', (tester) async {
      await _pump(tester, currentAccount: _account);

      await _tapAndSettle(tester, find.text('休講・補講'));

      expect(find.text('/course/notice/cancellations'), findsOneWidget);
    });

    testWidgets('フラグが有効なときだけ Dotto Web と大学ポストを表示する', (tester) async {
      final launcher = await _pump(
        tester,
        currentAccount: _account,
        remoteConfig: {
          Flags.web.key: true,
          Flags.opinionBox.key: true,
          RemoteConfigs.dottoWebUrl.key: 'https://web.example.com',
          RemoteConfigs.opinionBoxUrl.key: 'https://post.example.com',
          RemoteConfigs.macSupportDeskUrl.key: 'https://mac.example.com',
        },
      );

      await _tapAndSettle(tester, find.text('Dotto Web'));
      await _tapAndSettle(tester, find.text('大学ポスト'));
      await _tapAndSettle(tester, find.text('Macサポート'));

      expect(launcher.openedUrls, [
        'https://web.example.com',
        'https://post.example.com',
        'https://mac.example.com',
      ]);
    });
  });

  testWidgets('科目検索が有効なときは科目検索へ遷移できる', (tester) async {
    await _pump(tester, remoteConfig: {Flags.funch.key: true});

    await _tapAndSettle(tester, find.text('科目検索'));

    expect(find.text('/course/subjects'), findsOneWidget);
  });

  testWidgets('学年歴を今年度で開く', (tester) async {
    final year = DateTimeUtility.academicYear(DateTime.now());
    await _pump(tester);

    await _tapAndSettle(tester, find.text('学年歴'));

    expect(find.text('/course/calendars/$year'), findsOneWidget);
  });

  testWidgets('前期の時間割を今年度で開く', (tester) async {
    final year = DateTimeUtility.academicYear(DateTime.now());
    await _pump(tester);

    await _tapAndSettle(tester, find.text('時間割 前期'));

    expect(find.text('/course/timetables/$year/spring'), findsOneWidget);
  });

  testWidgets('後期の時間割を今年度で開く', (tester) async {
    final year = DateTimeUtility.academicYear(DateTime.now());
    await _pump(tester);

    await _tapAndSettle(tester, find.text('時間割 後期'));

    expect(find.text('/course/timetables/$year/fall'), findsOneWidget);
  });

  testWidgets('カスタマイズ画面へ遷移する', (tester) async {
    await _pump(tester);

    await _tapAndSettle(tester, find.byIcon(Icons.tune));

    expect(find.text('/course/preferences'), findsOneWidget);
  });

  testWidgets('外部リンクを開く', (tester) async {
    final launcher = await _pump(tester);

    await _tapAndSettle(tester, find.text('学生ポータル'));

    expect(launcher.openedUrls, ['https://students.fun.ac.jp/Portal']);
  });

  testWidgets('外部リンクを開けなければ通知する', (tester) async {
    await _pump(tester, canOpenUrl: false);

    await _tapAndSettle(tester, find.text('HOPE'));

    expect(find.text('HOPE を開けませんでした'), findsOneWidget);
  });

  testWidgets('緊急告知を表示し、選ぶとリンクを開く', (tester) async {
    final launcher = await _pump(
      tester,
      remoteConfig: {
        RemoteConfigs.breakingAnnouncement.key: {
          'title': 'システムメンテナンスのお知らせ',
          'url': 'https://example.com/news',
          'is_external': true,
        },
      },
    );

    await _tapAndSettle(tester, find.text('システムメンテナンスのお知らせ'));

    expect(launcher.openedUrls, ['https://example.com/news']);
  });
}
