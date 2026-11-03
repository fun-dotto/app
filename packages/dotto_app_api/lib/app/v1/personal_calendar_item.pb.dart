// This is a generated file - do not edit.
//
// Generated from app/v1/personal_calendar_item.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import '../../google/type/date.pb.dart' as $0;
import 'common.pbenum.dart' as $3;
import 'personal_calendar_item.pbenum.dart';
import 'room.pb.dart' as $2;
import 'subject.pb.dart' as $1;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

export 'personal_calendar_item.pbenum.dart';

/// 個人カレンダーアイテム。
class PersonalCalendarItem extends $pb.GeneratedMessage {
  factory PersonalCalendarItem({
    $0.Date? date,
    $3.Period? period,
    $1.Subject? subject,
    $core.Iterable<$2.Room>? rooms,
    PersonalCalendarItem_State? state,
  }) {
    final result = PersonalCalendarItem._();
    if (date != null) result.date = date;
    if (period != null) result.period = period;
    if (subject != null) result.subject = subject;
    if (rooms != null) result.rooms.addAll(rooms);
    if (state != null) result.state = state;
    return result;
  }

  PersonalCalendarItem._();

  factory PersonalCalendarItem.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      PersonalCalendarItem()..mergeFromBuffer(data, registry);
  factory PersonalCalendarItem.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      PersonalCalendarItem()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'PersonalCalendarItem',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'app.v1'),
      createEmptyInstance: PersonalCalendarItem.$_createMessage)
    ..aOM<$0.Date>(1, _omitFieldNames ? '' : 'date',
        subBuilder: $0.Date.$_createMessage)
    ..aE<$3.Period>(2, _omitFieldNames ? '' : 'period',
        enumValues: $3.Period.values)
    ..aOM<$1.Subject>(3, _omitFieldNames ? '' : 'subject',
        subBuilder: $1.Subject.$_createMessage)
    ..pPM<$2.Room>(4, _omitFieldNames ? '' : 'rooms',
        subBuilder: $2.Room.$_createMessage)
    ..aE<PersonalCalendarItem_State>(5, _omitFieldNames ? '' : 'state',
        enumValues: PersonalCalendarItem_State.values)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PersonalCalendarItem clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PersonalCalendarItem copyWith(void Function(PersonalCalendarItem) updates) =>
      super.copyWith((message) => updates(message as PersonalCalendarItem))
          as PersonalCalendarItem;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use PersonalCalendarItem() / PersonalCalendarItem.new instead')
  static PersonalCalendarItem create() => PersonalCalendarItem._();
  static $pb.GeneratedMessage $_createMessage() => PersonalCalendarItem._();
  @$core.override
  PersonalCalendarItem createEmptyInstance() => PersonalCalendarItem._();
  @$core.pragma('dart2js:noInline')
  static PersonalCalendarItem getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<PersonalCalendarItem>(
          PersonalCalendarItem.$_createMessage);
  static PersonalCalendarItem? _defaultInstance;

  /// 日付。
  @$pb.TagNumber(1)
  $0.Date get date => $_getN(0);
  @$pb.TagNumber(1)
  set date($0.Date value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasDate() => $_has(0);
  @$pb.TagNumber(1)
  void clearDate() => $_clearField(1);
  @$pb.TagNumber(1)
  $0.Date ensureDate() => $_ensure(0);

  /// 時限。
  @$pb.TagNumber(2)
  $3.Period get period => $_getN(1);
  @$pb.TagNumber(2)
  set period($3.Period value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasPeriod() => $_has(1);
  @$pb.TagNumber(2)
  void clearPeriod() => $_clearField(2);

  /// 科目。
  @$pb.TagNumber(3)
  $1.Subject get subject => $_getN(2);
  @$pb.TagNumber(3)
  set subject($1.Subject value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasSubject() => $_has(2);
  @$pb.TagNumber(3)
  void clearSubject() => $_clearField(3);
  @$pb.TagNumber(3)
  $1.Subject ensureSubject() => $_ensure(2);

  /// 教室。
  @$pb.TagNumber(4)
  $pb.PbList<$2.Room> get rooms => $_getList(3);

  /// 状態。
  @$pb.TagNumber(5)
  PersonalCalendarItem_State get state => $_getN(4);
  @$pb.TagNumber(5)
  set state(PersonalCalendarItem_State value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasState() => $_has(4);
  @$pb.TagNumber(5)
  void clearState() => $_clearField(5);
}

/// ListPersonalCalendarItems の Request。
class ListPersonalCalendarItemsRequest extends $pb.GeneratedMessage {
  factory ListPersonalCalendarItemsRequest({
    $core.Iterable<$0.Date>? dates,
  }) {
    final result = ListPersonalCalendarItemsRequest._();
    if (dates != null) result.dates.addAll(dates);
    return result;
  }

  ListPersonalCalendarItemsRequest._();

  factory ListPersonalCalendarItemsRequest.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ListPersonalCalendarItemsRequest()..mergeFromBuffer(data, registry);
  factory ListPersonalCalendarItemsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ListPersonalCalendarItemsRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListPersonalCalendarItemsRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'app.v1'),
      createEmptyInstance: ListPersonalCalendarItemsRequest.$_createMessage)
    ..pPM<$0.Date>(3, _omitFieldNames ? '' : 'dates',
        subBuilder: $0.Date.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListPersonalCalendarItemsRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListPersonalCalendarItemsRequest copyWith(
          void Function(ListPersonalCalendarItemsRequest) updates) =>
      super.copyWith(
              (message) => updates(message as ListPersonalCalendarItemsRequest))
          as ListPersonalCalendarItemsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use ListPersonalCalendarItemsRequest() / ListPersonalCalendarItemsRequest.new instead')
  static ListPersonalCalendarItemsRequest create() =>
      ListPersonalCalendarItemsRequest._();
  static $pb.GeneratedMessage $_createMessage() =>
      ListPersonalCalendarItemsRequest._();
  @$core.override
  ListPersonalCalendarItemsRequest createEmptyInstance() =>
      ListPersonalCalendarItemsRequest._();
  @$core.pragma('dart2js:noInline')
  static ListPersonalCalendarItemsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListPersonalCalendarItemsRequest>(
          ListPersonalCalendarItemsRequest.$_createMessage);
  static ListPersonalCalendarItemsRequest? _defaultInstance;

  /// 日付のリスト。指定した日付の個人カレンダーアイテムのみを取得する。
  @$pb.TagNumber(3)
  $pb.PbList<$0.Date> get dates => $_getList(0);
}

/// ListPersonalCalendarItems の Response。
class ListPersonalCalendarItemsResponse extends $pb.GeneratedMessage {
  factory ListPersonalCalendarItemsResponse({
    $core.Iterable<PersonalCalendarItem>? personalCalendarItems,
  }) {
    final result = ListPersonalCalendarItemsResponse._();
    if (personalCalendarItems != null)
      result.personalCalendarItems.addAll(personalCalendarItems);
    return result;
  }

  ListPersonalCalendarItemsResponse._();

  factory ListPersonalCalendarItemsResponse.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ListPersonalCalendarItemsResponse()..mergeFromBuffer(data, registry);
  factory ListPersonalCalendarItemsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ListPersonalCalendarItemsResponse()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListPersonalCalendarItemsResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'app.v1'),
      createEmptyInstance: ListPersonalCalendarItemsResponse.$_createMessage)
    ..pPM<PersonalCalendarItem>(
        1, _omitFieldNames ? '' : 'personalCalendarItems',
        subBuilder: PersonalCalendarItem.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListPersonalCalendarItemsResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListPersonalCalendarItemsResponse copyWith(
          void Function(ListPersonalCalendarItemsResponse) updates) =>
      super.copyWith((message) =>
              updates(message as ListPersonalCalendarItemsResponse))
          as ListPersonalCalendarItemsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use ListPersonalCalendarItemsResponse() / ListPersonalCalendarItemsResponse.new instead')
  static ListPersonalCalendarItemsResponse create() =>
      ListPersonalCalendarItemsResponse._();
  static $pb.GeneratedMessage $_createMessage() =>
      ListPersonalCalendarItemsResponse._();
  @$core.override
  ListPersonalCalendarItemsResponse createEmptyInstance() =>
      ListPersonalCalendarItemsResponse._();
  @$core.pragma('dart2js:noInline')
  static ListPersonalCalendarItemsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListPersonalCalendarItemsResponse>(
          ListPersonalCalendarItemsResponse.$_createMessage);
  static ListPersonalCalendarItemsResponse? _defaultInstance;

  /// 個人カレンダーアイテムの一覧。
  @$pb.TagNumber(1)
  $pb.PbList<PersonalCalendarItem> get personalCalendarItems => $_getList(0);
}

/// ログイン中のユーザーの個人カレンダーを提供する。
class PersonalCalendarItemServiceApi {
  final $pb.RpcClient _client;

  PersonalCalendarItemServiceApi(this._client);

  /// 個人カレンダーアイテムの一覧を取得する。時間割、履修情報、休講・補講、振替授業日情報から構築する。
  $async.Future<ListPersonalCalendarItemsResponse> listPersonalCalendarItems(
          $pb.ClientContext? ctx, ListPersonalCalendarItemsRequest request) =>
      _client.invoke<ListPersonalCalendarItemsResponse>(
          ctx,
          'PersonalCalendarItemService',
          'ListPersonalCalendarItems',
          request,
          ListPersonalCalendarItemsResponse());
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
