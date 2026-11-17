import 'package:dotto/data/app_api_transport.dart';
import 'package:dotto/domain/entity/domain_error.dart';
import 'package:dotto/presentation/announcement/announcement_state.dart';
import 'package:dotto_app_api/app/v1/article.connect.spec.dart';
import 'package:dotto_app_api/app/v1/article.pb.dart' as api;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:protobuf/well_known_types/google/protobuf/timestamp.pb.dart';

import '../../helpers/fake_app_api_transport.dart';

void main() {
  ProviderContainer createContainer(FakeAppApiTransport transport) {
    final container = ProviderContainer(
      retry: (_, _) => null,
      overrides: [appApiTransportProvider.overrideWithValue(transport)],
    );
    addTearDown(container.dispose);
    return container;
  }

  test('お知らせ一覧を取得できる', () async {
    final transport = FakeAppApiTransport()
      ..on(
        ArticleService.listArticles,
        (_) => api.ListArticlesResponse(
          articles: [
            api.Article(
              id: '1',
              title: '休講のお知らせ',
              url: 'https://example.com/1',
              publishTime: Timestamp.fromDateTime(DateTime.utc(2026, 4)),
            ),
          ],
        ),
      );
    final container = createContainer(transport);

    final announcements = await container.read(
      announcementStateProvider.future,
    );

    expect(announcements.single.title, '休講のお知らせ');
    expect(announcements.single.url, 'https://example.com/1');
  });

  test('取得に失敗するとDomainErrorになる', () async {
    final transport = FakeAppApiTransport()
      ..fail(ArticleService.listArticles);
    final container = createContainer(transport);

    await expectLater(
      container.read(announcementStateProvider.future),
      throwsA(isA<DomainError>()),
    );
  });
}
