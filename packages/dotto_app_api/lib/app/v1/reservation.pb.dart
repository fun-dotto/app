// This is a generated file - do not edit.
//
// Generated from app/v1/reservation.proto.

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
    as $1;

import 'room.pb.dart' as $0;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

/// 教室の予約。
class Reservation extends $pb.GeneratedMessage {
  factory Reservation({
    $core.String? id,
    $0.Room? room,
    $1.Timestamp? startAt,
    $1.Timestamp? endAt,
    $core.String? title,
  }) {
    final result = Reservation._();
    if (id != null) result.id = id;
    if (room != null) result.room = room;
    if (startAt != null) result.startAt = startAt;
    if (endAt != null) result.endAt = endAt;
    if (title != null) result.title = title;
    return result;
  }

  Reservation._();

  factory Reservation.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      Reservation()..mergeFromBuffer(data, registry);
  factory Reservation.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      Reservation()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Reservation',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'app.v1'),
      createEmptyInstance: Reservation.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOM<$0.Room>(2, _omitFieldNames ? '' : 'room',
        subBuilder: $0.Room.$_createMessage)
    ..aOM<$1.Timestamp>(3, _omitFieldNames ? '' : 'startAt',
        subBuilder: $1.Timestamp.$_createMessage)
    ..aOM<$1.Timestamp>(4, _omitFieldNames ? '' : 'endAt',
        subBuilder: $1.Timestamp.$_createMessage)
    ..aOS(5, _omitFieldNames ? '' : 'title')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Reservation clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Reservation copyWith(void Function(Reservation) updates) =>
      super.copyWith((message) => updates(message as Reservation))
          as Reservation;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use Reservation() / Reservation.new instead')
  static Reservation create() => Reservation._();
  static $pb.GeneratedMessage $_createMessage() => Reservation._();
  @$core.override
  Reservation createEmptyInstance() => Reservation._();
  @$core.pragma('dart2js:noInline')
  static Reservation getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Reservation>(
          Reservation.$_createMessage);
  static Reservation? _defaultInstance;

