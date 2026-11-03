// This is a generated file - do not edit.
//
// Generated from app/v1/timetable_item.proto.

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

import 'faculty.pbjson.dart' as $4;
import 'room.pbjson.dart' as $1;
import 'subject.pbjson.dart' as $0;

@$core.Deprecated('Use timetableItemSlotDescriptor instead')
const TimetableItemSlot$json = {
  '1': 'TimetableItemSlot',
  '2': [
    {
      '1': 'day_of_week',
      '3': 1,
      '4': 1,
      '5': 14,
      '6': '.google.type.DayOfWeek',
      '8': {},
      '10': 'dayOfWeek'
    },
    {
      '1': 'period',
      '3': 2,
      '4': 1,
      '5': 14,
      '6': '.app.v1.Period',
      '8': {},
      '10': 'period'
    },
  ],
};

/// Descriptor for `TimetableItemSlot`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List timetableItemSlotDescriptor = $convert.base64Decode(
    'ChFUaW1ldGFibGVJdGVtU2xvdBI7CgtkYXlfb2Zfd2VlaxgBIAEoDjIWLmdvb2dsZS50eXBlLk'
    'RheU9mV2Vla0ID4EEDUglkYXlPZldlZWsSKwoGcGVyaW9kGAIgASgOMg4uYXBwLnYxLlBlcmlv'
    'ZEID4EEDUgZwZXJpb2Q=');

@$core.Deprecated('Use timetableItemDescriptor instead')
const TimetableItem$json = {
  '1': 'TimetableItem',
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
      '1': 'slot',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.app.v1.TimetableItemSlot',
      '8': {},
      '9': 0,
      '10': 'slot',
      '17': true
    },
    {
      '1': 'rooms',
      '3': 4,
      '4': 3,
      '5': 11,
      '6': '.app.v1.Room',
      '8': {},
      '10': 'rooms'
    },
  ],
  '8': [
    {'1': '_slot'},
  ],
};

/// Descriptor for `TimetableItem`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List timetableItemDescriptor = $convert.base64Decode(
    'Cg1UaW1ldGFibGVJdGVtEhMKAmlkGAEgASgJQgPgQQNSAmlkEi4KB3N1YmplY3QYAiABKAsyDy'
    '5hcHAudjEuU3ViamVjdEID4EEDUgdzdWJqZWN0EjcKBHNsb3QYAyABKAsyGS5hcHAudjEuVGlt'
    'ZXRhYmxlSXRlbVNsb3RCA+BBA0gAUgRzbG90iAEBEicKBXJvb21zGAQgAygLMgwuYXBwLnYxLl'
    'Jvb21CA+BBA1IFcm9vbXNCBwoFX3Nsb3Q=');

@$core.Deprecated('Use listTimetableItemsRequestDescriptor instead')
const ListTimetableItemsRequest$json = {
  '1': 'ListTimetableItemsRequest',
  '2': [
    {
      '1': 'year',
      '3': 3,
      '4': 1,
      '5': 5,
      '8': {},
      '9': 0,
      '10': 'year',
      '17': true
    },
    {
      '1': 'semesters',
      '3': 4,
      '4': 3,
      '5': 14,
      '6': '.app.v1.SubjectSemester',
      '8': {},
      '10': 'semesters'
    },
  ],
  '8': [
    {'1': '_year'},
  ],
  '9': [
    {'1': 1, '2': 2},
    {'1': 2, '2': 3},
  ],
  '10': ['page_size', 'page_token'],
};

/// Descriptor for `ListTimetableItemsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listTimetableItemsRequestDescriptor = $convert.base64Decode(
    'ChlMaXN0VGltZXRhYmxlSXRlbXNSZXF1ZXN0EhwKBHllYXIYAyABKAVCA+BBAUgAUgR5ZWFyiA'
    'EBEjoKCXNlbWVzdGVycxgEIAMoDjIXLmFwcC52MS5TdWJqZWN0U2VtZXN0ZXJCA+BBAlIJc2Vt'
    'ZXN0ZXJzQgcKBV95ZWFySgQIARACSgQIAhADUglwYWdlX3NpemVSCnBhZ2VfdG9rZW4=');

@$core.Deprecated('Use listTimetableItemsResponseDescriptor instead')
const ListTimetableItemsResponse$json = {
  '1': 'ListTimetableItemsResponse',
  '2': [
    {
      '1': 'timetable_items',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.app.v1.TimetableItem',
      '10': 'timetableItems'
    },
  ],
  '9': [
    {'1': 2, '2': 3},
  ],
  '10': ['next_page_token'],
};

/// Descriptor for `ListTimetableItemsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listTimetableItemsResponseDescriptor =
    $convert.base64Decode(
        'ChpMaXN0VGltZXRhYmxlSXRlbXNSZXNwb25zZRI+Cg90aW1ldGFibGVfaXRlbXMYASADKAsyFS'
        '5hcHAudjEuVGltZXRhYmxlSXRlbVIOdGltZXRhYmxlSXRlbXNKBAgCEANSD25leHRfcGFnZV90'
        'b2tlbg==');

const $core.Map<$core.String, $core.dynamic> TimetableItemServiceBase$json = {
  '1': 'TimetableItemService',
  '2': [
    {
      '1': 'ListTimetableItems',
      '2': '.app.v1.ListTimetableItemsRequest',
      '3': '.app.v1.ListTimetableItemsResponse'
    },
  ],
};

@$core.Deprecated('Use timetableItemServiceDescriptor instead')
const $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>>
    TimetableItemServiceBase$messageJson = {
  '.app.v1.ListTimetableItemsRequest': ListTimetableItemsRequest$json,
  '.app.v1.ListTimetableItemsResponse': ListTimetableItemsResponse$json,
  '.app.v1.TimetableItem': TimetableItem$json,
  '.app.v1.Subject': $0.Subject$json,
  '.app.v1.SubjectFaculty': $0.SubjectFaculty$json,
  '.app.v1.Faculty': $4.Faculty$json,
  '.app.v1.SubjectEligibleAttribute': $0.SubjectEligibleAttribute$json,
  '.app.v1.SubjectRequirement': $0.SubjectRequirement$json,
  '.app.v1.SubjectSyllabus': $0.SubjectSyllabus$json,
  '.app.v1.TimetableItemSlot': TimetableItemSlot$json,
  '.app.v1.Room': $1.Room$json,
};

/// Descriptor for `TimetableItemService`. Decode as a `google.protobuf.ServiceDescriptorProto`.
final $typed_data.Uint8List timetableItemServiceDescriptor = $convert.base64Decode(
    'ChRUaW1ldGFibGVJdGVtU2VydmljZRJbChJMaXN0VGltZXRhYmxlSXRlbXMSIS5hcHAudjEuTG'
    'lzdFRpbWV0YWJsZUl0ZW1zUmVxdWVzdBoiLmFwcC52MS5MaXN0VGltZXRhYmxlSXRlbXNSZXNw'
    'b25zZQ==');
