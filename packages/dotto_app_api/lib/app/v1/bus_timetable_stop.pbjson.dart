// This is a generated file - do not edit.
//
// Generated from app/v1/bus_timetable_stop.proto.

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

import 'package:protobuf/well_known_types/google/protobuf/timestamp.pbjson.dart'
    as $1;

import 'bus_stop.pbjson.dart' as $0;

@$core.Deprecated('Use busTimetableStopDescriptor instead')
const BusTimetableStop$json = {
  '1': 'BusTimetableStop',
  '2': [
    {'1': 'trip_id', '3': 1, '4': 1, '5': 9, '8': {}, '10': 'tripId'},
    {
      '1': 'stop',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.app.v1.BusStop',
      '8': {},
      '10': 'stop'
    },
    {
      '1': 'departure_time',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '8': {},
      '10': 'departureTime'
    },
  ],
};

/// Descriptor for `BusTimetableStop`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List busTimetableStopDescriptor = $convert.base64Decode(
    'ChBCdXNUaW1ldGFibGVTdG9wEhwKB3RyaXBfaWQYASABKAlCA+BBA1IGdHJpcElkEigKBHN0b3'
    'AYAiABKAsyDy5hcHAudjEuQnVzU3RvcEID4EEDUgRzdG9wEkYKDmRlcGFydHVyZV90aW1lGAMg'
    'ASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcEID4EEDUg1kZXBhcnR1cmVUaW1l');

@$core.Deprecated('Use listBusTimetableStopsRequestDescriptor instead')
const ListBusTimetableStopsRequest$json = {
  '1': 'ListBusTimetableStopsRequest',
  '2': [
    {'1': 'trip_id', '3': 3, '4': 1, '5': 9, '8': {}, '10': 'tripId'},
  ],
  '9': [
    {'1': 1, '2': 2},
    {'1': 2, '2': 3},
  ],
  '10': ['page_size', 'page_token'],
};

/// Descriptor for `ListBusTimetableStopsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listBusTimetableStopsRequestDescriptor =
    $convert.base64Decode(
        'ChxMaXN0QnVzVGltZXRhYmxlU3RvcHNSZXF1ZXN0EhwKB3RyaXBfaWQYAyABKAlCA+BBAlIGdH'
        'JpcElkSgQIARACSgQIAhADUglwYWdlX3NpemVSCnBhZ2VfdG9rZW4=');

@$core.Deprecated('Use listBusTimetableStopsResponseDescriptor instead')
const ListBusTimetableStopsResponse$json = {
  '1': 'ListBusTimetableStopsResponse',
  '2': [
    {
      '1': 'bus_timetable_stops',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.app.v1.BusTimetableStop',
      '10': 'busTimetableStops'
    },
  ],
  '9': [
    {'1': 2, '2': 3},
  ],
  '10': ['next_page_token'],
};

/// Descriptor for `ListBusTimetableStopsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listBusTimetableStopsResponseDescriptor =
    $convert.base64Decode(
        'Ch1MaXN0QnVzVGltZXRhYmxlU3RvcHNSZXNwb25zZRJIChNidXNfdGltZXRhYmxlX3N0b3BzGA'
        'EgAygLMhguYXBwLnYxLkJ1c1RpbWV0YWJsZVN0b3BSEWJ1c1RpbWV0YWJsZVN0b3BzSgQIAhAD'
        'Ug9uZXh0X3BhZ2VfdG9rZW4=');

const $core.Map<$core.String, $core.dynamic> BusTimetableStopServiceBase$json =
    {
  '1': 'BusTimetableStopService',
  '2': [
    {
      '1': 'ListBusTimetableStops',
      '2': '.app.v1.ListBusTimetableStopsRequest',
      '3': '.app.v1.ListBusTimetableStopsResponse'
    },
  ],
};

@$core.Deprecated('Use busTimetableStopServiceDescriptor instead')
const $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>>
    BusTimetableStopServiceBase$messageJson = {
  '.app.v1.ListBusTimetableStopsRequest': ListBusTimetableStopsRequest$json,
  '.app.v1.ListBusTimetableStopsResponse': ListBusTimetableStopsResponse$json,
  '.app.v1.BusTimetableStop': BusTimetableStop$json,
  '.app.v1.BusStop': $0.BusStop$json,
  '.google.protobuf.Timestamp': $1.Timestamp$json,
};

/// Descriptor for `BusTimetableStopService`. Decode as a `google.protobuf.ServiceDescriptorProto`.
final $typed_data.Uint8List busTimetableStopServiceDescriptor = $convert.base64Decode(
    'ChdCdXNUaW1ldGFibGVTdG9wU2VydmljZRJkChVMaXN0QnVzVGltZXRhYmxlU3RvcHMSJC5hcH'
    'AudjEuTGlzdEJ1c1RpbWV0YWJsZVN0b3BzUmVxdWVzdBolLmFwcC52MS5MaXN0QnVzVGltZXRh'
    'YmxlU3RvcHNSZXNwb25zZQ==');