  /// ID。
  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  /// 教室。
  @$pb.TagNumber(2)
  $0.Room get room => $_getN(1);
  @$pb.TagNumber(2)
  set room($0.Room value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasRoom() => $_has(1);
  @$pb.TagNumber(2)
  void clearRoom() => $_clearField(2);
  @$pb.TagNumber(2)
  $0.Room ensureRoom() => $_ensure(1);

  /// 開始日時。
  @$pb.TagNumber(3)
  $1.Timestamp get startAt => $_getN(2);
  @$pb.TagNumber(3)
  set startAt($1.Timestamp value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasStartAt() => $_has(2);
  @$pb.TagNumber(3)
  void clearStartAt() => $_clearField(3);
  @$pb.TagNumber(3)
  $1.Timestamp ensureStartAt() => $_ensure(2);

  /// 終了日時。
  @$pb.TagNumber(4)
  $1.Timestamp get endAt => $_getN(3);
  @$pb.TagNumber(4)
  set endAt($1.Timestamp value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasEndAt() => $_has(3);
  @$pb.TagNumber(4)
  void clearEndAt() => $_clearField(4);
  @$pb.TagNumber(4)
  $1.Timestamp ensureEndAt() => $_ensure(3);

  /// タイトル。
  @$pb.TagNumber(5)
  $core.String get title => $_getSZ(4);
  @$pb.TagNumber(5)
  set title($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasTitle() => $_has(4);
  @$pb.TagNumber(5)
  void clearTitle() => $_clearField(5);
}

/// ListReservations の Request。
class ListReservationsRequest extends $pb.GeneratedMessage {
  factory ListReservationsRequest({
    $core.Iterable<$core.String>? roomIds,
    $1.Timestamp? fromTime,
    $1.Timestamp? untilTime,
  }) {
    final result = ListReservationsRequest._();
    if (roomIds != null) result.roomIds.addAll(roomIds);
    if (fromTime != null) result.fromTime = fromTime;
    if (untilTime != null) result.untilTime = untilTime;
    return result;
  }

  ListReservationsRequest._();

  factory ListReservationsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ListReservationsRequest()..mergeFromBuffer(data, registry);
  factory ListReservationsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ListReservationsRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListReservationsRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'app.v1'),
      createEmptyInstance: ListReservationsRequest.$_createMessage)
    ..pPS(3, _omitFieldNames ? '' : 'roomIds')
    ..aOM<$1.Timestamp>(4, _omitFieldNames ? '' : 'fromTime',
        subBuilder: $1.Timestamp.$_createMessage)
    ..aOM<$1.Timestamp>(5, _omitFieldNames ? '' : 'untilTime',
        subBuilder: $1.Timestamp.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListReservationsRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListReservationsRequest copyWith(
          void Function(ListReservationsRequest) updates) =>
      super.copyWith((message) => updates(message as ListReservationsRequest))
          as ListReservationsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use ListReservationsRequest() / ListReservationsRequest.new instead')
  static ListReservationsRequest create() => ListReservationsRequest._();
  static $pb.GeneratedMessage $_createMessage() => ListReservationsRequest._();
  @$core.override
  ListReservationsRequest createEmptyInstance() => ListReservationsRequest._();
  @$core.pragma('dart2js:noInline')
  static ListReservationsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListReservationsRequest>(
          ListReservationsRequest.$_createMessage);
  static ListReservationsRequest? _defaultInstance;

  /// 教室IDのリスト。空の場合は全教室を対象とする。
  @$pb.TagNumber(3)
  $pb.PbList<$core.String> get roomIds => $_getList(0);

  /// 検索対象の開始日時。未設定の場合は開始日時で絞り込まない。
  @$pb.TagNumber(4)
  $1.Timestamp get fromTime => $_getN(1);
  @$pb.TagNumber(4)
  set fromTime($1.Timestamp value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasFromTime() => $_has(1);
  @$pb.TagNumber(4)
  void clearFromTime() => $_clearField(4);
  @$pb.TagNumber(4)
  $1.Timestamp ensureFromTime() => $_ensure(1);

  /// 検索対象の終了日時。未設定の場合は終了日時で絞り込まない。
  @$pb.TagNumber(5)
  $1.Timestamp get untilTime => $_getN(2);
  @$pb.TagNumber(5)
  set untilTime($1.Timestamp value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasUntilTime() => $_has(2);
  @$pb.TagNumber(5)
  void clearUntilTime() => $_clearField(5);
  @$pb.TagNumber(5)
  $1.Timestamp ensureUntilTime() => $_ensure(2);
}

/// ListReservations の Response。
class ListReservationsResponse extends $pb.GeneratedMessage {
  factory ListReservationsResponse({
    $core.Iterable<Reservation>? reservations,
  }) {
    final result = ListReservationsResponse._();
    if (reservations != null) result.reservations.addAll(reservations);
    return result;
  }

  ListReservationsResponse._();

  factory ListReservationsResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ListReservationsResponse()..mergeFromBuffer(data, registry);
  factory ListReservationsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ListReservationsResponse()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListReservationsResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'app.v1'),
      createEmptyInstance: ListReservationsResponse.$_createMessage)
    ..pPM<Reservation>(1, _omitFieldNames ? '' : 'reservations',
        subBuilder: Reservation.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListReservationsResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListReservationsResponse copyWith(
          void Function(ListReservationsResponse) updates) =>
      super.copyWith((message) => updates(message as ListReservationsResponse))
          as ListReservationsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use ListReservationsResponse() / ListReservationsResponse.new instead')
  static ListReservationsResponse create() => ListReservationsResponse._();
  static $pb.GeneratedMessage $_createMessage() => ListReservationsResponse._();
  @$core.override
  ListReservationsResponse createEmptyInstance() =>
      ListReservationsResponse._();
  @$core.pragma('dart2js:noInline')
  static ListReservationsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListReservationsResponse>(
          ListReservationsResponse.$_createMessage);
  static ListReservationsResponse? _defaultInstance;

  /// 教室の予約の一覧。
  @$pb.TagNumber(1)
  $pb.PbList<Reservation> get reservations => $_getList(0);
}

/// 教室の予約を提供する。
class ReservationServiceApi {
  final $pb.RpcClient _client;

  ReservationServiceApi(this._client);

  /// 教室の予約の一覧を取得する。検索対象期間に一部でも重複する予約を取得する。
  $async.Future<ListReservationsResponse> listReservations(
          $pb.ClientContext? ctx, ListReservationsRequest request) =>
      _client.invoke<ListReservationsResponse>(ctx, 'ReservationService',
          'ListReservations', request, ListReservationsResponse());
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
