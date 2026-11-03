// This is a generated file - do not edit.
//
// Generated from app/v1/timetable_item.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import '../../google/type/dayofweek.pbenum.dart' as $2;
import 'common.pbenum.dart' as $3;
import 'room.pb.dart' as $1;
import 'subject.pb.dart' as $0;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

/// 時間割の枠（曜日・時限）。
class TimetableItemSlot extends $pb.GeneratedMessage {
  factory TimetableItemSlot({
    $2.DayOfWeek? dayOfWeek,
    $3.Period? period,
  }) {
    final result = TimetableItemSlot._();
    if (dayOfWeek != null) result.dayOfWeek = dayOfWeek;
    if (period != null) result.period = period;
    return result;
  }

  TimetableItemSlot._();

  factory TimetableItemSlot.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      TimetableItemSlot()..mergeFromBuffer(data, registry);
  factory TimetableItemSlot.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      TimetableItemSlot()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'TimetableItemSlot',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'app.v1'),
      createEmptyInstance: TimetableItemSlot.$_createMessage)
    ..aE<$2.DayOfWeek>(1, _omitFieldNames ? '' : 'dayOfWeek',
        enumValues: $2.DayOfWeek.values)
    ..aE<$3.Period>(2, _omitFieldNames ? '' : 'period',
        enumValues: $3.Period.values)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TimetableItemSlot clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TimetableItemSlot copyWith(void Function(TimetableItemSlot) updates) =>
      super.copyWith((message) => updates(message as TimetableItemSlot))
          as TimetableItemSlot;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use TimetableItemSlot() / TimetableItemSlot.new instead')
  static TimetableItemSlot create() => TimetableItemSlot._();
  static $pb.GeneratedMessage $_createMessage() => TimetableItemSlot._();
  @$core.override
  TimetableItemSlot createEmptyInstance() => TimetableItemSlot._();
  @$core.pragma('dart2js:noInline')
  static TimetableItemSlot getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TimetableItemSlot>(
          TimetableItemSlot.$_createMessage);
  static TimetableItemSlot? _defaultInstance;

  /// 曜日。
  @$pb.TagNumber(1)
  $2.DayOfWeek get dayOfWeek => $_getN(0);
  @$pb.TagNumber(1)
  set dayOfWeek($2.DayOfWeek value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasDayOfWeek() => $_has(0);
  @$pb.TagNumber(1)
  void clearDayOfWeek() => $_clearField(1);

  /// 時限。
  @$pb.TagNumber(2)
  $3.Period get period => $_getN(1);
  @$pb.TagNumber(2)
  set period($3.Period value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasPeriod() => $_has(1);
  @$pb.TagNumber(2)
  void clearPeriod() => $_clearField(2);
}

/// 時間割。
class TimetableItem extends $pb.GeneratedMessage {
  factory TimetableItem({
    $core.String? id,
    $0.Subject? subject,
    TimetableItemSlot? slot,
    $core.Iterable<$1.Room>? rooms,
  }) {
    final result = TimetableItem._();
    if (id != null) result.id = id;
    if (subject != null) result.subject = subject;
    if (slot != null) result.slot = slot;
    if (rooms != null) result.rooms.addAll(rooms);
    return result;
  }

  TimetableItem._();

  factory TimetableItem.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      TimetableItem()..mergeFromBuffer(data, registry);
  factory TimetableItem.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      TimetableItem()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'TimetableItem',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'app.v1'),
      createEmptyInstance: TimetableItem.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOM<$0.Subject>(2, _omitFieldNames ? '' : 'subject',
        subBuilder: $0.Subject.$_createMessage)
    ..aOM<TimetableItemSlot>(3, _omitFieldNames ? '' : 'slot',
        subBuilder: TimetableItemSlot.$_createMessage)
    ..pPM<$1.Room>(4, _omitFieldNames ? '' : 'rooms',
        subBuilder: $1.Room.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TimetableItem clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TimetableItem copyWith(void Function(TimetableItem) updates) =>
      super.copyWith((message) => updates(message as TimetableItem))
          as TimetableItem;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use TimetableItem() / TimetableItem.new instead')
  static TimetableItem create() => TimetableItem._();
  static $pb.GeneratedMessage $_createMessage() => TimetableItem._();
  @$core.override
  TimetableItem createEmptyInstance() => TimetableItem._();
  @$core.pragma('dart2js:noInline')
  static TimetableItem getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TimetableItem>(
          TimetableItem.$_createMessage);
  static TimetableItem? _defaultInstance;

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

  /// 時間割の枠。集中講義など、時間割に含まれていない場合は未設定。
  @$pb.TagNumber(3)
  TimetableItemSlot get slot => $_getN(2);
  @$pb.TagNumber(3)
  set slot(TimetableItemSlot value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasSlot() => $_has(2);
  @$pb.TagNumber(3)
  void clearSlot() => $_clearField(3);
  @$pb.TagNumber(3)
  TimetableItemSlot ensureSlot() => $_ensure(2);

  /// 教室。
  @$pb.TagNumber(4)
  $pb.PbList<$1.Room> get rooms => $_getList(3);
}

/// ListTimetableItems の Request。
class ListTimetableItemsRequest extends $pb.GeneratedMessage {
  factory ListTimetableItemsRequest({
    $core.int? year,
    $core.Iterable<$0.SubjectSemester>? semesters,
  }) {
    final result = ListTimetableItemsRequest._();
    if (year != null) result.year = year;
    if (semesters != null) result.semesters.addAll(semesters);
    return result;
  }

  ListTimetableItemsRequest._();

  factory ListTimetableItemsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ListTimetableItemsRequest()..mergeFromBuffer(data, registry);
  factory ListTimetableItemsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ListTimetableItemsRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListTimetableItemsRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'app.v1'),
      createEmptyInstance: ListTimetableItemsRequest.$_createMessage)
    ..aI(3, _omitFieldNames ? '' : 'year')
    ..pc<$0.SubjectSemester>(
        4, _omitFieldNames ? '' : 'semesters', $pb.PbFieldType.KE,
        valueOf: $0.SubjectSemester.valueOf,
        enumValues: $0.SubjectSemester.values,
        defaultEnumValue: $0.SubjectSemester.SUBJECT_SEMESTER_UNSPECIFIED)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListTimetableItemsRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListTimetableItemsRequest copyWith(
          void Function(ListTimetableItemsRequest) updates) =>
      super.copyWith((message) => updates(message as ListTimetableItemsRequest))
          as ListTimetableItemsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use ListTimetableItemsRequest() / ListTimetableItemsRequest.new instead')
  static ListTimetableItemsRequest create() => ListTimetableItemsRequest._();
  static $pb.GeneratedMessage $_createMessage() =>
      ListTimetableItemsRequest._();
  @$core.override
  ListTimetableItemsRequest createEmptyInstance() =>
      ListTimetableItemsRequest._();
  @$core.pragma('dart2js:noInline')
  static ListTimetableItemsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListTimetableItemsRequest>(
          ListTimetableItemsRequest.$_createMessage);
  static ListTimetableItemsRequest? _defaultInstance;

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

/// ListTimetableItems の Response。
class ListTimetableItemsResponse extends $pb.GeneratedMessage {
  factory ListTimetableItemsResponse({
    $core.Iterable<TimetableItem>? timetableItems,
  }) {
    final result = ListTimetableItemsResponse._();
    if (timetableItems != null) result.timetableItems.addAll(timetableItems);
    return result;
  }

  ListTimetableItemsResponse._();

  factory ListTimetableItemsResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ListTimetableItemsResponse()..mergeFromBuffer(data, registry);
  factory ListTimetableItemsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ListTimetableItemsResponse()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListTimetableItemsResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'app.v1'),
      createEmptyInstance: ListTimetableItemsResponse.$_createMessage)
    ..pPM<TimetableItem>(1, _omitFieldNames ? '' : 'timetableItems',
        subBuilder: TimetableItem.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListTimetableItemsResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListTimetableItemsResponse copyWith(
          void Function(ListTimetableItemsResponse) updates) =>
      super.copyWith(
              (message) => updates(message as ListTimetableItemsResponse))
          as ListTimetableItemsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use ListTimetableItemsResponse() / ListTimetableItemsResponse.new instead')
  static ListTimetableItemsResponse create() => ListTimetableItemsResponse._();
  static $pb.GeneratedMessage $_createMessage() =>
      ListTimetableItemsResponse._();
  @$core.override
  ListTimetableItemsResponse createEmptyInstance() =>
      ListTimetableItemsResponse._();
  @$core.pragma('dart2js:noInline')
  static ListTimetableItemsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListTimetableItemsResponse>(
          ListTimetableItemsResponse.$_createMessage);
  static ListTimetableItemsResponse? _defaultInstance;

  /// 時間割の一覧。
  @$pb.TagNumber(1)
  $pb.PbList<TimetableItem> get timetableItems => $_getList(0);
}

/// 時間割を提供する。
class TimetableItemServiceApi {
  final $pb.RpcClient _client;

  TimetableItemServiceApi(this._client);

  /// 時間割の一覧を取得する。
  $async.Future<ListTimetableItemsResponse> listTimetableItems(
          $pb.ClientContext? ctx, ListTimetableItemsRequest request) =>
      _client.invoke<ListTimetableItemsResponse>(ctx, 'TimetableItemService',
          'ListTimetableItems', request, ListTimetableItemsResponse());
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
