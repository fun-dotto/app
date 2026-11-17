import 'package:dotto/application/fetch_debug_tokens_use_case.dart';
import 'package:dotto/data/debug_token_data_source.dart';
import 'package:dotto/domain/entity/debug_tokens.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/fake_debug_token_data_source.dart';

ProviderContainer _container(FakeDebugTokenDataSource dataSource) {
  final container = ProviderContainer(
    overrides: [debugTokenDataSourceProvider.overrideWithValue(dataSource)],
  );
  addTearDown(container.dispose);
  return container;
}

void main() {
  test('各種トークンをまとめて取得する', () async {
    final container = _container(
      const FakeDebugTokenDataSource(appCheckToken: 'app-check', idToken: 'id'),
    );

    expect(
      await container.read(fetchDebugTokensUseCaseProvider)(),
      const DebugTokens(appCheckToken: 'app-check', idToken: 'id'),
    );
  });

  test('トークンの取得に失敗しても例外にせず null を返す', () async {
    final container = _container(
      FakeDebugTokenDataSource(error: Exception('offline')),
    );

    expect(
      await container.read(fetchDebugTokensUseCaseProvider)(),
      const DebugTokens(),
    );
  });
}
