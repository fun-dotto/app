import 'package:dotto/data/api_client.dart';
import 'package:dotto/domain/entity/domain_error.dart';
import 'package:dotto/presentation/announcement/announcement_state.dart';
import 'package:dotto_app_api/app/v1/announcement.connect.spec.dart';
import 'package:dotto_app_api/app/v1/announcement.pb.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:protobuf/well_known_types/google/protobuf/timestamp.pb.dart';

import '../../helpers/fake_app_api.dart';

void main() {
  ProviderContainer createContainer(FakeAppApi api) {
    final container = ProviderContainer(
      retry: (_, _) => null,
      overrides: [apiClientProvider.overrideWithValue(api)],
    );
    addTearDown(container.dispose);
    return container;
  }

  test('お知らせ一覧を取得できる', () async {
    final api = FakeAppApi()
      ..on(
        AnnouncementService.listAnnouncements,
        (_) => ListAnnouncementsResponse(
          announcements: [
            Announcement(
              id: '1',
              title: '休講のお知らせ',
              availableFrom: Timestamp.fromDateTime(DateTime.utc(2026, 4)),
              url: 'https://example.com/1',
            ),
          ],
        ),
      );
    final container = createContainer(api);

    final announcements = await container.read(
      announcementStateProvider.future,
    );

    expect(announcements.single.title, '休講のお知らせ');
    expect(announcements.single.url, 'https://example.com/1');
  });

  test('取得に失敗するとDomainErrorになる', () async {
    final api = FakeAppApi()..fail(AnnouncementService.listAnnouncements);
    final container = createContainer(api);

    await expectLater(
      container.read(announcementStateProvider.future),
      throwsA(isA<DomainError>()),
    );
  });
}
