import 'package:dotto/data/app_api_transport.dart';
import 'package:dotto/data/clock.dart';
import 'package:dotto/domain/entity/domain_error.dart';
import 'package:dotto/domain/entity/lecture_status.dart';
import 'package:dotto/domain/entity/period.dart';
import 'package:dotto/presentation/course/course_state.dart';
import 'package:dotto_app_api/app/v1/common.pbenum.dart' as api;
import 'package:dotto_app_api/app/v1/personal_calendar_item.connect.spec.dart';
import 'package:dotto_app_api/app/v1/personal_calendar_item.pb.dart' as api;
import 'package:dotto_app_api/app/v1/room.pb.dart' as api;
import 'package:dotto_app_api/google/type/date.pb.dart' as api;
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../helpers/api_subject.dart';
import '../../helpers/fake_app_api_transport.dart';

void main() {
  test('4週間の平日を取得して日付順に時間割を保持する', () async {
    final transport = FakeAppApiTransport()
      ..on(
        PersonalCalendarItemService.listPersonalCalendarItems,
        (_) => api.ListPersonalCalendarItemsResponse(),
      );
    final container = ProviderContainer(
      retry: (_, _) => null,
      overrides: [
        appApiTransportProvider.overrideWithValue(transport),
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
    final transport = FakeAppApiTransport()
      ..fail(PersonalCalendarItemService.listPersonalCalendarItems);
    final container = ProviderContainer(
      retry: (_, _) => null,
      overrides: [
        appApiTransportProvider.overrideWithValue(transport),
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
    transport.on(
      PersonalCalendarItemService.listPersonalCalendarItems,
      (_) => api.ListPersonalCalendarItemsResponse(),
    );

    await container.read(courseStateProvider.notifier).refresh();

    expect(container.read(courseStateProvider).requireValue, hasLength(20));
  });
  test('休講予定の時限と変更後教室を時間割へ反映する', () async {
    final transport = FakeAppApiTransport()
      ..on(
        PersonalCalendarItemService.listPersonalCalendarItems,
        (_) => api.ListPersonalCalendarItemsResponse(
          personalCalendarItems: [
            api.PersonalCalendarItem(
              date: api.Date(year: 2026, month: 4, day: 8),
              period: api.Period.PERIOD_3,
              state: api.PersonalCalendarItem_State.STATE_CANCELLED,
              subject: apiSubjectSummary('a', name: 'プログラミング'),
              rooms: [
                api.Room(
                  id: '301',
                  name: '情報工房',
                  floor: api.RoomFloor.ROOM_FLOOR_3,
                ),
              ],
            ),
          ],
        ),
      );
    final container = ProviderContainer(
      retry: (_, _) => null,
      overrides: [
        appApiTransportProvider.overrideWithValue(transport),
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
