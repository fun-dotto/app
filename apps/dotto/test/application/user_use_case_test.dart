import 'package:dotto/application/fetch_current_user_use_case.dart';
import 'package:dotto/application/update_user_profile_use_case.dart';
import 'package:dotto/data/api_client.dart';
import 'package:dotto/domain/entity/academic_area.dart';
import 'package:dotto/domain/entity/academic_class.dart';
import 'package:dotto/domain/entity/auth_account.dart';
import 'package:dotto/domain/entity/domain_error.dart';
import 'package:dotto/domain/entity/dotto_user.dart';
import 'package:dotto/domain/entity/grade.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:openapi/openapi.dart';

import '../helpers/fake_http_client_adapter.dart';

const _account = AuthAccount(
  id: 'uid',
  name: '未来 太郎',
  email: 'taro@example.com',
  avatarUrl: 'https://example.com/taro.png',
);

/// 保存したプロフィールを保持するユーザー API のフェイク。
final class _FakeUserApi {
  new([this.saved]);

  Map<String, Object?>? saved;
  int saveCount = 0;

  late final adapter = FakeHttpClientAdapter()
    ..on(
      'GET',
      '/v1/users',
      (_) => switch (saved) {
        final user? => FakeResponse(200, {'user': user}),
        null => const FakeResponse(404),
      },
    )
    ..on('POST', '/v1/users', (options) {
      saveCount++;
      saved = Map<String, Object?>.from(options.data as Map);
      return FakeResponse(200, {'user': saved});
    });
}

ProviderContainer _container(_FakeUserApi api) {
  final container = ProviderContainer(
    overrides: [
      apiClientProvider.overrideWithValue(Openapi(dio: fakeDio(api.adapter))),
    ],
  );
  addTearDown(container.dispose);
  return container;
}

void main() {
  test('登録済みのユーザーはプロフィールをアカウント情報と合わせて返す', () async {
    final api = _FakeUserApi({
      'grade': 'B2',
      'course': 'InformationDesign',
      'class': 'C',
    });
    final container = _container(api);

    final user = await container.read(fetchCurrentUserUseCaseProvider)(
      _account,
    );

    expect(
      user,
      const DottoUser(
        id: 'uid',
        name: '未来 太郎',
        email: 'taro@example.com',
        avatarUrl: 'https://example.com/taro.png',
        grade: Grade.b2,
        course: AcademicArea.informationDesignCourse,
        class_: AcademicClass.c,
      ),
    );
    expect(api.saveCount, 0);
  });

  test('未登録のユーザーはプロフィール未設定のまま新規登録する', () async {
    final api = _FakeUserApi();
    final container = _container(api);

    final user = await container.read(fetchCurrentUserUseCaseProvider)(
      _account,
    );

    expect(user.grade, isNull);
    expect(api.saveCount, 1);
  });

  test('ユーザーの取得に失敗したらドメインエラーにする', () async {
    final adapter = FakeHttpClientAdapter()
      ..on('GET', '/v1/users', (_) => const FakeResponse(500));
    final container = ProviderContainer(
      overrides: [
        apiClientProvider.overrideWithValue(Openapi(dio: fakeDio(adapter))),
      ],
    );
    addTearDown(container.dispose);

    await expectLater(
      container.read(fetchCurrentUserUseCaseProvider)(_account),
      throwsA(isA<DomainError>()),
    );
  });

  test('プロフィールを更新すると次回の取得に反映される', () async {
    final api = _FakeUserApi();
    final container = _container(api);

    await container.read(updateUserProfileUseCaseProvider)(
      const DottoUser(
        id: 'uid',
        name: '未来 太郎',
        email: 'taro@example.com',
        avatarUrl: 'https://example.com/taro.png',
        grade: Grade.m1,
        course: AcademicArea.advancedICTCourse,
      ),
    );
    final user = await container.read(fetchCurrentUserUseCaseProvider)(
      _account,
    );

    expect(user.grade, Grade.m1);
    expect(user.course, AcademicArea.advancedICTCourse);
    expect(user.class_, isNull);
  });
}
