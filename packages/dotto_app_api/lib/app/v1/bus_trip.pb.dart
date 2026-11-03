// This is a generated file - do not edit.
//
// Generated from app/v1/bus_trip.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;
import 'package:protobuf/well_known_types/google/protobuf/duration.pb.dart'
    as $3;
import 'package:protobuf/well_known_types/google/protobuf/timestamp.pb.dart'
    as $0;

import '../../google/type/date.pb.dart' as $4;
import 'bus_route.pb.dart' as $1;
import 'bus_stop.pb.dart' as $2;
import 'bus_trip.pbenum.dart';

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

export 'bus_trip.pbenum.dart';

/// バスの運行情報。
class BusTrip extends $pb.GeneratedMessage {
  factory BusTrip({
    $core.String? id,
    $0.Timestamp? departureTime,
    $0.Timestamp? arrivalTime,
    $1.BusRoute? route,
    $core.Iterable<$2.BusStop>? stops,
    $3.Duration? delay,
    BusTripAlert? alert,
  }) {
    final result = BusTrip._();
    if (id != null) result.id = id;
    if (departureTime != null) result.departureTime = departureTime;
    if (arrivalTime != null) result.arrivalTime = arrivalTime;
    if (route != null) result.route = route;
    if (stops != null) result.stops.addAll(stops);
    if (delay != null) result.delay = delay;
    if (alert != null) result.alert = alert;
    return result;
  }

  BusTrip._();

