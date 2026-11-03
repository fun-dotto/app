// This is a generated file - do not edit.
//
// Generated from app/v1/bus_trip.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports
// ignore_for_file: unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

import 'package:protobuf/well_known_types/google/protobuf/duration.pbjson.dart'
    as $3;
import 'package:protobuf/well_known_types/google/protobuf/timestamp.pbjson.dart'
    as $0;

import '../../google/type/date.pbjson.dart' as $4;
import 'bus_route.pbjson.dart' as $1;
import 'bus_stop.pbjson.dart' as $2;

@$core.Deprecated('Use busTripAlertDescriptor instead')
const BusTripAlert$json = {
  '1': 'BusTripAlert',
  '2': [
    {'1': 'BUS_TRIP_ALERT_UNSPECIFIED', '2': 0},
    {'1': 'BUS_TRIP_ALERT_NONE', '2': 1},
    {'1': 'BUS_TRIP_ALERT_CANCELLATION', '2': 2},
  ],
};

/// Descriptor for `BusTripAlert`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List busTripAlertDescriptor = $convert.base64Decode(
    'CgxCdXNUcmlwQWxlcnQSHgoaQlVTX1RSSVBfQUxFUlRfVU5TUEVDSUZJRUQQABIXChNCVVNfVF'
    'JJUF9BTEVSVF9OT05FEAESHwobQlVTX1RSSVBfQUxFUlRfQ0FOQ0VMTEFUSU9OEAI=');

@$core.Deprecated('Use busTripDescriptor instead')
const BusTrip$json = {
  '1': 'BusTrip',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '8': {}, '10': 'id'},
    {
      '1': 'departure_time',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '8': {},
      '10': 'departureTime'
    },
    {
      '1': 'arrival_time',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '8': {},
      '10': 'arrivalTime'
    },
    {
      '1': 'route',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.app.v1.BusRoute',
      '8': {},
      '10': 'route'
    },
    {
      '1': 'stops',
      '3': 5,
      '4': 3,
      '5': 11,
      '6': '.app.v1.BusStop',
      '8': {},
      '10': 'stops'
    },
    {
      '1': 'delay',
      '3': 6,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Duration',
      '8': {},
      '10': 'delay'
    },
    {
      '1': 'alert',
      '3': 7,
      '4': 1,
      '5': 14,
      '6': '.app.v1.BusTripAlert',
      '8': {},
      '10': 'alert'
    },
  ],
};

/// Descriptor for `BusTrip`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List busTripDescriptor = $convert.base64Decode(
    'CgdCdXNUcmlwEhMKAmlkGAEgASgJQgPgQQNSAmlkEkYKDmRlcGFydHVyZV90aW1lGAIgASgLMh'
    'ouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcEID4EEDUg1kZXBhcnR1cmVUaW1lEkIKDGFycml2'
    'YWxfdGltZRgDIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBCA+BBA1ILYXJyaXZhbF'
    'RpbWUSKwoFcm91dGUYBCABKAsyEC5hcHAudjEuQnVzUm91dGVCA+BBA1IFcm91dGUSKgoFc3Rv'
    'cHMYBSADKAsyDy5hcHAudjEuQnVzU3RvcEID4EEDUgVzdG9wcxI0CgVkZWxheRgGIAEoCzIZLm'
    'dvb2dsZS5wcm90b2J1Zi5EdXJhdGlvbkID4EEDUgVkZWxheRIvCgVhbGVydBgHIAEoDjIULmFw'
    'cC52MS5CdXNUcmlwQWxlcnRCA+BBA1IFYWxlcnQ=');

@$core.Deprecated('Use listBusTripsRequestDescriptor instead')
const ListBusTripsRequest$json = {
  '1': 'ListBusTripsRequest',
  '2': [
    {
      '1': 'date',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.google.type.Date',
      '8': {},
      '10': 'date'
    },
  ],
  '9': [
    {'1': 1, '2': 2},
    {'1': 2, '2': 3},
  ],
  '10': ['page_size', 'page_token'],
};

/// Descriptor for `ListBusTripsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listBusTripsRequestDescriptor = $convert.base64Decode(
    'ChNMaXN0QnVzVHJpcHNSZXF1ZXN0EioKBGRhdGUYAyABKAsyES5nb29nbGUudHlwZS5EYXRlQg'
    'PgQQJSBGRhdGVKBAgBEAJKBAgCEANSCXBhZ2Vfc2l6ZVIKcGFnZV90b2tlbg==');

@$core.Deprecated('Use listBusTripsResponseDescriptor instead')
const ListBusTripsResponse$json = {
  '1': 'ListBusTripsResponse',
  '2': [
    {
      '1': 'bus_trips',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.app.v1.BusTrip',
      '10': 'busTrips'
    },
  ],
  '9': [
    {'1': 2, '2': 3},
  ],
  '10': ['next_page_token'],
};

/// Descriptor for `ListBusTripsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listBusTripsResponseDescriptor = $convert.base64Decode(
    'ChRMaXN0QnVzVHJpcHNSZXNwb25zZRIsCglidXNfdHJpcHMYASADKAsyDy5hcHAudjEuQnVzVH'
    'JpcFIIYnVzVHJpcHNKBAgCEANSD25leHRfcGFnZV90b2tlbg==');

const $core.Map<$core.String, $core.dynamic> BusTripServiceBase$json = {
  '1': 'BusTripService',
  '2': [
    {
      '1': 'ListBusTrips',
      '2': '.app.v1.ListBusTripsRequest',
      '3': '.app.v1.ListBusTripsResponse'
    },
  ],
};

@$core.Deprecated('Use busTripServiceDescriptor instead')
const $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>>
    BusTripServiceBase$messageJson = {
  '.app.v1.ListBusTripsRequest': ListBusTripsRequest$json,
  '.google.type.Date': $4.Date$json,
  '.app.v1.ListBusTripsResponse': ListBusTripsResponse$json,
  '.app.v1.BusTrip': BusTrip$json,
  '.google.protobuf.Timestamp': $0.Timestamp$json,
  '.app.v1.BusRoute': $1.BusRoute$json,
  '.app.v1.BusStop': $2.BusStop$json,
  '.google.protobuf.Duration': $3.Duration$json,
};

/// Descriptor for `BusTripService`. Decode as a `google.protobuf.ServiceDescriptorProto`.
final $typed_data.Uint8List busTripServiceDescriptor = $convert.base64Decode(
    'Cg5CdXNUcmlwU2VydmljZRJJCgxMaXN0QnVzVHJpcHMSGy5hcHAudjEuTGlzdEJ1c1RyaXBzUm'
    'VxdWVzdBocLmFwcC52MS5MaXN0QnVzVHJpcHNSZXNwb25zZQ==');
