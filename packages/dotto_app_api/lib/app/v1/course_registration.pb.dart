// This is a generated file - do not edit.
//
// Generated from app/v1/course_registration.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'subject.pb.dart' as $0;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

/// 履修情報。
class CourseRegistration extends $pb.GeneratedMessage {
  factory CourseRegistration({
    $core.String? id,
    $0.Subject? subject,
  }) {
    final result = CourseRegistration._();
    if (id != null) result.id = id;
    if (subject != null) result.subject = subject;
    return result;
  }

  CourseRegistration._();

  factory CourseRegistration.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      CourseRegistration()..mergeFromBuffer(data, registry);
  factory CourseRegistration.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      CourseRegistration()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CourseRegistration',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'app.v1'),
      createEmptyInstance: CourseRegistration.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOM<$0.Subject>(2, _omitFieldNames ? '' : 'subject',
        subBuilder: $0.Subject.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CourseRegistration clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CourseRegistration copyWith(void Function(CourseRegistration) updates) =>
      super.copyWith((message) => updates(message as CourseRegistration))
          as CourseRegistration;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use CourseRegistration() / CourseRegistration.new instead')
  static CourseRegistration create() => CourseRegistration._();
  static $pb.GeneratedMessage $_createMessage() => CourseRegistration._();
  @$core.override
  CourseRegistration createEmptyInstance() => CourseRegistration._();
  @$core.pragma('dart2js:noInline')
  static CourseRegistration getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CourseRegistration>(
          CourseRegistration.$_createMessage);
  static CourseRegistration? _defaultInstance;

  /// ID。
  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  /// 科目。
  @$pb.TagNumber(2)
  $0.Subject get subject => $_getN(1);
  @$pb.TagNumber(2)
  set subject($0.Subject value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasSubject() => $_has(1);
  @$pb.TagNumber(2)
  void clearSubject() => $_clearField(2);
  @$pb.TagNumber(2)
  $0.Subject ensureSubject() => $_ensure(1);
}

/// ListCourseRegistrations の Request。
class ListCourseRegistrationsRequest extends $pb.GeneratedMessage {
  factory ListCourseRegistrationsRequest({
    $core.int? year,
    $core.Iterable<$0.SubjectSemester>? semesters,
  }) {
    final result = ListCourseRegistrationsRequest._();
    if (year != null) result.year = year;
    if (semesters != null) result.semesters.addAll(semesters);
    return result;
  }

  ListCourseRegistrationsRequest._();

  factory ListCourseRegistrationsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ListCourseRegistrationsRequest()..mergeFromBuffer(data, registry);
  factory ListCourseRegistrationsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ListCourseRegistrationsRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListCourseRegistrationsRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'app.v1'),
      createEmptyInstance: ListCourseRegistrationsRequest.$_createMessage)
    ..aI(3, _omitFieldNames ? '' : 'year')
    ..pc<$0.SubjectSemester>(
        4, _omitFieldNames ? '' : 'semesters', $pb.PbFieldType.KE,
        valueOf: $0.SubjectSemester.valueOf,
        enumValues: $0.SubjectSemester.values,
        defaultEnumValue: $0.SubjectSemester.SUBJECT_SEMESTER_UNSPECIFIED)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListCourseRegistrationsRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListCourseRegistrationsRequest copyWith(
          void Function(ListCourseRegistrationsRequest) updates) =>
      super.copyWith(
              (message) => updates(message as ListCourseRegistrationsRequest))
          as ListCourseRegistrationsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use ListCourseRegistrationsRequest() / ListCourseRegistrationsRequest.new instead')
  static ListCourseRegistrationsRequest create() =>
      ListCourseRegistrationsRequest._();
  static $pb.GeneratedMessage $_createMessage() =>
      ListCourseRegistrationsRequest._();
  @$core.override
  ListCourseRegistrationsRequest createEmptyInstance() =>
      ListCourseRegistrationsRequest._();
  @$core.pragma('dart2js:noInline')
  static ListCourseRegistrationsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListCourseRegistrationsRequest>(
          ListCourseRegistrationsRequest.$_createMessage);
  static ListCourseRegistrationsRequest? _defaultInstance;

