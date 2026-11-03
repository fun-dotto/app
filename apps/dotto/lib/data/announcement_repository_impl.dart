import 'package:dotto/data/app_api_transport.dart';
import 'package:dotto/data/domain_error_mapper.dart';
import 'package:dotto/domain/entity/announcement.dart';
import 'package:dotto/domain/entity/domain_error.dart';
import 'package:dotto/domain/repository/announcement_repository.dart';
import 'package:dotto_app_api/app/v1/announcement.connect.client.dart';
import 'package:dotto_app_api/app/v1/announcement.pb.dart' as api;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'announcement_repository_impl.g.dart';

@riverpod
AnnouncementRepository announcementRepository(Ref ref) =>
    AnnouncementRepositoryImpl(
      AnnouncementServiceClient(ref.watch(appApiTransportProvider)),
    );

final class AnnouncementRepositoryImpl implements AnnouncementRepository {
  const new(this._client);

  final AnnouncementServiceClient _client;

  @override
  Future<List<Announcement>> fetchAll() async {
    try {
      final response = await _client.listAnnouncements(
        api.ListAnnouncementsRequest(),
      );
      return List.unmodifiable(
        response.announcements.map(
          (e) => Announcement(
            id: e.id,
            title: e.title,
            date: e.availableFrom.toDateTime(toLocal: true),
            url: e.url,
          ),
        ),
      );
    } on DomainError {
      rethrow;
    } on Exception catch (e, stackTrace) {
      throw mapDomainError(e: e, stackTrace: stackTrace);
    }
  }
}
