// This is a generated file - do not edit.
//
// Generated from app/v1/room_change.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import '../../google/type/date.pb.dart' as $1;
import 'common.pbenum.dart' as $3;
import 'room.pb.dart' as $2;
import 'subject.pb.dart' as $0;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

/// 教室変更。
class RoomChange extends $pb.GeneratedMessage {
  factory RoomChange({
    $core.String? id,
    $0.Subject? subject,
    $1.Date? date,
    $3.Period? period,
    $2.Room? originalRoom,
    $2.Room? newRoom,
  }) {
    final result = RoomChange._();
    if (id != null) result.id = id;
    if (subject != null) result.subject = subject;
    if (date != null) result.date = date;
    if (period != null) result.period = period;
    if (originalRoom != null) result.originalRoom = originalRoom;
    if (newRoom != null) result.newRoom = newRoom;
    return result;
  }

  RoomChange._();

  factory RoomChange.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      RoomChange()..mergeFromBuffer(data, registry);
  factory RoomChange.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      RoomChange()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RoomChange',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'app.v1'),
      createEmptyInstance: RoomChange.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOM<$0.Subject>(2, _omitFieldNames ? '' : 'subject',
        subBuilder: $0.Subject.$_createMessage)
    ..aOM<$1.Date>(3, _omitFieldNames ? '' : 'date',
        subBuilder: $1.Date.$_createMessage)
    ..aE<$3.Period>(4, _omitFieldNames ? '' : 'period',
        enumValues: $3.Period.values)
    ..aOM<$2.Room>(5, _omitFieldNames ? '' : 'originalRoom',
        subBuilder: $2.Room.$_createMessage)
    ..aOM<$2.Room>(6, _omitFieldNames ? '' : 'newRoom',
        subBuilder: $2.Room.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RoomChange clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RoomChange copyWith(void Function(RoomChange) updates) =>
      super.copyWith((message) => updates(message as RoomChange)) as RoomChange;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use RoomChange() / RoomChange.new instead')
  static RoomChange create() => RoomChange._();
  static $pb.GeneratedMessage $_createMessage() => RoomChange._();
  @$core.override
  RoomChange createEmptyInstance() => RoomChange._();
  @$core.pragma('dart2js:noInline')
  static RoomChange getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RoomChange>(RoomChange.$_createMessage);
  static RoomChange? _defaultInstance;

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

  /// 日付。
  @$pb.TagNumber(3)
  $1.Date get date => $_getN(2);
  @$pb.TagNumber(3)
  set date($1.Date value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasDate() => $_has(2);
  @$pb.TagNumber(3)
  void clearDate() => $_clearField(3);
  @$pb.TagNumber(3)
  $1.Date ensureDate() => $_ensure(2);

  /// 時限。
  @$pb.TagNumber(4)
  $3.Period get period => $_getN(3);
  @$pb.TagNumber(4)
  set period($3.Period value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasPeriod() => $_has(3);
  @$pb.TagNumber(4)
  void clearPeriod() => $_clearField(4);

  /// 変更前の教室。
  @$pb.TagNumber(5)
  $2.Room get originalRoom => $_getN(4);
  @$pb.TagNumber(5)
  set originalRoom($2.Room value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasOriginalRoom() => $_has(4);
  @$pb.TagNumber(5)
  void clearOriginalRoom() => $_clearField(5);
  @$pb.TagNumber(5)
  $2.Room ensureOriginalRoom() => $_ensure(4);

  /// 変更後の教室。
  @$pb.TagNumber(6)
  $2.Room get newRoom => $_getN(5);
  @$pb.TagNumber(6)
  set newRoom($2.Room value) => $_setField(6, value);
  @$pb.TagNumber(6)
  $core.bool hasNewRoom() => $_has(5);
  @$pb.TagNumber(6)
  void clearNewRoom() => $_clearField(6);
  @$pb.TagNumber(6)
  $2.Room ensureNewRoom() => $_ensure(5);
}

/// ListRoomChanges の Request。
class ListRoomChangesRequest extends $pb.GeneratedMessage {
  factory ListRoomChangesRequest({
    $core.Iterable<$core.String>? subjectIds,
    $1.Date? fromDate,
    $1.Date? untilDate,
  }) {
    final result = ListRoomChangesRequest._();
    if (subjectIds != null) result.subjectIds.addAll(subjectIds);
    if (fromDate != null) result.fromDate = fromDate;
    if (untilDate != null) result.untilDate = untilDate;
    return result;
  }

  ListRoomChangesRequest._();

  factory ListRoomChangesRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ListRoomChangesRequest()..mergeFromBuffer(data, registry);
  factory ListRoomChangesRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ListRoomChangesRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListRoomChangesRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'app.v1'),
      createEmptyInstance: ListRoomChangesRequest.$_createMessage)
    ..pPS(3, _omitFieldNames ? '' : 'subjectIds')
    ..aOM<$1.Date>(4, _omitFieldNames ? '' : 'fromDate',
        subBuilder: $1.Date.$_createMessage)
    ..aOM<$1.Date>(5, _omitFieldNames ? '' : 'untilDate',
        subBuilder: $1.Date.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListRoomChangesRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListRoomChangesRequest copyWith(
          void Function(ListRoomChangesRequest) updates) =>
      super.copyWith((message) => updates(message as ListRoomChangesRequest))
          as ListRoomChangesRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use ListRoomChangesRequest() / ListRoomChangesRequest.new instead')
  static ListRoomChangesRequest create() => ListRoomChangesRequest._();
  static $pb.GeneratedMessage $_createMessage() => ListRoomChangesRequest._();
  @$core.override
  ListRoomChangesRequest createEmptyInstance() => ListRoomChangesRequest._();
  @$core.pragma('dart2js:noInline')
  static ListRoomChangesRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListRoomChangesRequest>(
          ListRoomChangesRequest.$_createMessage);
  static ListRoomChangesRequest? _defaultInstance;

  /// 科目IDのリスト。指定した科目の教室変更のみを取得する。空の場合は全科目を対象とする。
  @$pb.TagNumber(3)
  $pb.PbList<$core.String> get subjectIds => $_getList(0);

  /// 検索対象の開始日付。未設定の場合は開始日付で絞り込まない。
  @$pb.TagNumber(4)
  $1.Date get fromDate => $_getN(1);
  @$pb.TagNumber(4)
  set fromDate($1.Date value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasFromDate() => $_has(1);
  @$pb.TagNumber(4)
  void clearFromDate() => $_clearField(4);
  @$pb.TagNumber(4)
  $1.Date ensureFromDate() => $_ensure(1);

  /// 検索対象の終了日付。未設定の場合は終了日付で絞り込まない。
  @$pb.TagNumber(5)
  $1.Date get untilDate => $_getN(2);
  @$pb.TagNumber(5)
  set untilDate($1.Date value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasUntilDate() => $_has(2);
  @$pb.TagNumber(5)
  void clearUntilDate() => $_clearField(5);
  @$pb.TagNumber(5)
  $1.Date ensureUntilDate() => $_ensure(2);
}

/// ListRoomChanges の Response。
class ListRoomChangesResponse extends $pb.GeneratedMessage {
  factory ListRoomChangesResponse({
    $core.Iterable<RoomChange>? roomChanges,
  }) {
    final result = ListRoomChangesResponse._();
    if (roomChanges != null) result.roomChanges.addAll(roomChanges);
    return result;
  }

  ListRoomChangesResponse._();

  factory ListRoomChangesResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ListRoomChangesResponse()..mergeFromBuffer(data, registry);
  factory ListRoomChangesResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ListRoomChangesResponse()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListRoomChangesResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'app.v1'),
      createEmptyInstance: ListRoomChangesResponse.$_createMessage)
    ..pPM<RoomChange>(1, _omitFieldNames ? '' : 'roomChanges',
        subBuilder: RoomChange.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListRoomChangesResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListRoomChangesResponse copyWith(
          void Function(ListRoomChangesResponse) updates) =>
      super.copyWith((message) => updates(message as ListRoomChangesResponse))
          as ListRoomChangesResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use ListRoomChangesResponse() / ListRoomChangesResponse.new instead')
  static ListRoomChangesResponse create() => ListRoomChangesResponse._();
  static $pb.GeneratedMessage $_createMessage() => ListRoomChangesResponse._();
  @$core.override
  ListRoomChangesResponse createEmptyInstance() => ListRoomChangesResponse._();
  @$core.pragma('dart2js:noInline')
  static ListRoomChangesResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListRoomChangesResponse>(
          ListRoomChangesResponse.$_createMessage);
  static ListRoomChangesResponse? _defaultInstance;

  /// 教室変更の一覧。
  @$pb.TagNumber(1)
  $pb.PbList<RoomChange> get roomChanges => $_getList(0);
}

/// 教室変更を提供する。
class RoomChangeServiceApi {
  final $pb.RpcClient _client;

  RoomChangeServiceApi(this._client);

  /// 教室変更の一覧を取得する。
  $async.Future<ListRoomChangesResponse> listRoomChanges(
          $pb.ClientContext? ctx, ListRoomChangesRequest request) =>
      _client.invoke<ListRoomChangesResponse>(ctx, 'RoomChangeService',
          'ListRoomChanges', request, ListRoomChangesResponse());
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
