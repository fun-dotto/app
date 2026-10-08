import 'package:dotto/api/api_client.dart';
import 'package:dotto/domain/entity/announcement.dart';
import 'package:dotto/domain/entity/domain_error.dart';
import 'package:dotto/domain/repository/announcement_repository.dart';
import 'package:openapi/openapi.dart' hide Announcement;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'announcement_repository_impl.g.dart';

@riverpod
AnnouncementRepository announcementRepository(Ref ref) =>
    AnnouncementRepositoryImpl(ref.watch(apiClientProvider));

final class AnnouncementRepositoryImpl implements AnnouncementRepository {
  const new(this._apiClient);

  final Openapi _apiClient;

  @override
  Future<List<Announcement>> fetchAll() async {
    try {
      final response = await _apiClient
          .getAnnouncementsApi()
          .announcementsV1List();
      final data = response.data;
      if (data == null) {
        throw const DomainError(
          type: DomainErrorType.invalidResponse,
          message: 'Failed to get announcements',
        );
      }
      return List.unmodifiable(
        data.announcements.map(
          (e) =>
              Announcement(id: e.id, title: e.title, date: e.date, url: e.url),
        ),
      );
    } on DomainError {
      rethrow;
    } on Exception catch (e, stackTrace) {
      throw DomainError.fromException(e: e, stackTrace: stackTrace);
    }
  }
}
