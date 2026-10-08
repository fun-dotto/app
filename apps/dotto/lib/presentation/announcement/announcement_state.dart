import 'package:dotto/application/fetch_announcements_use_case.dart';
import 'package:dotto/domain/announcement.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'announcement_state.g.dart';

@riverpod
final class AnnouncementState extends _$AnnouncementState {
  @override
  Future<List<Announcement>> build() =>
      ref.watch(fetchAnnouncementsUseCaseProvider)();

  /// 表示中の一覧を残したまま再取得する。
  Future<void> refresh() async {
    state = await AsyncValue.guard(
      ref.read(fetchAnnouncementsUseCaseProvider).call,
    );
  }
}
