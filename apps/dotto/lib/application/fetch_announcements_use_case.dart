import 'package:dotto/data/announcement_repository_impl.dart';
import 'package:dotto/domain/entity/announcement.dart';
import 'package:dotto/domain/repository/announcement_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'fetch_announcements_use_case.g.dart';

final class FetchAnnouncementsUseCase {
  const new(this._repository);

  final AnnouncementRepository _repository;

  Future<List<Announcement>> call() => _repository.fetchAll();
}

@riverpod
FetchAnnouncementsUseCase fetchAnnouncementsUseCase(Ref ref) =>
    FetchAnnouncementsUseCase(ref.watch(announcementRepositoryProvider));
