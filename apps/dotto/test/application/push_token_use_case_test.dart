import 'package:dotto/application/synchronize_push_token_use_case.dart';
import 'package:dotto/application/watch_push_token_use_case.dart';
import 'package:dotto/data/app_api_transport.dart';
import 'package:dotto/data/push_token_data_source.dart';
import 'package:dotto/domain/entity/domain_error.dart';
import 'package:dotto_app_api/app/v1/fcm_token.connect.spec.dart';
import 'package:dotto_app_api/app/v1/fcm_token.pb.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/fake_app_api_transport.dart';
import '../helpers/fake_push_token_data_source.dart';

ProviderContainer _container(
  FakeAppApiTransport transport, {
  Stream<String> refreshes = const Stream.empty(),
}) {
  final container = ProviderContainer(
    overrides: [
      appApiTransportProvider.overrideWithValue(transport),
      pushTokenDataSourceProvider.overrideWithValue(
        FakePushTokenDataSource(refreshes),
      ),
    ],
  );
  addTearDown(container.dispose);
  return container;
}

FakeAppApiTransport _server(List<String> received) =>
    FakeAppApiTransport()..on(FcmTokenService.registerFcmToken, (request) {
      received.add(request.token);
      return RegisterFcmTokenResponse(fcmToken: FcmToken(token: request.token));
    });

void main() {
  test('指定したトークンをサーバーへ登録する', () async {
    final received = <String>[];
    final container = _container(_server(received));

    await container.read(synchronizePushTokenUseCaseProvider)('refreshed');

    expect(received, ['refreshed']);
  });

  test('トークンを指定しなければ端末の現在のトークンを登録する', () async {
    final received = <String>[];
    final container = _container(_server(received));

    await container.read(synchronizePushTokenUseCaseProvider)();

    expect(received, ['token']);
  });

  test('登録に失敗したらドメインエラーにする', () async {
    final container = _container(FakeAppApiTransport());

    await expectLater(
      container.read(synchronizePushTokenUseCaseProvider)(),
      throwsA(isA<DomainError>()),
    );
  });

  test('端末のトークン更新を順に通知する', () async {
    final container = _container(
      FakeAppApiTransport(),
      refreshes: Stream.fromIterable(['first', 'second']),
    );

    expect(await container.read(watchPushTokenUseCaseProvider)().toList(), [
      'first',
      'second',
    ]);
  });
}
