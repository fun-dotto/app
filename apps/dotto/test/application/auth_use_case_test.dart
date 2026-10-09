import 'package:dotto/application/sign_in_use_case.dart';
import 'package:dotto/application/sign_out_use_case.dart';
import 'package:dotto/application/watch_auth_account_use_case.dart';
import 'package:dotto/data/auth_data_source.dart';
import 'package:dotto/domain/entity/auth_account.dart';
import 'package:dotto/domain/entity/domain_error.dart';
import 'package:dotto/foundation/log/logger.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/fake_auth_data_source.dart';
import '../helpers/recording_logger.dart';

const _account = AuthAccount(
  id: 'uid',
  name: '未来 太郎',
  email: 'taro@example.com',
  avatarUrl: 'https://example.com/taro.png',
);

ProviderContainer _container(FakeAuthDataSource auth, RecordingLogger logger) {
  final container = ProviderContainer(
    overrides: [
      authDataSourceProvider.overrideWithValue(auth),
      loggerProvider.overrideWithValue(logger),
    ],
  );
  addTearDown(container.dispose);
  return container;
}

void main() {
  test('サインインするとログイン中のアカウントになり、ログインを記録する', () async {
    final logger = RecordingLogger();
    final container = _container(
      FakeAuthDataSource(accountToSignIn: _account),
      logger,
    );

    await container.read(signInUseCaseProvider)();

    expect(
      await container.read(watchAuthAccountUseCaseProvider)().first,
      _account,
    );
    expect(logger.events, ['login']);
  });

  test('サインインに失敗したらドメインエラーにしてログインを記録しない', () async {
    final logger = RecordingLogger();
    final container = _container(FakeAuthDataSource(), logger);

    await expectLater(
      container.read(signInUseCaseProvider)(),
      throwsA(isA<DomainError>()),
    );
    expect(logger.events, isEmpty);
  });

  test('サインアウトするとアカウントが外れ、ログアウトを記録する', () async {
    final logger = RecordingLogger();
    final container = _container(
      FakeAuthDataSource(currentAccount: _account),
      logger,
    );

    await container.read(signOutUseCaseProvider)();

    expect(
      await container.read(watchAuthAccountUseCaseProvider)().first,
      isNull,
    );
    expect(logger.events, ['logout']);
  });
}
