import 'package:dotto/data/room_data_source.dart';
import 'package:dotto/data/room_repository_impl.dart';
import 'package:dotto/domain/entity/day_of_week.dart';
import 'package:dotto/domain/entity/domain_error.dart';
import 'package:dotto/domain/entity/floor.dart';
import 'package:dotto/domain/entity/period.dart';
import 'package:dotto/presentation/map/map_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../helpers/fake_room_data_source.dart';

const Map<String, Object?> rooms = {
  '3': {
    '301': {
      'header': '情報工房',
      'classroom_no': '301',
      'detail': '田中研究室',
      'mail': 'TANAKA',
      'search_word_list': ['プログラミング'],
    },
  },
};
const Map<String, Object?> schedules = {
  '301': [
    {
      'begin_datetime': '2026-10-05T09:00:00',
      'end_datetime': '2026-10-05T10:30:00',
      'title': 'プログラミング演習',
    },
  ],
};

void main() {
  test('部屋情報と予定を取得して利用状況を表示できる', () async {
    final container = ProviderContainer(
      retry: (_, _) => null,
      overrides: [
        roomDataSourceProvider.overrideWithValue(
          const FakeRoomDataSource(rooms: rooms, schedules: schedules),
        ),
      ],
    );
    addTearDown(container.dispose);

    final result = await container.read(mapStateProvider.future);

    expect(result.single.name, '情報工房');
    expect(result.single.floor, Floor.third);
    expect(result.single.isInUse(DateTime(2026, 10, 5, 9)), isTrue);
    expect(result.single.isInUse(DateTime(2026, 10, 5, 11)), isFalse);
  });

  test('部屋名・教員名・メール・キーワードを検索できる', () async {
    final container = ProviderContainer(
      retry: (_, _) => null,
      overrides: [
        roomDataSourceProvider.overrideWithValue(
          const FakeRoomDataSource(rooms: rooms),
        ),
      ],
    );
    addTearDown(container.dispose);

    final result = await container.read(mapStateProvider.future);

    for (final query in ['301', '情報工房', '田中', ' tanaka ', 'プログラミング']) {
      expect(result.single.matchesQuery(query), isTrue);
    }
    expect(result.single.matchesQuery(''), isFalse);
    expect(result.single.matchesQuery('存在しない部屋'), isFalse);
  });

  test('授業予定から曜日と時限ごとの教室を取得できる', () async {
    const repository = RoomRepositoryImpl(
      FakeRoomDataSource(rooms: rooms, schedules: schedules),
    );

    final index = await repository.getRoomAssignmentIndex();

    expect(
      index.roomNamesBySlotAndTitle[(
        dayOfWeek: DayOfWeek.monday,
        period: Period.first,
        title: 'プログラミング演習',
      )],
      '301',
    );
  });

  test('外部取得の失敗をドメインエラーとして保持する', () async {
    final container = ProviderContainer(
      retry: (_, _) => null,
      overrides: [
        roomDataSourceProvider.overrideWithValue(
          FakeRoomDataSource(error: Exception('取得失敗')),
        ),
      ],
    );
    addTearDown(container.dispose);

    final subscription = container.listen(mapStateProvider, (_, _) {});
    addTearDown(subscription.close);
    await expectLater(
      container.read(mapStateProvider.future),
      throwsA(isA<DomainError>()),
    );
    expect(container.read(mapStateProvider), isA<AsyncError<Object?>>());
  });

  test('不正な外部データをドメインエラーとして返す', () async {
    const repository = RoomRepositoryImpl(
      FakeRoomDataSource(
        rooms: {
          '3': {
            '301': {'header': 3},
          },
        },
      ),
    );

    await expectLater(repository.getRooms(), throwsA(isA<DomainError>()));
  });
}
