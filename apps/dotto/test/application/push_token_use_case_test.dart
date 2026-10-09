import 'dart:convert';

import 'package:dotto/application/synchronize_push_token_use_case.dart';
import 'package:dotto/application/watch_push_token_use_case.dart';
import 'package:dotto/data/api_client.dart';
import 'package:dotto/data/push_token_data_source.dart';
import 'package:dotto/domain/entity/domain_error.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:openapi/openapi.dart';

import '../helpers/fake_http_client_adapter.dart';
import '../helpers/fake_push_token_data_source.dart';

ProviderContainer _container(
  FakeHttpClientAdapter adapter, {
  Stream<String> refreshes = const Stream.empty(),
}) {
  final container = ProviderContainer(
    overrides: [
      apiClientProvider.overrideWithValue(Openapi(dio: fakeDio(adapter))),
      pushTokenDataSourceProvider.overrideWithValue(
        FakePushTokenDataSource(refreshes),
      ),
    ],
  );
  addTearDown(container.dispose);
  return container;
}

FakeHttpClientAdapter _server(List<String> received) =>
    FakeHttpClientAdapter()..on('POST', '/v1/fcmTokens', (options) {
      final body = switch (options.data) {
        final String data => jsonDecode(data),
        final Object? data => data,
      };
      final token = (body! as Map)['token'] as String;
      received.add(token);
      return FakeResponse(200, {
        'fcmToken': {
          'token': token,
          'createdAt': '2026-04-01T00:00:00Z',
          'updatedAt': '2026-04-01T00:00:00Z',
        },
      });
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
    final container = _container(FakeHttpClientAdapter());

    await expectLater(
      container.read(synchronizePushTokenUseCaseProvider)(),
      throwsA(isA<DomainError>()),
    );
  });

  test('端末のトークン更新を順に通知する', () async {
    final container = _container(
      FakeHttpClientAdapter(),
      refreshes: Stream.fromIterable(['first', 'second']),
    );

    expect(await container.read(watchPushTokenUseCaseProvider)().toList(), [
      'first',
      'second',
    ]);
  });
}
