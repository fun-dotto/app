import 'package:dotto/data/app_api_transport.dart';
import 'package:dotto/data/domain_error_mapper.dart';
import 'package:dotto/domain/entity/announcement.dart';
import 'package:dotto/domain/entity/domain_error.dart';
import 'package:dotto/domain/repository/announcement_repository.dart';
import 'package:dotto_app_api/app/v1/article.connect.client.dart';
import 'package:dotto_app_api/app/v1/article.pb.dart' as api;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'announcement_repository_impl.g.dart';

@riverpod
AnnouncementRepository announcementRepository(Ref ref) =>
    AnnouncementRepositoryImpl(
      ArticleServiceClient(ref.watch(appApiTransportProvider)),
    );

final class AnnouncementRepositoryImpl implements AnnouncementRepository {
  const new(this._client);

  final ArticleServiceClient _client;

  @override
  Future<List<Announcement>> fetchAll() async {
    try {
      final response = await _client.listArticles(api.ListArticlesRequest());
      return List.unmodifiable(
        response.articles.map(
          (e) => Announcement(
            id: e.id,
            title: e.title,
            date: e.publishTime.toDateTime(toLocal: true),
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
