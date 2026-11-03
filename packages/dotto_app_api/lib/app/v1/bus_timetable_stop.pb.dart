// This is a generated file - do not edit.
//
// Generated from app/v1/bus_timetable_stop.proto.

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

import 'bus_stop.pb.dart' as $0;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

/// バスの停車情報。
class BusTimetableStop extends $pb.GeneratedMessage {
  factory BusTimetableStop({
    $core.String? tripId,
    $0.BusStop? stop,
    $1.Timestamp? departureTime,
  }) {
    final result = BusTimetableStop._();
    if (tripId != null) result.tripId = tripId;
    if (stop != null) result.stop = stop;
    if (departureTime != null) result.departureTime = departureTime;
    return result;
  }

  BusTimetableStop._();

  factory BusTimetableStop.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      BusTimetableStop()..mergeFromBuffer(data, registry);
  factory BusTimetableStop.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      BusTimetableStop()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'BusTimetableStop',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'app.v1'),
      createEmptyInstance: BusTimetableStop.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'tripId')
    ..aOM<$0.BusStop>(2, _omitFieldNames ? '' : 'stop',
        subBuilder: $0.BusStop.$_createMessage)
    ..aOM<$1.Timestamp>(3, _omitFieldNames ? '' : 'departureTime',
        subBuilder: $1.Timestamp.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BusTimetableStop clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BusTimetableStop copyWith(void Function(BusTimetableStop) updates) =>
      super.copyWith((message) => updates(message as BusTimetableStop))
          as BusTimetableStop;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use BusTimetableStop() / BusTimetableStop.new instead')
  static BusTimetableStop create() => BusTimetableStop._();
  static $pb.GeneratedMessage $_createMessage() => BusTimetableStop._();
  @$core.override
  BusTimetableStop createEmptyInstance() => BusTimetableStop._();
  @$core.pragma('dart2js:noInline')
  static BusTimetableStop getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<BusTimetableStop>(
          BusTimetableStop.$_createMessage);
  static BusTimetableStop? _defaultInstance;

  /// 運行ID。
  @$pb.TagNumber(1)
  $core.String get tripId => $_getSZ(0);
  @$pb.TagNumber(1)
  set tripId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasTripId() => $_has(0);
  @$pb.TagNumber(1)
  void clearTripId() => $_clearField(1);

  /// バス停。
  @$pb.TagNumber(2)
  $0.BusStop get stop => $_getN(1);
  @$pb.TagNumber(2)
  set stop($0.BusStop value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasStop() => $_has(1);
  @$pb.TagNumber(2)
  void clearStop() => $_clearField(2);
  @$pb.TagNumber(2)
  $0.BusStop ensureStop() => $_ensure(1);

  /// 出発日時。
  @$pb.TagNumber(3)
  $1.Timestamp get departureTime => $_getN(2);
  @$pb.TagNumber(3)
  set departureTime($1.Timestamp value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasDepartureTime() => $_has(2);
  @$pb.TagNumber(3)
  void clearDepartureTime() => $_clearField(3);
  @$pb.TagNumber(3)
  $1.Timestamp ensureDepartureTime() => $_ensure(2);
}

/// ListBusTimetableStops の Request。
class ListBusTimetableStopsRequest extends $pb.GeneratedMessage {
  factory ListBusTimetableStopsRequest({
    $core.String? tripId,
  }) {
    final result = ListBusTimetableStopsRequest._();
    if (tripId != null) result.tripId = tripId;
    return result;
  }

  ListBusTimetableStopsRequest._();

  factory ListBusTimetableStopsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ListBusTimetableStopsRequest()..mergeFromBuffer(data, registry);
  factory ListBusTimetableStopsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ListBusTimetableStopsRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListBusTimetableStopsRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'app.v1'),
      createEmptyInstance: ListBusTimetableStopsRequest.$_createMessage)
    ..aOS(3, _omitFieldNames ? '' : 'tripId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListBusTimetableStopsRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListBusTimetableStopsRequest copyWith(
          void Function(ListBusTimetableStopsRequest) updates) =>
      super.copyWith(
              (message) => updates(message as ListBusTimetableStopsRequest))
          as ListBusTimetableStopsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use ListBusTimetableStopsRequest() / ListBusTimetableStopsRequest.new instead')
  static ListBusTimetableStopsRequest create() =>
      ListBusTimetableStopsRequest._();
  static $pb.GeneratedMessage $_createMessage() =>
      ListBusTimetableStopsRequest._();
  @$core.override
  ListBusTimetableStopsRequest createEmptyInstance() =>
      ListBusTimetableStopsRequest._();
  @$core.pragma('dart2js:noInline')
  static ListBusTimetableStopsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListBusTimetableStopsRequest>(
          ListBusTimetableStopsRequest.$_createMessage);
  static ListBusTimetableStopsRequest? _defaultInstance;

  /// 運行ID。
  @$pb.TagNumber(3)
  $core.String get tripId => $_getSZ(0);
  @$pb.TagNumber(3)
  set tripId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(3)
  $core.bool hasTripId() => $_has(0);
  @$pb.TagNumber(3)
  void clearTripId() => $_clearField(3);
}