  /// 開講年度。未設定の場合は今年度。
  @$pb.TagNumber(3)
  $core.int get year => $_getIZ(0);
  @$pb.TagNumber(3)
  set year($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(3)
  $core.bool hasYear() => $_has(0);
  @$pb.TagNumber(3)
  void clearYear() => $_clearField(3);

  /// 開講時期。
  @$pb.TagNumber(4)
  $pb.PbList<$0.SubjectSemester> get semesters => $_getList(1);
}

/// ListCourseRegistrations の Response。
class ListCourseRegistrationsResponse extends $pb.GeneratedMessage {
  factory ListCourseRegistrationsResponse({
    $core.Iterable<CourseRegistration>? courseRegistrations,
  }) {
    final result = ListCourseRegistrationsResponse._();
    if (courseRegistrations != null)
      result.courseRegistrations.addAll(courseRegistrations);
    return result;
  }

  ListCourseRegistrationsResponse._();

  factory ListCourseRegistrationsResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ListCourseRegistrationsResponse()..mergeFromBuffer(data, registry);
  factory ListCourseRegistrationsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ListCourseRegistrationsResponse()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListCourseRegistrationsResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'app.v1'),
      createEmptyInstance: ListCourseRegistrationsResponse.$_createMessage)
    ..pPM<CourseRegistration>(1, _omitFieldNames ? '' : 'courseRegistrations',
        subBuilder: CourseRegistration.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListCourseRegistrationsResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListCourseRegistrationsResponse copyWith(
          void Function(ListCourseRegistrationsResponse) updates) =>
      super.copyWith(
              (message) => updates(message as ListCourseRegistrationsResponse))
          as ListCourseRegistrationsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use ListCourseRegistrationsResponse() / ListCourseRegistrationsResponse.new instead')
  static ListCourseRegistrationsResponse create() =>
      ListCourseRegistrationsResponse._();
  static $pb.GeneratedMessage $_createMessage() =>
      ListCourseRegistrationsResponse._();
  @$core.override
  ListCourseRegistrationsResponse createEmptyInstance() =>
      ListCourseRegistrationsResponse._();
  @$core.pragma('dart2js:noInline')
  static ListCourseRegistrationsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListCourseRegistrationsResponse>(
          ListCourseRegistrationsResponse.$_createMessage);
  static ListCourseRegistrationsResponse? _defaultInstance;

  /// 履修情報の一覧。
  @$pb.TagNumber(1)
  $pb.PbList<CourseRegistration> get courseRegistrations => $_getList(0);
}

/// CreateCourseRegistration の Request。
class CreateCourseRegistrationRequest extends $pb.GeneratedMessage {
  factory CreateCourseRegistrationRequest({
    $core.String? subjectId,
  }) {
    final result = CreateCourseRegistrationRequest._();
    if (subjectId != null) result.subjectId = subjectId;
    return result;
  }

  CreateCourseRegistrationRequest._();

  factory CreateCourseRegistrationRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      CreateCourseRegistrationRequest()..mergeFromBuffer(data, registry);
  factory CreateCourseRegistrationRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      CreateCourseRegistrationRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CreateCourseRegistrationRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'app.v1'),
      createEmptyInstance: CreateCourseRegistrationRequest.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'subjectId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateCourseRegistrationRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateCourseRegistrationRequest copyWith(
          void Function(CreateCourseRegistrationRequest) updates) =>
      super.copyWith(
              (message) => updates(message as CreateCourseRegistrationRequest))
          as CreateCourseRegistrationRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use CreateCourseRegistrationRequest() / CreateCourseRegistrationRequest.new instead')
  static CreateCourseRegistrationRequest create() =>
      CreateCourseRegistrationRequest._();
  static $pb.GeneratedMessage $_createMessage() =>
      CreateCourseRegistrationRequest._();
  @$core.override
  CreateCourseRegistrationRequest createEmptyInstance() =>
      CreateCourseRegistrationRequest._();
  @$core.pragma('dart2js:noInline')
  static CreateCourseRegistrationRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CreateCourseRegistrationRequest>(
          CreateCourseRegistrationRequest.$_createMessage);
  static CreateCourseRegistrationRequest? _defaultInstance;

  /// 履修する科目ID。
  @$pb.TagNumber(1)
  $core.String get subjectId => $_getSZ(0);
  @$pb.TagNumber(1)
  set subjectId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSubjectId() => $_has(0);
  @$pb.TagNumber(1)
  void clearSubjectId() => $_clearField(1);
}

