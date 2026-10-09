import 'package:dotto/data/api_client.dart';
import 'package:dotto/data/push_token_data_source.dart';
import 'package:dotto/domain/entity/domain_error.dart';
import 'package:dotto/presentation/root/push_token_state.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:openapi/openapi.dart';

import '../../helpers/fake_push_token_data_source.dart';

void main() {
  test('通知トークン更新をドメインの状態へ反映する', () async {
    final container = ProviderContainer(
      overrides: [
        apiClientProvider.overrideWithValue(Openapi()),
        pushTokenDataSourceProvider.overrideWithValue(
          FakePushTokenDataSource(Stream.value('updated-token')),
        ),
      ],
    );
    addTearDown(container.dispose);
    final subscription = container.listen(pushTokenStateProvider, (_, _) {});
    addTearDown(subscription.close);

    expect(
      await container.read(pushTokenStateProvider.future),
      'updated-token',
    );
  });
  test('通知トークン監視の外部エラーをドメインエラーへ変換する', () async {
    final container = ProviderContainer(
      retry: (_, _) => null,
      overrides: [
        apiClientProvider.overrideWithValue(Openapi()),
        pushTokenDataSourceProvider.overrideWithValue(
          FakePushTokenDataSource(
            Stream.error(
              FirebaseException(plugin: 'messaging', code: 'unavailable'),
            ),
          ),
        ),
      ],
    );
    addTearDown(container.dispose);
    final subscription = container.listen(pushTokenStateProvider, (_, _) {});
    addTearDown(subscription.close);

    await expectLater(
      container.read(pushTokenStateProvider.future),
      throwsA(
        isA<DomainError>().having(
          (error) => error.type,
          '種別',
          DomainErrorType.network,
        ),
      ),
    );
  });
}
