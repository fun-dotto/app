import 'package:dotto/api/api_client.dart';
import 'package:dotto/domain/entity/domain_error.dart';
import 'package:dotto/presentation/announcement/announcement_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:openapi/openapi.dart';

import '../../helpers/fake_http_client_adapter.dart';

void main() {
  ProviderContainer createContainer(FakeHttpClientAdapter adapter) {
    final container = ProviderContainer(
      overrides: [
        apiClientProvider.overrideWithValue(Openapi(dio: fakeDio(adapter))),
      ],
    );
    addTearDown(container.dispose);
    return container;
  }

  test('お知らせ一覧を取得できる', () async {
    final adapter = FakeHttpClientAdapter()
      ..on(
        'GET',
        '/v1/announcements',
        (_) => const FakeResponse(200, {
          'announcements': [
            {
              'id': '1',
              'title': '休講のお知らせ',
              'date': '2026-04-01T00:00:00Z',
              'url': 'https://example.com/1',
            },
          ],
        }),
      );
    final container = createContainer(adapter);

    final announcements = await container.read(
      announcementStateProvider.future,
    );

    expect(announcements.single.title, '休講のお知らせ');
    expect(announcements.single.url, 'https://example.com/1');
  });

  test('取得に失敗するとDomainErrorになる', () async {
    final adapter = FakeHttpClientAdapter()
      ..on('GET', '/v1/announcements', (_) => const FakeResponse(500));
    final container = createContainer(adapter);

    await expectLater(
      container.read(announcementStateProvider.future),
      throwsA(isA<DomainError>()),
    );
  });
}