/// CreateCourseRegistration の Response。
class CreateCourseRegistrationResponse extends $pb.GeneratedMessage {
  factory CreateCourseRegistrationResponse({
    CourseRegistration? courseRegistration,
  }) {
    final result = CreateCourseRegistrationResponse._();
    if (courseRegistration != null)
      result.courseRegistration = courseRegistration;
    return result;
  }

  CreateCourseRegistrationResponse._();

  factory CreateCourseRegistrationResponse.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      CreateCourseRegistrationResponse()..mergeFromBuffer(data, registry);
  factory CreateCourseRegistrationResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      CreateCourseRegistrationResponse()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CreateCourseRegistrationResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'app.v1'),
      createEmptyInstance: CreateCourseRegistrationResponse.$_createMessage)
    ..aOM<CourseRegistration>(1, _omitFieldNames ? '' : 'courseRegistration',
        subBuilder: CourseRegistration.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateCourseRegistrationResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateCourseRegistrationResponse copyWith(
          void Function(CreateCourseRegistrationResponse) updates) =>
      super.copyWith(
              (message) => updates(message as CreateCourseRegistrationResponse))
          as CreateCourseRegistrationResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use CreateCourseRegistrationResponse() / CreateCourseRegistrationResponse.new instead')
  static CreateCourseRegistrationResponse create() =>
      CreateCourseRegistrationResponse._();
  static $pb.GeneratedMessage $_createMessage() =>
      CreateCourseRegistrationResponse._();
  @$core.override
  CreateCourseRegistrationResponse createEmptyInstance() =>
      CreateCourseRegistrationResponse._();
  @$core.pragma('dart2js:noInline')
  static CreateCourseRegistrationResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CreateCourseRegistrationResponse>(
          CreateCourseRegistrationResponse.$_createMessage);
  static CreateCourseRegistrationResponse? _defaultInstance;

  /// 作成した履修情報。
  @$pb.TagNumber(1)
  CourseRegistration get courseRegistration => $_getN(0);
  @$pb.TagNumber(1)
  set courseRegistration(CourseRegistration value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasCourseRegistration() => $_has(0);
  @$pb.TagNumber(1)
  void clearCourseRegistration() => $_clearField(1);
  @$pb.TagNumber(1)
  CourseRegistration ensureCourseRegistration() => $_ensure(0);
}

/// DeleteCourseRegistration の Request。
class DeleteCourseRegistrationRequest extends $pb.GeneratedMessage {
  factory DeleteCourseRegistrationRequest({
    $core.String? id,
  }) {
    final result = DeleteCourseRegistrationRequest._();
    if (id != null) result.id = id;
    return result;
  }

  DeleteCourseRegistrationRequest._();

  factory DeleteCourseRegistrationRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      DeleteCourseRegistrationRequest()..mergeFromBuffer(data, registry);
  factory DeleteCourseRegistrationRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      DeleteCourseRegistrationRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DeleteCourseRegistrationRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'app.v1'),
      createEmptyInstance: DeleteCourseRegistrationRequest.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeleteCourseRegistrationRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeleteCourseRegistrationRequest copyWith(
          void Function(DeleteCourseRegistrationRequest) updates) =>
      super.copyWith(
              (message) => updates(message as DeleteCourseRegistrationRequest))
          as DeleteCourseRegistrationRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use DeleteCourseRegistrationRequest() / DeleteCourseRegistrationRequest.new instead')
  static DeleteCourseRegistrationRequest create() =>
      DeleteCourseRegistrationRequest._();
  static $pb.GeneratedMessage $_createMessage() =>
      DeleteCourseRegistrationRequest._();
  @$core.override
  DeleteCourseRegistrationRequest createEmptyInstance() =>
      DeleteCourseRegistrationRequest._();
  @$core.pragma('dart2js:noInline')
  static DeleteCourseRegistrationRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DeleteCourseRegistrationRequest>(
          DeleteCourseRegistrationRequest.$_createMessage);
  static DeleteCourseRegistrationRequest? _defaultInstance;

  /// 削除する履修情報ID。
  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);
}

