import 'package:connectrpc/connect.dart' as connect;
import 'package:dotto/data/app_api_mapper.dart';
import 'package:dotto/data/app_api_transport.dart';
import 'package:dotto/data/domain_error_mapper.dart';
import 'package:dotto/domain/entity/auth_account.dart';
import 'package:dotto/domain/entity/domain_error.dart';
import 'package:dotto/domain/entity/dotto_user.dart';
import 'package:dotto/domain/repository/user_repository.dart';
import 'package:dotto_app_api/app/v1/user.connect.client.dart';
import 'package:dotto_app_api/app/v1/user.pb.dart' as api;
import 'package:protobuf/well_known_types/google/protobuf/field_mask.pb.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_repository_impl.g.dart';

@riverpod
UserRepository userRepository(Ref ref) =>
    UserRepositoryImpl(UserServiceClient(ref.watch(appApiTransportProvider)));

final class UserRepositoryImpl implements UserRepository {
  const new(this._client);

  final UserServiceClient _client;

  @override
  Future<DottoUser?> fetch(AuthAccount account) async {
    try {
      final response = await _client.getUser(api.GetUserRequest());
      if (!response.hasUser()) {
        return null;
      }
      return _toDottoUser(
        DottoUser(
          id: account.id,
          name: account.name,
          email: account.email,
          avatarUrl: account.avatarUrl,
        ),
        response.user,
      );
    } on connect.ConnectException catch (e, stackTrace) {
      if (e.code == connect.Code.notFound) {
        return null;
      }
      throw mapDomainError(e: e, stackTrace: stackTrace);
    } on Exception catch (e, stackTrace) {
      throw mapDomainError(e: e, stackTrace: stackTrace);
    }
  }

  @override
  Future<DottoUser> save(DottoUser user) async {
    try {
      final grade = user.grade;
      final course = user.course;
      final class_ = user.class_;
      final response = await _client.updateUser(
        api.UpdateUserRequest(
          grade: grade == null ? null : toApiGrade(grade),
          course: course == null ? null : toApiCourse(course),
          class_3: class_ == null ? null : toApiClass(class_),
          updateMask: FieldMask(paths: ['grade', 'course', 'class']),
        ),
      );
      if (!response.hasUser()) {
        throw const DomainError(
          type: DomainErrorType.invalidResponse,
          message: 'Failed to update user',
        );
      }
      return _toDottoUser(user, response.user);
    } on DomainError {
      rethrow;
    } on Exception catch (e, stackTrace) {
      throw mapDomainError(e: e, stackTrace: stackTrace);
    }
  }

  /// 名前などのアカウント情報は [base] を引き継ぎ、プロフィールは API の値で置き換える。
  DottoUser _toDottoUser(DottoUser base, api.User user) {
    return base.copyWith(
      grade: user.hasGrade() ? fromApiGrade(user.grade) : null,
      course: user.hasCourse() ? fromApiCourse(user.course) : null,
      class_: user.hasClass_3() ? fromApiClass(user.class_3) : null,
    );
  }
}
