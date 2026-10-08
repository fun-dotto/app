import 'package:dio/dio.dart';
import 'package:dotto/api/api_client.dart';
import 'package:dotto/domain/entity/academic_area.dart';
import 'package:dotto/domain/entity/academic_class.dart';
import 'package:dotto/domain/entity/auth_account.dart';
import 'package:dotto/domain/entity/domain_error.dart';
import 'package:dotto/domain/entity/dotto_user.dart';
import 'package:dotto/domain/entity/grade.dart';
import 'package:dotto/domain/repository/user_repository.dart';
import 'package:openapi/openapi.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_repository_impl.g.dart';

@riverpod
UserRepository userRepository(Ref ref) =>
    UserRepositoryImpl(ref.watch(apiClientProvider));

final class UserRepositoryImpl implements UserRepository {
  const new(this._apiClient);

  static const _notFoundStatusCode = 404;

  final Openapi _apiClient;

  @override
  Future<DottoUser?> fetch(AuthAccount account) async {
    try {
      final response = await _apiClient.getUsersApi().usersV1Detail();
      final userInfo = response.data?.user;
      if (userInfo == null) {
        return null;
      }
      return _toDottoUser(
        DottoUser(
          id: account.id,
          name: account.name,
          email: account.email,
          avatarUrl: account.avatarUrl,
        ),
        userInfo,
      );
    } on DioException catch (e, stackTrace) {
      if (e.response?.statusCode == _notFoundStatusCode) {
        return null;
      }
      throw DomainError.fromException(e: e, stackTrace: stackTrace);
    } on Exception catch (e, stackTrace) {
      throw DomainError.fromException(e: e, stackTrace: stackTrace);
    }
  }

  @override
  Future<DottoUser> save(DottoUser user) async {
    try {
      final response = await _apiClient.getUsersApi().usersV1Upsert(
        userInfo: UserInfo(
          (b) => b
            ..grade = _toApiGrade(user.grade)
            ..course = _toApiCourse(user.course)
            ..class_ = _toApiClass(user.class_),
        ),
      );
      final userInfo = response.data?.user;
      if (userInfo == null) {
        throw const DomainError(
          type: DomainErrorType.invalidResponse,
          message: 'Failed to upsert user',
        );
      }
      return _toDottoUser(user, userInfo);
    } on DomainError {
      rethrow;
    } on Exception catch (e, stackTrace) {
      throw DomainError.fromException(e: e, stackTrace: stackTrace);
    }
  }

  /// 名前などのアカウント情報は [base] を引き継ぎ、プロフィールは API の値で置き換える。
  DottoUser _toDottoUser(DottoUser base, UserInfo userInfo) {
    return base.copyWith(
      grade: _toGrade(userInfo.grade),
      course: _toAcademicArea(userInfo.course),
      class_: _toAcademicClass(userInfo.class_),
    );
  }

  DottoFoundationV1Grade? _toApiGrade(Grade? grade) => switch (grade) {
    Grade.b1 => DottoFoundationV1Grade.B1,
    Grade.b2 => DottoFoundationV1Grade.B2,
    Grade.b3 => DottoFoundationV1Grade.B3,
    Grade.b4 => DottoFoundationV1Grade.B4,
    Grade.m1 => DottoFoundationV1Grade.M1,
    Grade.m2 => DottoFoundationV1Grade.M2,
    Grade.d1 => DottoFoundationV1Grade.D1,
    Grade.d2 => DottoFoundationV1Grade.D2,
    Grade.d3 => DottoFoundationV1Grade.D3,
    null => null,
  };

  DottoFoundationV1Course? _toApiCourse(AcademicArea? course) =>
      switch (course) {
        AcademicArea.informationSystemCourse =>
          DottoFoundationV1Course.informationSystem,
        AcademicArea.informationDesignCourse =>
          DottoFoundationV1Course.informationDesign,
        AcademicArea.complexCourse => DottoFoundationV1Course.complexSystem,
        AcademicArea.intelligenceSystemCourse =>
          DottoFoundationV1Course.intelligentSystem,
        AcademicArea.advancedICTCourse => DottoFoundationV1Course.advancedICT,
        _ => null,
      };

  DottoFoundationV1Class? _toApiClass(AcademicClass? class_) =>
      switch (class_) {
        AcademicClass.a => DottoFoundationV1Class.A,
        AcademicClass.b => DottoFoundationV1Class.B,
        AcademicClass.c => DottoFoundationV1Class.C,
        AcademicClass.d => DottoFoundationV1Class.D,
        AcademicClass.e => DottoFoundationV1Class.E,
        AcademicClass.f => DottoFoundationV1Class.F,
        AcademicClass.g => DottoFoundationV1Class.G,
        AcademicClass.h => DottoFoundationV1Class.H,
        AcademicClass.i => DottoFoundationV1Class.I,
        AcademicClass.j => DottoFoundationV1Class.J,
        AcademicClass.k => DottoFoundationV1Class.K,
        AcademicClass.l => DottoFoundationV1Class.L,
        null => null,
      };

  Grade? _toGrade(DottoFoundationV1Grade? grade) => switch (grade) {
    DottoFoundationV1Grade.B1 => Grade.b1,
    DottoFoundationV1Grade.B2 => Grade.b2,
    DottoFoundationV1Grade.B3 => Grade.b3,
    DottoFoundationV1Grade.B4 => Grade.b4,
    DottoFoundationV1Grade.M1 => Grade.m1,
    DottoFoundationV1Grade.M2 => Grade.m2,
    DottoFoundationV1Grade.D1 => Grade.d1,
    DottoFoundationV1Grade.D2 => Grade.d2,
    DottoFoundationV1Grade.D3 => Grade.d3,
    _ => null,
  };

  AcademicArea? _toAcademicArea(DottoFoundationV1Course? course) =>
      switch (course) {
        DottoFoundationV1Course.informationSystem =>
          AcademicArea.informationSystemCourse,
        DottoFoundationV1Course.informationDesign =>
          AcademicArea.informationDesignCourse,
        DottoFoundationV1Course.complexSystem => AcademicArea.complexCourse,
        DottoFoundationV1Course.intelligentSystem =>
          AcademicArea.intelligenceSystemCourse,
        DottoFoundationV1Course.advancedICT => AcademicArea.advancedICTCourse,
        _ => null,
      };

  AcademicClass? _toAcademicClass(DottoFoundationV1Class? class_) =>
      switch (class_) {
        DottoFoundationV1Class.A => AcademicClass.a,
        DottoFoundationV1Class.B => AcademicClass.b,
        DottoFoundationV1Class.C => AcademicClass.c,
        DottoFoundationV1Class.D => AcademicClass.d,
        DottoFoundationV1Class.E => AcademicClass.e,
        DottoFoundationV1Class.F => AcademicClass.f,
        DottoFoundationV1Class.G => AcademicClass.g,
        DottoFoundationV1Class.H => AcademicClass.h,
        DottoFoundationV1Class.I => AcademicClass.i,
        DottoFoundationV1Class.J => AcademicClass.j,
        DottoFoundationV1Class.K => AcademicClass.k,
        DottoFoundationV1Class.L => AcademicClass.l,
        _ => null,
      };
}
