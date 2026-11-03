// This is a generated file - do not edit.
//
// Generated from app/v1/fcm_token.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;
import 'package:protobuf/well_known_types/google/protobuf/timestamp.pb.dart'
    as $0;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

/// FCM トークン。
class FcmToken extends $pb.GeneratedMessage {
  factory FcmToken({
    $core.String? token,
    $0.Timestamp? createdAt,
    $0.Timestamp? updatedAt,
  }) {
    final result = FcmToken._();
    if (token != null) result.token = token;
    if (createdAt != null) result.createdAt = createdAt;
    if (updatedAt != null) result.updatedAt = updatedAt;
    return result;
  }

  FcmToken._();

  factory FcmToken.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      FcmToken()..mergeFromBuffer(data, registry);
  factory FcmToken.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      FcmToken()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'FcmToken',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'app.v1'),
      createEmptyInstance: FcmToken.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'token')
    ..aOM<$0.Timestamp>(2, _omitFieldNames ? '' : 'createdAt',
        subBuilder: $0.Timestamp.$_createMessage)
    ..aOM<$0.Timestamp>(3, _omitFieldNames ? '' : 'updatedAt',
        subBuilder: $0.Timestamp.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FcmToken clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FcmToken copyWith(void Function(FcmToken) updates) =>
      super.copyWith((message) => updates(message as FcmToken)) as FcmToken;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use FcmToken() / FcmToken.new instead')
  static FcmToken create() => FcmToken._();
  static $pb.GeneratedMessage $_createMessage() => FcmToken._();
  @$core.override
  FcmToken createEmptyInstance() => FcmToken._();
  @$core.pragma('dart2js:noInline')
  static FcmToken getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<FcmToken>(FcmToken.$_createMessage);
  static FcmToken? _defaultInstance;

  /// FCM トークン。
  @$pb.TagNumber(1)
  $core.String get token => $_getSZ(0);
  @$pb.TagNumber(1)
  set token($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasToken() => $_has(0);
  @$pb.TagNumber(1)
  void clearToken() => $_clearField(1);

  /// 作成日時。
  @$pb.TagNumber(2)
  $0.Timestamp get createdAt => $_getN(1);
  @$pb.TagNumber(2)
  set createdAt($0.Timestamp value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasCreatedAt() => $_has(1);
  @$pb.TagNumber(2)
  void clearCreatedAt() => $_clearField(2);
  @$pb.TagNumber(2)
  $0.Timestamp ensureCreatedAt() => $_ensure(1);

  /// 更新日時。
  @$pb.TagNumber(3)
  $0.Timestamp get updatedAt => $_getN(2);
  @$pb.TagNumber(3)
  set updatedAt($0.Timestamp value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasUpdatedAt() => $_has(2);
  @$pb.TagNumber(3)
  void clearUpdatedAt() => $_clearField(3);
  @$pb.TagNumber(3)
  $0.Timestamp ensureUpdatedAt() => $_ensure(2);
}

/// RegisterFcmToken の Request。
class RegisterFcmTokenRequest extends $pb.GeneratedMessage {
  factory RegisterFcmTokenRequest({
    $core.String? token,
  }) {
    final result = RegisterFcmTokenRequest._();
    if (token != null) result.token = token;
    return result;
  }

  RegisterFcmTokenRequest._();

  factory RegisterFcmTokenRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      RegisterFcmTokenRequest()..mergeFromBuffer(data, registry);
  factory RegisterFcmTokenRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      RegisterFcmTokenRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RegisterFcmTokenRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'app.v1'),
      createEmptyInstance: RegisterFcmTokenRequest.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'token')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RegisterFcmTokenRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RegisterFcmTokenRequest copyWith(
          void Function(RegisterFcmTokenRequest) updates) =>
      super.copyWith((message) => updates(message as RegisterFcmTokenRequest))
          as RegisterFcmTokenRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use RegisterFcmTokenRequest() / RegisterFcmTokenRequest.new instead')
  static RegisterFcmTokenRequest create() => RegisterFcmTokenRequest._();
  static $pb.GeneratedMessage $_createMessage() => RegisterFcmTokenRequest._();
  @$core.override
  RegisterFcmTokenRequest createEmptyInstance() => RegisterFcmTokenRequest._();
  @$core.pragma('dart2js:noInline')
  static RegisterFcmTokenRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RegisterFcmTokenRequest>(
          RegisterFcmTokenRequest.$_createMessage);
  static RegisterFcmTokenRequest? _defaultInstance;

  /// 登録する FCM トークン。
  @$pb.TagNumber(1)
  $core.String get token => $_getSZ(0);
  @$pb.TagNumber(1)
  set token($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasToken() => $_has(0);
  @$pb.TagNumber(1)
  void clearToken() => $_clearField(1);
}

/// RegisterFcmToken の Response。
class RegisterFcmTokenResponse extends $pb.GeneratedMessage {
  factory RegisterFcmTokenResponse({
    FcmToken? fcmToken,
  }) {
    final result = RegisterFcmTokenResponse._();
    if (fcmToken != null) result.fcmToken = fcmToken;
    return result;
  }

  RegisterFcmTokenResponse._();

  factory RegisterFcmTokenResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      RegisterFcmTokenResponse()..mergeFromBuffer(data, registry);
  factory RegisterFcmTokenResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      RegisterFcmTokenResponse()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RegisterFcmTokenResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'app.v1'),
      createEmptyInstance: RegisterFcmTokenResponse.$_createMessage)
    ..aOM<FcmToken>(1, _omitFieldNames ? '' : 'fcmToken',
        subBuilder: FcmToken.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RegisterFcmTokenResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RegisterFcmTokenResponse copyWith(
          void Function(RegisterFcmTokenResponse) updates) =>
      super.copyWith((message) => updates(message as RegisterFcmTokenResponse))
          as RegisterFcmTokenResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use RegisterFcmTokenResponse() / RegisterFcmTokenResponse.new instead')
  static RegisterFcmTokenResponse create() => RegisterFcmTokenResponse._();
  static $pb.GeneratedMessage $_createMessage() => RegisterFcmTokenResponse._();
  @$core.override
  RegisterFcmTokenResponse createEmptyInstance() =>
      RegisterFcmTokenResponse._();
  @$core.pragma('dart2js:noInline')
  static RegisterFcmTokenResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RegisterFcmTokenResponse>(
          RegisterFcmTokenResponse.$_createMessage);
  static RegisterFcmTokenResponse? _defaultInstance;

  /// 登録した FCM トークン。
  @$pb.TagNumber(1)
  FcmToken get fcmToken => $_getN(0);
  @$pb.TagNumber(1)
  set fcmToken(FcmToken value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasFcmToken() => $_has(0);
  @$pb.TagNumber(1)
  void clearFcmToken() => $_clearField(1);
  @$pb.TagNumber(1)
  FcmToken ensureFcmToken() => $_ensure(0);
}

/// ログイン中のユーザーの FCM トークンを管理する。
class FcmTokenServiceApi {
  final $pb.RpcClient _client;

  FcmTokenServiceApi(this._client);

  /// FCM トークンを登録する。存在しない場合は作成し、存在する場合は更新日時を更新する。
  /// 他のユーザーに登録済みのトークンの場合は PERMISSION_DENIED を返す。
  $async.Future<RegisterFcmTokenResponse> registerFcmToken(
          $pb.ClientContext? ctx, RegisterFcmTokenRequest request) =>
      _client.invoke<RegisterFcmTokenResponse>(ctx, 'FcmTokenService',
          'RegisterFcmToken', request, RegisterFcmTokenResponse());
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
