import 'package:connectrpc/connect.dart';
import 'package:dotto/data/api_client.dart';
import 'package:dotto/data/auth_data_source.dart';
import 'package:dotto/domain/entity/auth_account.dart';
import 'package:dotto/domain/entity/domain_error.dart';
import 'package:dotto/domain/entity/grade.dart';
import 'package:dotto/foundation/log/logger.dart';
import 'package:dotto/presentation/common/user_state.dart';
import 'package:dotto_app_api/app/v1/common.pbenum.dart' as pb;
import 'package:dotto_app_api/app/v1/user.connect.spec.dart';
import 'package:dotto_app_api/app/v1/user.pb.dart' as pb;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/fake_app_api.dart';
import '../../helpers/fake_auth_data_source.dart';
import '../../helpers/fake_logger.dart';

const _account = AuthAccount(
  id: 'uid',
  name: '未来 太郎',
  email: 'b1000000@fun.ac.jp',
  avatarUrl: 'https://example.com/avatar.png',
);

/// ユーザー API をインメモリで保持するフェイクサーバー。
final class _FakeUserServer {
  new({this.user, this.shouldFailUpsert = false}) {
    api
      ..on(UserService.getUser, (_) {
        final user = this.user;
        if (user == null) throw ConnectException(Code.notFound, 'not found');
        return pb.GetUserResponse(user: user);
      })
      ..on(UserService.updateUser, (request) {
        if (shouldFailUpsert) {
          throw ConnectException(Code.internal, 'fake error');
        }
        final user = pb.User(
          grade: request.hasGrade() ? request.grade : null,
          course: request.hasCourse() ? request.course : null,
          class_3: request.hasClass_3() ? request.class_3 : null,
        );
        this.user = user;
        return pb.UpdateUserResponse(user: user);
      });
  }

  final api = FakeAppApi();
  pb.User? user;
  bool shouldFailUpsert;
}

void main() {
  ProviderContainer createContainer({
    required _FakeUserServer server,
    AuthAccount? currentAccount,
    AuthAccount? accountToSignIn,
  }) {
    final container = ProviderContainer(
      overrides: [
        apiClientProvider.overrideWithValue(server.api),
        authDataSourceProvider.overrideWithValue(
          FakeAuthDataSource(
            currentAccount: currentAccount,
            accountToSignIn: accountToSignIn,
          ),
        ),
        loggerProvider.overrideWithValue(FakeLogger()),
      ],
    );
    addTearDown(container.dispose);
    // 購読がないと Riverpod が Stream を一時停止するため、画面と同様に購読しておく
    container.listen(userStateProvider, (_, _) {});
    return container;
  }

  test('未ログインのときユーザーはnullになる', () async {
    final container = createContainer(server: _FakeUserServer());

    expect(await container.read(userStateProvider.future), isNull);
  });

  test('ログインすると登録済みのプロフィールを取得する', () async {
    final server = _FakeUserServer(
      user: pb.User(grade: pb.Grade.GRADE_B2, class_3: pb.Class.CLASS_C),
    );
    final container = createContainer(
      server: server,
      accountToSignIn: _account,
    );
    await container.read(userStateProvider.future);

    await container.read(userStateProvider.notifier).signIn();
    final user = await container.read(userStateProvider.future);

    expect(user?.id, _account.id);
    expect(user?.grade, Grade.b2);
  });

  test('初回ログインのときユーザーを登録する', () async {
    final server = _FakeUserServer();
    final container = createContainer(
      server: server,
      accountToSignIn: _account,
    );
    await container.read(userStateProvider.future);

    await container.read(userStateProvider.notifier).signIn();
    final user = await container.read(userStateProvider.future);

    expect(user?.email, _account.email);
    expect(server.user, isNotNull);
  });

  test('ログインに失敗するとエラーになる', () async {
    final container = createContainer(server: _FakeUserServer());
    await container.read(userStateProvider.future);

    await container.read(userStateProvider.notifier).signIn();

    expect(container.read(userStateProvider).error, isA<DomainError>());
  });

  test('学年を保存できる', () async {
    final server = _FakeUserServer(user: pb.User());
    final container = createContainer(server: server, currentAccount: _account);
    await container.read(userStateProvider.future);

    await container.read(userStateProvider.notifier).setGrade(Grade.b3);

    expect(container.read(userStateProvider).value?.grade, Grade.b3);
    expect(server.user?.grade, pb.Grade.GRADE_B3);
  });

  test('学年の保存に失敗すると元の値に戻る', () async {
    final server = _FakeUserServer(
      user: pb.User(grade: pb.Grade.GRADE_B1),
      shouldFailUpsert: true,
    );
    final container = createContainer(server: server, currentAccount: _account);
    await container.read(userStateProvider.future);

    await expectLater(
      container.read(userStateProvider.notifier).setGrade(Grade.b3),
      throwsA(isA<DomainError>()),
    );

    expect(container.read(userStateProvider).value?.grade, Grade.b1);
  });
}
