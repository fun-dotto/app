import 'package:dotto/domain/announcement.dart';
import 'package:dotto/foundation/container/async_entity.dart';
import 'package:dotto/foundation/container/async_entity_notifier.dart';
import 'package:dotto/repository/announcement_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'announcement_state.g.dart';

@riverpod
final class AnnouncementState extends _$AnnouncementState
    with AsyncEntityNotifierMixin<List<Announcement>> {
  @override
  AsyncEntity<List<Announcement>> build() => initialState();

  @override
  Future<List<Announcement>> fetch() =>
      ref.read(announcementRepositoryProvider).getAnnouncements();
}
