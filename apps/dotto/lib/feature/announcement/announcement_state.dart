import 'dart:async';

import 'package:dotto/domain/announcement.dart';
import 'package:dotto/foundation/async_entity.dart';
import 'package:dotto/foundation/async_status.dart';
import 'package:dotto/repository/announcement_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'announcement_state.g.dart';

@riverpod
final class AnnouncementState extends _$AnnouncementState {
  @override
  AsyncEntity<List<Announcement>> build() {
    unawaited(Future.microtask(_load));
    return const AsyncEntity();
  }

  Future<List<Announcement>> _fetch() {
    return ref.read(announcementRepositoryProvider).getAnnouncements();
  }

  Future<void> _load({AsyncStatus status = AsyncStatus.loading}) async {
    state = state.copyWith(status: status);
    try {
      final entity = await _fetch();
      state = state.copyWith(status: AsyncStatus.success, entity: entity);
    } on Object catch (error) {
      state = state.copyWith(status: AsyncStatus.failure, error: error);
    }
  }

  Future<void> refresh() => _load(status: AsyncStatus.refreshing);
}
