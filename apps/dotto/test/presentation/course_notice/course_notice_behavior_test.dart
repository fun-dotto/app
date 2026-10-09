import 'package:dotto/data/api_client.dart';
import 'package:dotto/data/auth_data_source.dart';
import 'package:dotto/data/course_notice_clock.dart';
import 'package:dotto/domain/entity/auth_account.dart';
import 'package:dotto/domain/entity/course_notice.dart';
import 'package:dotto/domain/entity/course_notice_scope.dart';
import 'package:dotto/domain/entity/domain_error.dart';
import 'package:dotto/presentation/course_notice/course_cancellation_screen.dart';
import 'package:dotto/presentation/course_notice/course_notices_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import '../../helpers/fake_auth_data_source.dart';
import '../../helpers/fake_course_notice_server.dart';

void main() {
  ProviderContainer createContainer(FakeCourseNoticeServer server) {
    final container = ProviderContainer(
      retry: (_, _) => null,
      overrides: [
        apiClientProvider.overrideWithValue(server.apiClient),
        courseNoticeClockProvider.overrideWithValue(() => DateTime(2026, 4)),
      ],
    );
    addTearDown(container.dispose);
    return container;
  }

  test('履修中の科目に紐づく三種類の通知を取得する', () async {
    final container = createContainer(FakeCourseNoticeServer());
    final notices = await container.read(
      courseNoticesStateProvider(CourseNoticeScope.registered).future,
    );
    expect(notices, hasLength(3));
    expect(notices.every((notice) => notice.subject.id == 's1'), isTrue);
    expect(notices.whereType<CancellationNotice>(), hasLength(1));
    expect(notices.whereType<MakeupNotice>(), hasLength(1));
    final change = notices.whereType<RoomChangeNotice>().single;
    expect(change.originalRoomName, 'R101');
    expect(change.newRoomName, 'R202');
    expect(change.periodNumber, 3);
    expect(change.date, DateTime(2026, 4, 3));
  });

  test('全件表示では履修していない科目の通知も取得する', () async {
    final container = createContainer(FakeCourseNoticeServer());
    final notices = await container.read(
      courseNoticesStateProvider(CourseNoticeScope.all).future,
    );
    expect(notices.whereType<CancellationNotice>(), hasLength(2));
    expect(notices.any((notice) => notice.subject.id == 's2'), isTrue);
  });

  test('履修科目がないときは履修中の通知を表示しない', () async {
    final server = FakeCourseNoticeServer()..registeredSubjectIds = [];
    final container = createContainer(server);
    expect(
      await container.read(
        courseNoticesStateProvider(CourseNoticeScope.registered).future,
      ),
      isEmpty,
    );
  });

  test('更新後の授業変更通知を再取得する', () async {
    final server = FakeCourseNoticeServer();
    final container = createContainer(server);
    final provider = courseNoticesStateProvider(CourseNoticeScope.registered);
    final subscription = container.listen(provider, (_, _) {});
    addTearDown(subscription.close);
    await container.read(provider.future);
    server.cancellations = [];
    await container.read(provider.notifier).refresh();
    expect(
      container.read(provider).requireValue.whereType<CancellationNotice>(),
      isEmpty,
    );
    expect(
      container.read(provider).requireValue.whereType<MakeupNotice>(),
      hasLength(1),
    );
  });

  test('通信失敗をドメインエラーとして表示状態へ反映する', () async {
    final server = FakeCourseNoticeServer()..shouldFail = true;
    final container = createContainer(server);
    await expectLater(
      container.read(courseNoticesStateProvider(CourseNoticeScope.all).future),
      throwsA(isA<DomainError>()),
    );
  });

  Future<void> pumpScreen(
    WidgetTester tester, {
    AuthAccount? account,
    CourseNoticeTab tab = CourseNoticeTab.cancellations,
  }) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          apiClientProvider.overrideWithValue(
            FakeCourseNoticeServer().apiClient,
          ),
          authDataSourceProvider.overrideWithValue(
            FakeAuthDataSource(currentAccount: account),
          ),
          courseNoticeClockProvider.overrideWithValue(() => DateTime(2026, 4)),
        ],
        child: MaterialApp(home: CourseCancellationScreen(initialTab: tab)),
      ),
    );
    await tester.pumpAndSettle();
  }

  const account = AuthAccount(
    id: 'uid',
    name: '学生',
    email: 'student@fun.ac.jp',
    avatarUrl: '',
  );

  testWidgets('未ログインではログイン案内を表示する', (tester) async {
    await pumpScreen(tester);
    expect(find.text('Googleアカウント(@fun.ac.jp)ログインが必要です。'), findsOneWidget);
  });

  testWidgets('履修中の通知から全件表示へ切り替えられる', (tester) async {
    await pumpScreen(tester, account: account);
    expect(find.text('数学'), findsOneWidget);
    expect(find.text('英語'), findsNothing);
    await tester.tap(find.text('履修中'));
    await tester.pumpAndSettle();
    expect(find.text('英語'), findsOneWidget);
    expect(find.text('休講連絡'), findsNWidgets(2));
  });

  testWidgets('指定された教室変更タブを最初に表示する', (tester) async {
    await pumpScreen(
      tester,
      account: account,
      tab: CourseNoticeTab.roomChanges,
    );
    expect(find.text('R101 → R202'), findsOneWidget);
  });
}
