// This is a generated file - do not edit.
//
// Generated from app/v1/user.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;
import 'package:protobuf/well_known_types/google/protobuf/field_mask.pb.dart'
    as $0;

import 'common.pbenum.dart' as $1;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

/// ユーザー。
class User extends $pb.GeneratedMessage {
  factory User({
    $1.Grade? grade,
    $1.Course? course,
    $1.Class? class_3,
  }) {
    final result = User._();
    if (grade != null) result.grade = grade;
    if (course != null) result.course = course;
    if (class_3 != null) result.class_3 = class_3;
    return result;
  }

  User._();

  factory User.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      User()..mergeFromBuffer(data, registry);
  factory User.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      User()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'User',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'app.v1'),
      createEmptyInstance: User.$_createMessage)
    ..aE<$1.Grade>(1, _omitFieldNames ? '' : 'grade',
        enumValues: $1.Grade.values)
    ..aE<$1.Course>(2, _omitFieldNames ? '' : 'course',
        enumValues: $1.Course.values)
    ..aE<$1.Class>(3, _omitFieldNames ? '' : 'class',
        enumValues: $1.Class.values)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  User clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  User copyWith(void Function(User) updates) =>
      super.copyWith((message) => updates(message as User)) as User;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use User() / User.new instead')
  static User create() => User._();
  static $pb.GeneratedMessage $_createMessage() => User._();
  @$core.override
  User createEmptyInstance() => User._();
  @$core.pragma('dart2js:noInline')
  static User getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<User>(User.$_createMessage);
  static User? _defaultInstance;

  /// 学年。
  @$pb.TagNumber(1)
  $1.Grade get grade => $_getN(0);
  @$pb.TagNumber(1)
  set grade($1.Grade value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasGrade() => $_has(0);
  @$pb.TagNumber(1)
  void clearGrade() => $_clearField(1);

  /// コース。
  @$pb.TagNumber(2)
  $1.Course get course => $_getN(1);
  @$pb.TagNumber(2)
  set course($1.Course value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasCourse() => $_has(1);
  @$pb.TagNumber(2)
  void clearCourse() => $_clearField(2);

  /// クラス。
  @$pb.TagNumber(3)
  $1.Class get class_3 => $_getN(2);
  @$pb.TagNumber(3)
  set class_3($1.Class value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasClass_3() => $_has(2);
  @$pb.TagNumber(3)
  void clearClass_3() => $_clearField(3);
}

/// GetUser の Request。対象は認証情報から決まる。
class GetUserRequest extends $pb.GeneratedMessage {
  factory GetUserRequest() => GetUserRequest._();

  GetUserRequest._();

  factory GetUserRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GetUserRequest()..mergeFromBuffer(data, registry);
  factory GetUserRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GetUserRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetUserRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'app.v1'),
      createEmptyInstance: GetUserRequest.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetUserRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetUserRequest copyWith(void Function(GetUserRequest) updates) =>
      super.copyWith((message) => updates(message as GetUserRequest))
          as GetUserRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use GetUserRequest() / GetUserRequest.new instead')
  static GetUserRequest create() => GetUserRequest._();
  static $pb.GeneratedMessage $_createMessage() => GetUserRequest._();
  @$core.override
  GetUserRequest createEmptyInstance() => GetUserRequest._();
  @$core.pragma('dart2js:noInline')
  static GetUserRequest getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetUserRequest>(
          GetUserRequest.$_createMessage);
  static GetUserRequest? _defaultInstance;
}

/// GetUser の Response。
class GetUserResponse extends $pb.GeneratedMessage {
  factory GetUserResponse({
    User? user,
  }) {
    final result = GetUserResponse._();
    if (user != null) result.user = user;
    return result;
  }

  GetUserResponse._();

  factory GetUserResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GetUserResponse()..mergeFromBuffer(data, registry);
  factory GetUserResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GetUserResponse()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetUserResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'app.v1'),
      createEmptyInstance: GetUserResponse.$_createMessage)
    ..aOM<User>(1, _omitFieldNames ? '' : 'user',
        subBuilder: User.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetUserResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetUserResponse copyWith(void Function(GetUserResponse) updates) =>
      super.copyWith((message) => updates(message as GetUserResponse))
          as GetUserResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use GetUserResponse() / GetUserResponse.new instead')
  static GetUserResponse create() => GetUserResponse._();
  static $pb.GeneratedMessage $_createMessage() => GetUserResponse._();
  @$core.override
  GetUserResponse createEmptyInstance() => GetUserResponse._();
  @$core.pragma('dart2js:noInline')
  static GetUserResponse getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetUserResponse>(
          GetUserResponse.$_createMessage);
  static GetUserResponse? _defaultInstance;

  /// 取得したユーザー。
  @$pb.TagNumber(1)
  User get user => $_getN(0);
  @$pb.TagNumber(1)
  set user(User value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasUser() => $_has(0);
  @$pb.TagNumber(1)
  void clearUser() => $_clearField(1);
  @$pb.TagNumber(1)
  User ensureUser() => $_ensure(0);
}

/// UpdateUser の Request。対象は認証情報から決まる。
class UpdateUserRequest extends $pb.GeneratedMessage {
  factory UpdateUserRequest({
    $1.Grade? grade,
    $1.Course? course,
    $1.Class? class_3,
    $0.FieldMask? updateMask,
  }) {
    final result = UpdateUserRequest._();
    if (grade != null) result.grade = grade;
    if (course != null) result.course = course;
    if (class_3 != null) result.class_3 = class_3;
    if (updateMask != null) result.updateMask = updateMask;
    return result;
  }

  UpdateUserRequest._();

  factory UpdateUserRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      UpdateUserRequest()..mergeFromBuffer(data, registry);
  factory UpdateUserRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      UpdateUserRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpdateUserRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'app.v1'),
      createEmptyInstance: UpdateUserRequest.$_createMessage)
    ..aE<$1.Grade>(1, _omitFieldNames ? '' : 'grade',
        enumValues: $1.Grade.values)
    ..aE<$1.Course>(2, _omitFieldNames ? '' : 'course',
        enumValues: $1.Course.values)
    ..aE<$1.Class>(3, _omitFieldNames ? '' : 'class',
        enumValues: $1.Class.values)
    ..aOM<$0.FieldMask>(99, _omitFieldNames ? '' : 'updateMask',
        subBuilder: $0.FieldMask.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateUserRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateUserRequest copyWith(void Function(UpdateUserRequest) updates) =>
      super.copyWith((message) => updates(message as UpdateUserRequest))
          as UpdateUserRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use UpdateUserRequest() / UpdateUserRequest.new instead')
  static UpdateUserRequest create() => UpdateUserRequest._();
  static $pb.GeneratedMessage $_createMessage() => UpdateUserRequest._();
  @$core.override
  UpdateUserRequest createEmptyInstance() => UpdateUserRequest._();
  @$core.pragma('dart2js:noInline')
  static UpdateUserRequest getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UpdateUserRequest>(
          UpdateUserRequest.$_createMessage);
  static UpdateUserRequest? _defaultInstance;

  /// 学年。
  @$pb.TagNumber(1)
  $1.Grade get grade => $_getN(0);
  @$pb.TagNumber(1)
  set grade($1.Grade value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasGrade() => $_has(0);
  @$pb.TagNumber(1)
  void clearGrade() => $_clearField(1);

  /// コース。
  @$pb.TagNumber(2)
  $1.Course get course => $_getN(1);
  @$pb.TagNumber(2)
  set course($1.Course value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasCourse() => $_has(1);
  @$pb.TagNumber(2)
  void clearCourse() => $_clearField(2);

  /// クラス。
  @$pb.TagNumber(3)
  $1.Class get class_3 => $_getN(2);
  @$pb.TagNumber(3)
  set class_3($1.Class value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasClass_3() => $_has(2);
  @$pb.TagNumber(3)
  void clearClass_3() => $_clearField(3);

  /// 更新するフィールド。空の場合は値が入っているフィールドをすべて更新する。
  @$pb.TagNumber(99)
  $0.FieldMask get updateMask => $_getN(3);
  @$pb.TagNumber(99)
  set updateMask($0.FieldMask value) => $_setField(99, value);
  @$pb.TagNumber(99)
  $core.bool hasUpdateMask() => $_has(3);
  @$pb.TagNumber(99)
  void clearUpdateMask() => $_clearField(99);
  @$pb.TagNumber(99)
  $0.FieldMask ensureUpdateMask() => $_ensure(3);
}

/// UpdateUser の Response。
class UpdateUserResponse extends $pb.GeneratedMessage {
  factory UpdateUserResponse({
    User? user,
  }) {
    final result = UpdateUserResponse._();
    if (user != null) result.user = user;
    return result;
  }

  UpdateUserResponse._();

  factory UpdateUserResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      UpdateUserResponse()..mergeFromBuffer(data, registry);
  factory UpdateUserResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      UpdateUserResponse()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpdateUserResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'app.v1'),
      createEmptyInstance: UpdateUserResponse.$_createMessage)
    ..aOM<User>(1, _omitFieldNames ? '' : 'user',
        subBuilder: User.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateUserResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateUserResponse copyWith(void Function(UpdateUserResponse) updates) =>
      super.copyWith((message) => updates(message as UpdateUserResponse))
          as UpdateUserResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use UpdateUserResponse() / UpdateUserResponse.new instead')
  static UpdateUserResponse create() => UpdateUserResponse._();
  static $pb.GeneratedMessage $_createMessage() => UpdateUserResponse._();
  @$core.override
  UpdateUserResponse createEmptyInstance() => UpdateUserResponse._();
  @$core.pragma('dart2js:noInline')
  static UpdateUserResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UpdateUserResponse>(
          UpdateUserResponse.$_createMessage);
  static UpdateUserResponse? _defaultInstance;

  /// 更新したユーザー。
  @$pb.TagNumber(1)
  User get user => $_getN(0);
  @$pb.TagNumber(1)
  set user(User value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasUser() => $_has(0);
  @$pb.TagNumber(1)
  void clearUser() => $_clearField(1);
  @$pb.TagNumber(1)
  User ensureUser() => $_ensure(0);
}

/// ログイン中のユーザーを管理する。
class UserServiceApi {
  final $pb.RpcClient _client;

  UserServiceApi(this._client);

  /// ログイン中のユーザーを取得する。
  $async.Future<GetUserResponse> getUser(
          $pb.ClientContext? ctx, GetUserRequest request) =>
      _client.invoke<GetUserResponse>(
          ctx, 'UserService', 'GetUser', request, GetUserResponse());

  /// ログイン中のユーザーを更新する。存在しない場合は作成する。
  $async.Future<UpdateUserResponse> updateUser(
          $pb.ClientContext? ctx, UpdateUserRequest request) =>
      _client.invoke<UpdateUserResponse>(
          ctx, 'UserService', 'UpdateUser', request, UpdateUserResponse());
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
