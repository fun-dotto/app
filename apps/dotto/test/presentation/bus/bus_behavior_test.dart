import 'dart:async';

import 'package:dotto/data/bus_data_source.dart';
import 'package:dotto/domain/entity/bus_trip_id.dart';
import 'package:dotto/domain/entity/domain_error.dart';
import 'package:dotto/presentation/bus/bus_initial_direction_state.dart';
import 'package:dotto/presentation/bus/bus_initial_weekday_state.dart';
import 'package:dotto/presentation/bus/bus_schedule_state.dart';
import 'package:dotto/presentation/bus/bus_screen.dart';
import 'package:dotto/presentation/bus/bus_trip_screen.dart';
import 'package:dotto/presentation/bus/selected_bus_stop_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import '../../helpers/fake_bus_data_source.dart';

void main() {
  ProviderContainer createContainer(FakeBusDataSource source) {
    final container = ProviderContainer(
      retry: (_, _) => null,
      overrides: [busDataSourceProvider.overrideWithValue(source)],
    );
    addTearDown(container.dispose);
    return container;
  }

  testWidgets('画面内で方向を切り替えられる', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          busDataSourceProvider.overrideWithValue(FakeBusDataSource()),
        ],
        child: const MaterialApp(home: BusScreen()),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('08:00 → 08:30'), findsOneWidget);
    await tester.tap(find.byIcon(Icons.swap_vert_outlined));
    await tester.pumpAndSettle();
    expect(find.text('08:00 → 08:30'), findsNothing);
  });

  testWidgets('方向変更後に位置情報が届いてもユーザーの選択を維持する', (tester) async {
    final location = Completer<bool>();
    final source = FakeBusDataSource()..nearUniversityResult = location.future;
    await tester.pumpWidget(
      ProviderScope(
        overrides: [busDataSourceProvider.overrideWithValue(source)],
        child: const MaterialApp(home: BusScreen()),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('08:00 → 08:30'), findsOneWidget);
    await tester.tap(find.byIcon(Icons.swap_vert_outlined));
    await tester.pumpAndSettle();
    expect(find.text('08:00 → 08:30'), findsNothing);

    location.complete(false);
    await tester.pumpAndSettle();

    expect(find.text('08:00 → 08:30'), findsNothing);
  });

  testWidgets('休日タブ選択後に祝日情報が届いても選択を維持する', (tester) async {
    final holidays = Completer<Set<String>>();
    final source = FakeBusDataSource()..holidayDatesResult = holidays.future;
    await tester.pumpWidget(
      ProviderScope(
        overrides: [busDataSourceProvider.overrideWithValue(source)],
        child: const MaterialApp(home: BusScreen()),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('08:00 → 08:30'), findsOneWidget);
    await tester.tap(find.text('休日'));
    await tester.pumpAndSettle();
    expect(find.text('08:00 → 08:30'), findsNothing);

    holidays.complete({});
    await tester.pumpAndSettle();

    expect(find.text('08:00 → 08:30'), findsNothing);
  });

  testWidgets('スワイプで休日へ移動した後も遅れて届く初期値を適用しない', (tester) async {
    final holidays = Completer<Set<String>>();
    final source = FakeBusDataSource()..holidayDatesResult = holidays.future;
    await tester.pumpWidget(
      ProviderScope(
        overrides: [busDataSourceProvider.overrideWithValue(source)],
        child: const MaterialApp(home: BusScreen()),
      ),
    );
    await tester.pumpAndSettle();
    await tester.drag(find.byType(TabBarView), const Offset(-700, 0));
    await tester.pumpAndSettle();
    expect(find.text('08:00 → 08:30'), findsNothing);

    holidays.complete({});
    await tester.pumpAndSettle();

    expect(find.text('08:00 → 08:30'), findsNothing);
  });

  testWidgets('不正な便IDでは見つからない案内を表示する', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          busDataSourceProvider.overrideWithValue(FakeBusDataSource()),
        ],
        child: const MaterialApp(home: BusTripScreen(id: 'invalid')),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('この便の情報が見つかりませんでした。'), findsOneWidget);
  });

  test('便IDから乗降時刻と乗り場を取得できる', () async {
    final container = createContainer(FakeBusDataSource());
    final schedule = await container.read(busScheduleStateProvider.future);
    final trip = schedule.tripOf(
      const BusTripId(isTo: true, isWeekday: true, index: 0),
    );
    expect(trip?.route, '55');
    expect(trip?.stops.first.time, const Duration(hours: 8));
    expect(trip?.stops.first.terminal, 2);
    expect(trip?.stops.last.time, const Duration(hours: 8, minutes: 30));
  });

  test('選択バス停を経由しない便は亀田支所前で乗降する', () async {
    final container = createContainer(FakeBusDataSource());
    final schedule = await container.read(busScheduleStateProvider.future);
    final trip = schedule.tripsOf(isTo: true, isWeekday: true).first;
    final outbound = trip.leg(selectedStopId: 1, isTo: true);
    expect(outbound?.from.stop.id, 14013);
    expect(outbound?.to.stop.id, 14023);
    expect(outbound?.isFallback, isTrue);
    final inbound = trip.leg(selectedStopId: 1, isTo: false);
    expect(inbound?.from.stop.id, 14023);
    expect(inbound?.to.stop.id, 14013);
  });

  test('選択バス停を保存して次回の画面表示で復元できる', () async {
    final source = FakeBusDataSource();
    final container = createContainer(source);
    final subscription = container.listen(
      selectedBusStopStateProvider,
      (_, _) {},
    );
    addTearDown(subscription.close);
    final schedule = await container.read(busScheduleStateProvider.future);
    await container.read(selectedBusStopStateProvider.future);
    final stop = schedule.allStops.last;
    await container
        .read(selectedBusStopStateProvider.notifier)
        .selectBusStop(stop);
    expect(container.read(selectedBusStopStateProvider).value, stop);
    final nextContainer = createContainer(source);
    expect(await nextContainer.read(selectedBusStopStateProvider.future), stop);
  });

  test('祝日は休日ダイヤで大学付近では大学発を初期表示する', () async {
    final source = FakeBusDataSource()
      ..holidays = {'2026-10-08'}
      ..isNear = true;
    final container = createContainer(source);
    expect(
      await container.read(busInitialWeekdayStateProvider.future),
      isFalse,
    );
    expect(
      await container.read(busInitialDirectionStateProvider.future),
      isFalse,
    );
  });

  test('未登録バス停を参照する時刻表はドメインエラーになる', () async {
    final source = FakeBusDataSource()..hasInvalidTrip = true;
    final container = createContainer(source);
    await expectLater(
      container.read(busScheduleStateProvider.future),
      throwsA(isA<DomainError>()),
    );
  });

  test('不正な便IDと範囲外の便IDは対象便を返さない', () async {
    final container = createContainer(FakeBusDataSource());
    final schedule = await container.read(busScheduleStateProvider.future);
    expect(BusTripId.tryParse('to_fun-weekday--1'), isNull);
    expect(BusTripId.tryParse('unknown-weekday-0'), isNull);
    expect(
      schedule.tripOf(const BusTripId(isTo: true, isWeekday: true, index: 9)),
      isNull,
    );
  });
}
