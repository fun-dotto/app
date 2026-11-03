// This is a generated file - do not edit.
//
// Generated from app/v1/reservation.proto.

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

import 'faculty.pbjson.dart' as $2;
import 'room.pbjson.dart' as $0;

@$core.Deprecated('Use reservationDescriptor instead')
const Reservation$json = {
  '1': 'Reservation',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '8': {}, '10': 'id'},
    {
      '1': 'room',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.app.v1.Room',
      '8': {},
      '10': 'room'
    },
    {
      '1': 'start_at',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '8': {},
      '10': 'startAt'
    },
    {
      '1': 'end_at',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '8': {},
      '10': 'endAt'
    },
    {'1': 'title', '3': 5, '4': 1, '5': 9, '8': {}, '10': 'title'},
  ],
};

/// Descriptor for `Reservation`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List reservationDescriptor = $convert.base64Decode(
    'CgtSZXNlcnZhdGlvbhITCgJpZBgBIAEoCUID4EEDUgJpZBIlCgRyb29tGAIgASgLMgwuYXBwLn'
    'YxLlJvb21CA+BBA1IEcm9vbRI6CghzdGFydF9hdBgDIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5U'
    'aW1lc3RhbXBCA+BBA1IHc3RhcnRBdBI2CgZlbmRfYXQYBCABKAsyGi5nb29nbGUucHJvdG9idW'
    'YuVGltZXN0YW1wQgPgQQNSBWVuZEF0EhkKBXRpdGxlGAUgASgJQgPgQQNSBXRpdGxl');

@$core.Deprecated('Use listReservationsRequestDescriptor instead')
const ListReservationsRequest$json = {
  '1': 'ListReservationsRequest',
  '2': [
    {'1': 'room_ids', '3': 3, '4': 3, '5': 9, '8': {}, '10': 'roomIds'},
    {
      '1': 'from_time',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '8': {},
      '9': 0,
      '10': 'fromTime',
      '17': true
    },
    {
      '1': 'until_time',
      '3': 5,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '8': {},
      '9': 1,
      '10': 'untilTime',
      '17': true
    },
  ],
  '8': [
    {'1': '_from_time'},
    {'1': '_until_time'},
  ],
  '9': [
    {'1': 1, '2': 2},
    {'1': 2, '2': 3},
  ],
  '10': ['page_size', 'page_token'],
};

/// Descriptor for `ListReservationsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listReservationsRequestDescriptor = $convert.base64Decode(
    'ChdMaXN0UmVzZXJ2YXRpb25zUmVxdWVzdBIeCghyb29tX2lkcxgDIAMoCUID4EEBUgdyb29tSW'
    'RzEkEKCWZyb21fdGltZRgEIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBCA+BBAUgA'
    'Ughmcm9tVGltZYgBARJDCgp1bnRpbF90aW1lGAUgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbW'
    'VzdGFtcEID4EEBSAFSCXVudGlsVGltZYgBAUIMCgpfZnJvbV90aW1lQg0KC191bnRpbF90aW1l'
    'SgQIARACSgQIAhADUglwYWdlX3NpemVSCnBhZ2VfdG9rZW4=');

@$core.Deprecated('Use listReservationsResponseDescriptor instead')
const ListReservationsResponse$json = {
  '1': 'ListReservationsResponse',
  '2': [
    {
      '1': 'reservations',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.app.v1.Reservation',
      '10': 'reservations'
    },
  ],
  '9': [
    {'1': 2, '2': 3},
  ],
  '10': ['next_page_token'],
};

/// Descriptor for `ListReservationsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listReservationsResponseDescriptor =
    $convert.base64Decode(
        'ChhMaXN0UmVzZXJ2YXRpb25zUmVzcG9uc2USNwoMcmVzZXJ2YXRpb25zGAEgAygLMhMuYXBwLn'
        'YxLlJlc2VydmF0aW9uUgxyZXNlcnZhdGlvbnNKBAgCEANSD25leHRfcGFnZV90b2tlbg==');

const $core.Map<$core.String, $core.dynamic> ReservationServiceBase$json = {
  '1': 'ReservationService',
  '2': [
    {
      '1': 'ListReservations',
      '2': '.app.v1.ListReservationsRequest',
      '3': '.app.v1.ListReservationsResponse'
    },
  ],
};

@$core.Deprecated('Use reservationServiceDescriptor instead')
const $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>>
    ReservationServiceBase$messageJson = {
  '.app.v1.ListReservationsRequest': ListReservationsRequest$json,
  '.google.protobuf.Timestamp': $1.Timestamp$json,
  '.app.v1.ListReservationsResponse': ListReservationsResponse$json,
  '.app.v1.Reservation': Reservation$json,
  '.app.v1.Room': $0.Room$json,
  '.app.v1.Faculty': $2.Faculty$json,
};

/// Descriptor for `ReservationService`. Decode as a `google.protobuf.ServiceDescriptorProto`.
final $typed_data.Uint8List reservationServiceDescriptor = $convert.base64Decode(
    'ChJSZXNlcnZhdGlvblNlcnZpY2USVQoQTGlzdFJlc2VydmF0aW9ucxIfLmFwcC52MS5MaXN0Um'
    'VzZXJ2YXRpb25zUmVxdWVzdBogLmFwcC52MS5MaXN0UmVzZXJ2YXRpb25zUmVzcG9uc2U=');
