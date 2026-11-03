// This is a generated file - do not edit.
//
// Generated from app/v1/room_change.proto.

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

import '../../google/type/date.pbjson.dart' as $1;
import 'faculty.pbjson.dart' as $4;
import 'room.pbjson.dart' as $2;
import 'subject.pbjson.dart' as $0;

@$core.Deprecated('Use roomChangeDescriptor instead')
const RoomChange$json = {
  '1': 'RoomChange',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '8': {}, '10': 'id'},
    {
      '1': 'subject',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.app.v1.Subject',
      '8': {},
      '10': 'subject'
    },
    {
      '1': 'date',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.google.type.Date',
      '8': {},
      '10': 'date'
    },
    {
      '1': 'period',
      '3': 4,
      '4': 1,
      '5': 14,
      '6': '.app.v1.Period',
      '8': {},
      '10': 'period'
    },
    {
      '1': 'original_room',
      '3': 5,
      '4': 1,
      '5': 11,
      '6': '.app.v1.Room',
      '8': {},
      '10': 'originalRoom'
    },
    {
      '1': 'new_room',
      '3': 6,
      '4': 1,
      '5': 11,
      '6': '.app.v1.Room',
      '8': {},
      '10': 'newRoom'
    },
  ],
};

/// Descriptor for `RoomChange`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List roomChangeDescriptor = $convert.base64Decode(
    'CgpSb29tQ2hhbmdlEhMKAmlkGAEgASgJQgPgQQNSAmlkEi4KB3N1YmplY3QYAiABKAsyDy5hcH'
    'AudjEuU3ViamVjdEID4EEDUgdzdWJqZWN0EioKBGRhdGUYAyABKAsyES5nb29nbGUudHlwZS5E'
    'YXRlQgPgQQNSBGRhdGUSKwoGcGVyaW9kGAQgASgOMg4uYXBwLnYxLlBlcmlvZEID4EEDUgZwZX'
    'Jpb2QSNgoNb3JpZ2luYWxfcm9vbRgFIAEoCzIMLmFwcC52MS5Sb29tQgPgQQNSDG9yaWdpbmFs'
    'Um9vbRIsCghuZXdfcm9vbRgGIAEoCzIMLmFwcC52MS5Sb29tQgPgQQNSB25ld1Jvb20=');

@$core.Deprecated('Use listRoomChangesRequestDescriptor instead')
const ListRoomChangesRequest$json = {
  '1': 'ListRoomChangesRequest',
  '2': [
    {'1': 'subject_ids', '3': 3, '4': 3, '5': 9, '8': {}, '10': 'subjectIds'},
    {
      '1': 'from_date',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.google.type.Date',
      '8': {},
      '9': 0,
      '10': 'fromDate',
      '17': true
    },
    {
      '1': 'until_date',
      '3': 5,
      '4': 1,
      '5': 11,
      '6': '.google.type.Date',
      '8': {},
      '9': 1,
      '10': 'untilDate',
      '17': true
    },
  ],
  '8': [
    {'1': '_from_date'},
    {'1': '_until_date'},
  ],
  '9': [
    {'1': 1, '2': 2},
    {'1': 2, '2': 3},
  ],
  '10': ['page_size', 'page_token'],
};

/// Descriptor for `ListRoomChangesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listRoomChangesRequestDescriptor = $convert.base64Decode(
    'ChZMaXN0Um9vbUNoYW5nZXNSZXF1ZXN0EiQKC3N1YmplY3RfaWRzGAMgAygJQgPgQQFSCnN1Ym'
    'plY3RJZHMSOAoJZnJvbV9kYXRlGAQgASgLMhEuZ29vZ2xlLnR5cGUuRGF0ZUID4EEBSABSCGZy'
    'b21EYXRliAEBEjoKCnVudGlsX2RhdGUYBSABKAsyES5nb29nbGUudHlwZS5EYXRlQgPgQQFIAV'
    'IJdW50aWxEYXRliAEBQgwKCl9mcm9tX2RhdGVCDQoLX3VudGlsX2RhdGVKBAgBEAJKBAgCEANS'
    'CXBhZ2Vfc2l6ZVIKcGFnZV90b2tlbg==');

@$core.Deprecated('Use listRoomChangesResponseDescriptor instead')
const ListRoomChangesResponse$json = {
  '1': 'ListRoomChangesResponse',
  '2': [
    {
      '1': 'room_changes',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.app.v1.RoomChange',
      '10': 'roomChanges'
    },
  ],
  '9': [
    {'1': 2, '2': 3},
  ],
  '10': ['next_page_token'],
};

/// Descriptor for `ListRoomChangesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listRoomChangesResponseDescriptor =
    $convert.base64Decode(
        'ChdMaXN0Um9vbUNoYW5nZXNSZXNwb25zZRI1Cgxyb29tX2NoYW5nZXMYASADKAsyEi5hcHAudj'
        'EuUm9vbUNoYW5nZVILcm9vbUNoYW5nZXNKBAgCEANSD25leHRfcGFnZV90b2tlbg==');

const $core.Map<$core.String, $core.dynamic> RoomChangeServiceBase$json = {
  '1': 'RoomChangeService',
  '2': [
    {
      '1': 'ListRoomChanges',
      '2': '.app.v1.ListRoomChangesRequest',
      '3': '.app.v1.ListRoomChangesResponse'
    },
  ],
};

@$core.Deprecated('Use roomChangeServiceDescriptor instead')
const $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>>
    RoomChangeServiceBase$messageJson = {
  '.app.v1.ListRoomChangesRequest': ListRoomChangesRequest$json,
  '.google.type.Date': $1.Date$json,
  '.app.v1.ListRoomChangesResponse': ListRoomChangesResponse$json,
  '.app.v1.RoomChange': RoomChange$json,
  '.app.v1.Subject': $0.Subject$json,
  '.app.v1.SubjectFaculty': $0.SubjectFaculty$json,
  '.app.v1.Faculty': $4.Faculty$json,
  '.app.v1.SubjectEligibleAttribute': $0.SubjectEligibleAttribute$json,
  '.app.v1.SubjectRequirement': $0.SubjectRequirement$json,
  '.app.v1.SubjectSyllabus': $0.SubjectSyllabus$json,
  '.app.v1.Room': $2.Room$json,
};

/// Descriptor for `RoomChangeService`. Decode as a `google.protobuf.ServiceDescriptorProto`.
final $typed_data.Uint8List roomChangeServiceDescriptor = $convert.base64Decode(
    'ChFSb29tQ2hhbmdlU2VydmljZRJSCg9MaXN0Um9vbUNoYW5nZXMSHi5hcHAudjEuTGlzdFJvb2'
    '1DaGFuZ2VzUmVxdWVzdBofLmFwcC52MS5MaXN0Um9vbUNoYW5nZXNSZXNwb25zZQ==');