/// ListBusTimetableStops の Response。
class ListBusTimetableStopsResponse extends $pb.GeneratedMessage {
  factory ListBusTimetableStopsResponse({
    $core.Iterable<BusTimetableStop>? busTimetableStops,
  }) {
    final result = ListBusTimetableStopsResponse._();
    if (busTimetableStops != null)
      result.busTimetableStops.addAll(busTimetableStops);
    return result;
  }

  ListBusTimetableStopsResponse._();

  factory ListBusTimetableStopsResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ListBusTimetableStopsResponse()..mergeFromBuffer(data, registry);
  factory ListBusTimetableStopsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ListBusTimetableStopsResponse()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListBusTimetableStopsResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'app.v1'),
      createEmptyInstance: ListBusTimetableStopsResponse.$_createMessage)
    ..pPM<BusTimetableStop>(1, _omitFieldNames ? '' : 'busTimetableStops',
        subBuilder: BusTimetableStop.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListBusTimetableStopsResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListBusTimetableStopsResponse copyWith(
          void Function(ListBusTimetableStopsResponse) updates) =>
      super.copyWith(
              (message) => updates(message as ListBusTimetableStopsResponse))
          as ListBusTimetableStopsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use ListBusTimetableStopsResponse() / ListBusTimetableStopsResponse.new instead')
  static ListBusTimetableStopsResponse create() =>
      ListBusTimetableStopsResponse._();
  static $pb.GeneratedMessage $_createMessage() =>
      ListBusTimetableStopsResponse._();
  @$core.override
  ListBusTimetableStopsResponse createEmptyInstance() =>
      ListBusTimetableStopsResponse._();
  @$core.pragma('dart2js:noInline')
  static ListBusTimetableStopsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListBusTimetableStopsResponse>(
          ListBusTimetableStopsResponse.$_createMessage);
  static ListBusTimetableStopsResponse? _defaultInstance;

  /// バスの停車情報の一覧。
  @$pb.TagNumber(1)
  $pb.PbList<BusTimetableStop> get busTimetableStops => $_getList(0);
}

/// バスの停車情報を提供する。
class BusTimetableStopServiceApi {
  final $pb.RpcClient _client;

  BusTimetableStopServiceApi(this._client);

  /// 運行ごとのバスの停車情報の一覧を取得する。
  $async.Future<ListBusTimetableStopsResponse> listBusTimetableStops(
          $pb.ClientContext? ctx, ListBusTimetableStopsRequest request) =>
      _client.invoke<ListBusTimetableStopsResponse>(
          ctx,
          'BusTimetableStopService',
          'ListBusTimetableStops',
          request,
          ListBusTimetableStopsResponse());
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
