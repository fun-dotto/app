import 'package:dotto/api/api_client.dart';
import 'package:dotto/data/clock.dart';
import 'package:dotto/domain/entity/domain_error.dart';
import 'package:dotto/domain/entity/lecture_status.dart';
import 'package:dotto/domain/entity/period.dart';
import 'package:dotto/presentation/course/course_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:openapi/openapi.dart';

import '../../helpers/fake_http_client_adapter.dart';

void main() {
  test('4週間の平日を取得して日付順に時間割を保持する', () async {
    final adapter = FakeHttpClientAdapter()
      ..on(
        'GET',
        '/v1/personalCalendarItems',
        (_) => const FakeResponse(200, {'personalCalendarItems': <Object?>[]}),
      );
    final container = ProviderContainer(
      retry: (_, _) => null,
      overrides: [
        apiClientProvider.overrideWithValue(Openapi(dio: fakeDio(adapter))),
        clockProvider.overrideWithValue(() => DateTime(2026, 4, 8)),
      ],
    );
    addTearDown(container.dispose);

    final days = await container.read(courseStateProvider.future);

    expect(days, hasLength(20));
    expect(days.first.date, DateTime(2026, 3, 30));
    expect(days.last.date, DateTime(2026, 4, 24));
    expect(days.every((day) => day.items.isEmpty), isTrue);
  });

  test('取得に失敗した後も再読み込みで時間割を復旧できる', () async {
    final adapter = FakeHttpClientAdapter()
      ..on('GET', '/v1/personalCalendarItems', (_) => const FakeResponse(500));
    final container = ProviderContainer(
      retry: (_, _) => null,
      overrides: [
        apiClientProvider.overrideWithValue(Openapi(dio: fakeDio(adapter))),
        clockProvider.overrideWithValue(() => DateTime(2026, 4, 8)),
      ],
    );
    addTearDown(container.dispose);
    final subscription = container.listen(courseStateProvider, (_, _) {});
    addTearDown(subscription.close);
    await expectLater(
      container.read(courseStateProvider.future),
      throwsA(isA<DomainError>()),
    );
    adapter.on(
      'GET',
      '/v1/personalCalendarItems',
      (_) => const FakeResponse(200, {'personalCalendarItems': <Object?>[]}),
    );

    await container.read(courseStateProvider.notifier).refresh();

    expect(container.read(courseStateProvider).requireValue, hasLength(20));
  });
  test('休講予定の時限と変更後教室を時間割へ反映する', () async {
    final adapter = FakeHttpClientAdapter()
      ..on(
        'GET',
        '/v1/personalCalendarItems',
        (_) => const FakeResponse(200, {
          'personalCalendarItems': [
            {
              'date': '2026-04-08',
              'period': 'Period3',
              'status': 'Cancelled',
              'subject': {
                'id': 'a',
                'name': 'プログラミング',
                'faculties': <Object?>[],
                'year': 2026,
                'semester': 'H1',
                'credit': 2,
              },
              'rooms': [
                {'id': '301', 'name': '情報工房', 'floor': 'Floor3'},
              ],
            },
          ],
        }),
      );
    final container = ProviderContainer(
      retry: (_, _) => null,
      overrides: [
        apiClientProvider.overrideWithValue(Openapi(dio: fakeDio(adapter))),
        clockProvider.overrideWithValue(() => DateTime(2026, 4, 8)),
      ],
    );
    addTearDown(container.dispose);

    final days = await container.read(courseStateProvider.future);
    final item = days
        .singleWhere((day) => day.date == DateTime(2026, 4, 8))
        .items
        .single;

    expect(item.period, Period.third);
    expect(item.lectureStatus, LectureStatus.cancelled);
    expect(item.roomName, '情報工房');
  });
}