  factory BusTrip.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      BusTrip()..mergeFromBuffer(data, registry);
  factory BusTrip.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      BusTrip()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'BusTrip',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'app.v1'),
      createEmptyInstance: BusTrip.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOM<$0.Timestamp>(2, _omitFieldNames ? '' : 'departureTime',
        subBuilder: $0.Timestamp.$_createMessage)
    ..aOM<$0.Timestamp>(3, _omitFieldNames ? '' : 'arrivalTime',
        subBuilder: $0.Timestamp.$_createMessage)
    ..aOM<$1.BusRoute>(4, _omitFieldNames ? '' : 'route',
        subBuilder: $1.BusRoute.$_createMessage)
    ..pPM<$2.BusStop>(5, _omitFieldNames ? '' : 'stops',
        subBuilder: $2.BusStop.$_createMessage)
    ..aOM<$3.Duration>(6, _omitFieldNames ? '' : 'delay',
        subBuilder: $3.Duration.$_createMessage)
    ..aE<BusTripAlert>(7, _omitFieldNames ? '' : 'alert',
        enumValues: BusTripAlert.values)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BusTrip clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BusTrip copyWith(void Function(BusTrip) updates) =>
      super.copyWith((message) => updates(message as BusTrip)) as BusTrip;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use BusTrip() / BusTrip.new instead')
  static BusTrip create() => BusTrip._();
  static $pb.GeneratedMessage $_createMessage() => BusTrip._();
  @$core.override
  BusTrip createEmptyInstance() => BusTrip._();
  @$core.pragma('dart2js:noInline')
  static BusTrip getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<BusTrip>(BusTrip.$_createMessage);
  static BusTrip? _defaultInstance;

  /// ID。
  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  /// 出発日時。
  @$pb.TagNumber(2)
  $0.Timestamp get departureTime => $_getN(1);
  @$pb.TagNumber(2)
  set departureTime($0.Timestamp value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasDepartureTime() => $_has(1);
  @$pb.TagNumber(2)
  void clearDepartureTime() => $_clearField(2);
  @$pb.TagNumber(2)
  $0.Timestamp ensureDepartureTime() => $_ensure(1);

  /// 到着日時。
  @$pb.TagNumber(3)
  $0.Timestamp get arrivalTime => $_getN(2);
  @$pb.TagNumber(3)
  set arrivalTime($0.Timestamp value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasArrivalTime() => $_has(2);
  @$pb.TagNumber(3)
  void clearArrivalTime() => $_clearField(3);
  @$pb.TagNumber(3)
  $0.Timestamp ensureArrivalTime() => $_ensure(2);

  /// 路線。
  @$pb.TagNumber(4)
  $1.BusRoute get route => $_getN(3);
  @$pb.TagNumber(4)
  set route($1.BusRoute value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasRoute() => $_has(3);
  @$pb.TagNumber(4)
  void clearRoute() => $_clearField(4);
  @$pb.TagNumber(4)
  $1.BusRoute ensureRoute() => $_ensure(3);

  /// 乗車バス停、乗り換えバス停、降車バス停のリスト。
  @$pb.TagNumber(5)
  $pb.PbList<$2.BusStop> get stops => $_getList(4);

  /// 遅延時間。
  @$pb.TagNumber(6)
  $3.Duration get delay => $_getN(5);
  @$pb.TagNumber(6)
  set delay($3.Duration value) => $_setField(6, value);
  @$pb.TagNumber(6)
  $core.bool hasDelay() => $_has(5);
  @$pb.TagNumber(6)
  void clearDelay() => $_clearField(6);
  @$pb.TagNumber(6)
  $3.Duration ensureDelay() => $_ensure(5);

  /// 運行の注意情報。
  @$pb.TagNumber(7)
  BusTripAlert get alert => $_getN(6);
  @$pb.TagNumber(7)
  set alert(BusTripAlert value) => $_setField(7, value);
  @$pb.TagNumber(7)
  $core.bool hasAlert() => $_has(6);
  @$pb.TagNumber(7)
  void clearAlert() => $_clearField(7);
}

/// ListBusTrips の Request。
class ListBusTripsRequest extends $pb.GeneratedMessage {
  factory ListBusTripsRequest({
    $4.Date? date,
  }) {
    final result = ListBusTripsRequest._();
    if (date != null) result.date = date;
    return result;
  }

  ListBusTripsRequest._();

  factory ListBusTripsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ListBusTripsRequest()..mergeFromBuffer(data, registry);
  factory ListBusTripsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ListBusTripsRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListBusTripsRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'app.v1'),
      createEmptyInstance: ListBusTripsRequest.$_createMessage)
    ..aOM<$4.Date>(3, _omitFieldNames ? '' : 'date',
        subBuilder: $4.Date.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListBusTripsRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListBusTripsRequest copyWith(void Function(ListBusTripsRequest) updates) =>
      super.copyWith((message) => updates(message as ListBusTripsRequest))
          as ListBusTripsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core
      .Deprecated('Use ListBusTripsRequest() / ListBusTripsRequest.new instead')
  static ListBusTripsRequest create() => ListBusTripsRequest._();
  static $pb.GeneratedMessage $_createMessage() => ListBusTripsRequest._();
  @$core.override
  ListBusTripsRequest createEmptyInstance() => ListBusTripsRequest._();
  @$core.pragma('dart2js:noInline')
  static ListBusTripsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListBusTripsRequest>(
          ListBusTripsRequest.$_createMessage);
  static ListBusTripsRequest? _defaultInstance;

  /// 運行情報を取得する日付。
  @$pb.TagNumber(3)
  $4.Date get date => $_getN(0);
  @$pb.TagNumber(3)
  set date($4.Date value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasDate() => $_has(0);
  @$pb.TagNumber(3)
  void clearDate() => $_clearField(3);
  @$pb.TagNumber(3)
  $4.Date ensureDate() => $_ensure(0);
}

/// ListBusTrips の Response。
class ListBusTripsResponse extends $pb.GeneratedMessage {
  factory ListBusTripsResponse({
    $core.Iterable<BusTrip>? busTrips,
  }) {
    final result = ListBusTripsResponse._();
    if (busTrips != null) result.busTrips.addAll(busTrips);
    return result;
  }

  ListBusTripsResponse._();

  factory ListBusTripsResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ListBusTripsResponse()..mergeFromBuffer(data, registry);
  factory ListBusTripsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ListBusTripsResponse()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListBusTripsResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'app.v1'),
      createEmptyInstance: ListBusTripsResponse.$_createMessage)
    ..pPM<BusTrip>(1, _omitFieldNames ? '' : 'busTrips',
        subBuilder: BusTrip.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListBusTripsResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListBusTripsResponse copyWith(void Function(ListBusTripsResponse) updates) =>
      super.copyWith((message) => updates(message as ListBusTripsResponse))
          as ListBusTripsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use ListBusTripsResponse() / ListBusTripsResponse.new instead')
  static ListBusTripsResponse create() => ListBusTripsResponse._();
  static $pb.GeneratedMessage $_createMessage() => ListBusTripsResponse._();
  @$core.override
  ListBusTripsResponse createEmptyInstance() => ListBusTripsResponse._();
  @$core.pragma('dart2js:noInline')
  static ListBusTripsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListBusTripsResponse>(
          ListBusTripsResponse.$_createMessage);
  static ListBusTripsResponse? _defaultInstance;

  /// バスの運行情報の一覧。
  @$pb.TagNumber(1)
  $pb.PbList<BusTrip> get busTrips => $_getList(0);
}

/// バスの運行情報を提供する。
class BusTripServiceApi {
  final $pb.RpcClient _client;

  BusTripServiceApi(this._client);

  /// バスの運行情報の一覧を取得する。
  $async.Future<ListBusTripsResponse> listBusTrips(
          $pb.ClientContext? ctx, ListBusTripsRequest request) =>
      _client.invoke<ListBusTripsResponse>(ctx, 'BusTripService',
          'ListBusTrips', request, ListBusTripsResponse());
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
