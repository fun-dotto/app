import 'package:connectrpc/connect.dart';
import 'package:dotto/application/fetch_current_user_use_case.dart';
import 'package:dotto/application/update_user_profile_use_case.dart';
import 'package:dotto/data/api_client.dart';
import 'package:dotto/domain/entity/academic_area.dart';
import 'package:dotto/domain/entity/academic_class.dart';
import 'package:dotto/domain/entity/auth_account.dart';
import 'package:dotto/domain/entity/domain_error.dart';
import 'package:dotto/domain/entity/dotto_user.dart';
import 'package:dotto/domain/entity/grade.dart';
import 'package:dotto_app_api/app/v1/common.pbenum.dart' as pb;
import 'package:dotto_app_api/app/v1/user.connect.spec.dart';
import 'package:dotto_app_api/app/v1/user.pb.dart' as pb;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/fake_app_api.dart';

const _account = AuthAccount(
  id: 'uid',
  name: '未来 太郎',
  email: 'taro@example.com',
  avatarUrl: 'https://example.com/taro.png',
);

/// 保存したプロフィールを保持するユーザー API のフェイク。
final class _FakeUserApi {
  new([this.saved]);

  pb.User? saved;
  int saveCount = 0;

  late final api = FakeAppApi()
    ..on(UserService.getUser, (_) {
      final user = saved;
      if (user == null) throw ConnectException(Code.notFound, 'not found');
      return pb.GetUserResponse(user: user);
    })
    ..on(UserService.updateUser, (request) {
      saveCount++;
      // サーバーと同じく、update_mask が空なら値のある項目だけを更新する。
      final mask = request.updateMask.paths;
      bool updates(String field, {required bool hasValue}) =>
          mask.isEmpty ? hasValue : mask.contains(field);
      final user = saved?.deepCopy() ?? pb.User();
      if (updates('grade', hasValue: request.hasGrade())) {
        request.hasGrade() ? user.grade = request.grade : user.clearGrade();
      }
      if (updates('course', hasValue: request.hasCourse())) {
        request.hasCourse() ? user.course = request.course : user.clearCourse();
      }
      if (updates('class', hasValue: request.hasClass_3())) {
        request.hasClass_3()
            ? user.class_3 = request.class_3
            : user.clearClass_3();
      }
      saved = user;
      return pb.UpdateUserResponse(user: user);
    });
}

ProviderContainer _container(_FakeUserApi api) {
  final container = ProviderContainer(
    overrides: [apiClientProvider.overrideWithValue(api.api)],
  );
  addTearDown(container.dispose);
  return container;
}

void main() {
  test('登録済みのユーザーはプロフィールをアカウント情報と合わせて返す', () async {
    final api = _FakeUserApi(
      pb.User(
        grade: pb.Grade.GRADE_B2,
        course: pb.Course.COURSE_INFORMATION_DESIGN,
        class_3: pb.Class.CLASS_C,
      ),
    );
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
    final api = FakeAppApi()..fail(UserService.getUser);
    final container = ProviderContainer(
      overrides: [apiClientProvider.overrideWithValue(api)],
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

  test('クラスをなしにして保存するとサーバー上のクラスも消える', () async {
    final api = _FakeUserApi(
      pb.User(grade: pb.Grade.GRADE_B2, class_3: pb.Class.CLASS_C),
    );
    final container = _container(api);

    await container.read(updateUserProfileUseCaseProvider)(
      const DottoUser(
        id: 'uid',
        name: '未来 太郎',
        email: 'taro@example.com',
        avatarUrl: 'https://example.com/taro.png',
        grade: Grade.b2,
      ),
    );
    final user = await container.read(fetchCurrentUserUseCaseProvider)(
      _account,
    );

    expect(user.grade, Grade.b2);
    expect(user.class_, isNull);
  });
}