/// DeleteCourseRegistration の Response。
class DeleteCourseRegistrationResponse extends $pb.GeneratedMessage {
  factory DeleteCourseRegistrationResponse() =>
      DeleteCourseRegistrationResponse._();

  DeleteCourseRegistrationResponse._();

  factory DeleteCourseRegistrationResponse.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      DeleteCourseRegistrationResponse()..mergeFromBuffer(data, registry);
  factory DeleteCourseRegistrationResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      DeleteCourseRegistrationResponse()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DeleteCourseRegistrationResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'app.v1'),
      createEmptyInstance: DeleteCourseRegistrationResponse.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeleteCourseRegistrationResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeleteCourseRegistrationResponse copyWith(
          void Function(DeleteCourseRegistrationResponse) updates) =>
      super.copyWith(
              (message) => updates(message as DeleteCourseRegistrationResponse))
          as DeleteCourseRegistrationResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use DeleteCourseRegistrationResponse() / DeleteCourseRegistrationResponse.new instead')
  static DeleteCourseRegistrationResponse create() =>
      DeleteCourseRegistrationResponse._();
  static $pb.GeneratedMessage $_createMessage() =>
      DeleteCourseRegistrationResponse._();
  @$core.override
  DeleteCourseRegistrationResponse createEmptyInstance() =>
      DeleteCourseRegistrationResponse._();
  @$core.pragma('dart2js:noInline')
  static DeleteCourseRegistrationResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DeleteCourseRegistrationResponse>(
          DeleteCourseRegistrationResponse.$_createMessage);
  static DeleteCourseRegistrationResponse? _defaultInstance;
}

/// ログイン中のユーザーの履修情報を管理する。
class CourseRegistrationServiceApi {
  final $pb.RpcClient _client;

  CourseRegistrationServiceApi(this._client);

  /// 履修情報の一覧を取得する。
  $async.Future<ListCourseRegistrationsResponse> listCourseRegistrations(
          $pb.ClientContext? ctx, ListCourseRegistrationsRequest request) =>
      _client.invoke<ListCourseRegistrationsResponse>(
          ctx,
          'CourseRegistrationService',
          'ListCourseRegistrations',
          request,
          ListCourseRegistrationsResponse());

  /// 履修情報を作成する。
  $async.Future<CreateCourseRegistrationResponse> createCourseRegistration(
          $pb.ClientContext? ctx, CreateCourseRegistrationRequest request) =>
      _client.invoke<CreateCourseRegistrationResponse>(
          ctx,
          'CourseRegistrationService',
          'CreateCourseRegistration',
          request,
          CreateCourseRegistrationResponse());

  /// 履修情報を削除する。ログイン中のユーザーの履修情報でない場合は PERMISSION_DENIED を返す。
  $async.Future<DeleteCourseRegistrationResponse> deleteCourseRegistration(
          $pb.ClientContext? ctx, DeleteCourseRegistrationRequest request) =>
      _client.invoke<DeleteCourseRegistrationResponse>(
          ctx,
          'CourseRegistrationService',
          'DeleteCourseRegistration',
          request,
          DeleteCourseRegistrationResponse());
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
