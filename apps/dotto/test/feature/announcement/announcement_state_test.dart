import 'dart:async';

import 'package:dotto/domain/announcement.dart';
import 'package:dotto/feature/announcement/announcement_state.dart';
import 'package:dotto/foundation/async_status.dart';
import 'package:dotto/repository/announcement_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

final class FakeAnnouncementRepository implements AnnouncementRepository {
  FakeAnnouncementRepository();

  Completer<List<Announcement>> _completer = Completer<List<Announcement>>();
  int callCount = 0;

  void resolve(List<Announcement> value) {
    _completer.complete(value);
    _completer = Completer<List<Announcement>>();
  }

  void fail(Object error) {
    _completer.completeError(error);
    _completer = Completer<List<Announcement>>();
  }

  @override
  Future<List<Announcement>> getAnnouncements() {
    callCount++;
    return _completer.future;
  }
}

void main() {
  ProviderContainer createContainer(FakeAnnouncementRepository repository) {
    final container = ProviderContainer(
      overrides: [announcementRepositoryProvider.overrideWithValue(repository)],
    );
    addTearDown(container.dispose);
    return container;
  }

  final sampleAnnouncements = [
    Announcement(
      id: '1',
      title: 'お知らせ1',
      date: DateTime(2026, 6, 23),
      url: 'https://example.com/1',
    ),
  ];

  test(
    'build 直後は status=idle の AsyncEntity を返し、microtask で loading に遷移する',
    () async {
      final repository = FakeAnnouncementRepository();
      final container = createContainer(repository);

      final initial = container.read(announcementStateProvider);
      expect(initial.status, AsyncStatus.idle);
      expect(initial.entity, isNull);

      // microtask での初回ロードがスケジュールされていること
      await Future<void>.value();
      expect(repository.callCount, 1);

      final loading = container.read(announcementStateProvider);
      expect(loading.status, AsyncStatus.loading);
      expect(loading.entity, isNull);
    },
  );

  test('fetch 成功時に status=success と entity が反映される', () async {
    final repository = FakeAnnouncementRepository();
    final container = createContainer(repository);

    container.read(announcementStateProvider);
    await Future<void>.value();
    repository.resolve(sampleAnnouncements);
    await Future<void>.value();

    final state = container.read(announcementStateProvider);
    expect(state.status, AsyncStatus.success);
    expect(state.entity, sampleAnnouncements);
    expect(state.error, isNull);
  });

  test('fetch 失敗時に status=failure と error が反映される', () async {
    final repository = FakeAnnouncementRepository();
    final container = createContainer(repository);
    final error = Exception('network');

    container.read(announcementStateProvider);
    await Future<void>.value();
    repository.fail(error);
    await Future<void>.value();

    final state = container.read(announcementStateProvider);
    expect(state.status, AsyncStatus.failure);
    expect(state.error, error);
    expect(state.entity, isNull);
  });

  test('refresh は status=refreshing → success と遷移し、前回の entity を保持する', () async {
    final repository = FakeAnnouncementRepository();
    final container = createContainer(repository);

    container.read(announcementStateProvider);
    await Future<void>.value();
    repository.resolve(sampleAnnouncements);
    await Future<void>.value();

    final notifier = container.read(announcementStateProvider.notifier);
    final refreshFuture = notifier.refresh();

    final refreshing = container.read(announcementStateProvider);
    expect(refreshing.status, AsyncStatus.refreshing);
    expect(refreshing.entity, sampleAnnouncements);

    final updated = [
      ...sampleAnnouncements,
      Announcement(
        id: '2',
        title: 'お知らせ2',
        date: DateTime(2026, 6, 24),
        url: 'https://example.com/2',
      ),
    ];
    repository.resolve(updated);
    await refreshFuture;

    final state = container.read(announcementStateProvider);
    expect(state.status, AsyncStatus.success);
    expect(state.entity, updated);
    expect(repository.callCount, 2);
  });

  test('refresh 失敗時は status=failure と error が反映される', () async {
    final repository = FakeAnnouncementRepository();
    final container = createContainer(repository);

    container.read(announcementStateProvider);
    await Future<void>.value();
    repository.resolve(sampleAnnouncements);
    await Future<void>.value();

    final notifier = container.read(announcementStateProvider.notifier);
    final error = Exception('refresh failed');
    final refreshFuture = notifier.refresh();
    repository.fail(error);
    await refreshFuture;

    final state = container.read(announcementStateProvider);
    expect(state.status, AsyncStatus.failure);
    expect(state.error, error);
  });
}
