// This is a generated file - do not edit.
//
// Generated from app/v1/personal_calendar_item.proto.

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

import '../../google/type/date.pbjson.dart' as $0;
import 'faculty.pbjson.dart' as $4;
import 'room.pbjson.dart' as $2;
import 'subject.pbjson.dart' as $1;

@$core.Deprecated('Use personalCalendarItemDescriptor instead')
const PersonalCalendarItem$json = {
  '1': 'PersonalCalendarItem',
  '2': [
    {
      '1': 'date',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.google.type.Date',
      '8': {},
      '10': 'date'
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
    {
      '1': 'subject',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.app.v1.Subject',
      '8': {},
      '10': 'subject'
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
    {
      '1': 'state',
      '3': 5,
      '4': 1,
      '5': 14,
      '6': '.app.v1.PersonalCalendarItem.State',
      '8': {},
      '10': 'state'
    },
  ],
  '4': [PersonalCalendarItem_State$json],
};

@$core.Deprecated('Use personalCalendarItemDescriptor instead')
const PersonalCalendarItem_State$json = {
  '1': 'State',
  '2': [
    {'1': 'STATE_UNSPECIFIED', '2': 0},
    {'1': 'STATE_NORMAL', '2': 1},
    {'1': 'STATE_CANCELLED', '2': 2},
    {'1': 'STATE_MAKEUP', '2': 3},
    {'1': 'STATE_ROOM_CHANGED', '2': 4},
  ],
};

/// Descriptor for `PersonalCalendarItem`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List personalCalendarItemDescriptor = $convert.base64Decode(
    'ChRQZXJzb25hbENhbGVuZGFySXRlbRIqCgRkYXRlGAEgASgLMhEuZ29vZ2xlLnR5cGUuRGF0ZU'
    'ID4EEDUgRkYXRlEisKBnBlcmlvZBgCIAEoDjIOLmFwcC52MS5QZXJpb2RCA+BBA1IGcGVyaW9k'
    'Ei4KB3N1YmplY3QYAyABKAsyDy5hcHAudjEuU3ViamVjdEID4EEDUgdzdWJqZWN0EicKBXJvb2'
    '1zGAQgAygLMgwuYXBwLnYxLlJvb21CA+BBA1IFcm9vbXMSPQoFc3RhdGUYBSABKA4yIi5hcHAu'
    'djEuUGVyc29uYWxDYWxlbmRhckl0ZW0uU3RhdGVCA+BBA1IFc3RhdGUibwoFU3RhdGUSFQoRU1'
    'RBVEVfVU5TUEVDSUZJRUQQABIQCgxTVEFURV9OT1JNQUwQARITCg9TVEFURV9DQU5DRUxMRUQQ'
    'AhIQCgxTVEFURV9NQUtFVVAQAxIWChJTVEFURV9ST09NX0NIQU5HRUQQBA==');

@$core.Deprecated('Use listPersonalCalendarItemsRequestDescriptor instead')
const ListPersonalCalendarItemsRequest$json = {
  '1': 'ListPersonalCalendarItemsRequest',
  '2': [
    {
      '1': 'dates',
      '3': 3,
      '4': 3,
      '5': 11,
      '6': '.google.type.Date',
      '8': {},
      '10': 'dates'
    },
  ],
  '9': [
    {'1': 1, '2': 2},
    {'1': 2, '2': 3},
  ],
  '10': ['page_size', 'page_token'],
};

/// Descriptor for `ListPersonalCalendarItemsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listPersonalCalendarItemsRequestDescriptor =
    $convert.base64Decode(
        'CiBMaXN0UGVyc29uYWxDYWxlbmRhckl0ZW1zUmVxdWVzdBIsCgVkYXRlcxgDIAMoCzIRLmdvb2'
        'dsZS50eXBlLkRhdGVCA+BBAlIFZGF0ZXNKBAgBEAJKBAgCEANSCXBhZ2Vfc2l6ZVIKcGFnZV90'
        'b2tlbg==');

@$core.Deprecated('Use listPersonalCalendarItemsResponseDescriptor instead')
const ListPersonalCalendarItemsResponse$json = {
  '1': 'ListPersonalCalendarItemsResponse',
  '2': [
    {
      '1': 'personal_calendar_items',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.app.v1.PersonalCalendarItem',
      '10': 'personalCalendarItems'
    },
  ],
  '9': [
    {'1': 2, '2': 3},
  ],
  '10': ['next_page_token'],
};

/// Descriptor for `ListPersonalCalendarItemsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listPersonalCalendarItemsResponseDescriptor =
    $convert.base64Decode(
        'CiFMaXN0UGVyc29uYWxDYWxlbmRhckl0ZW1zUmVzcG9uc2USVAoXcGVyc29uYWxfY2FsZW5kYX'
        'JfaXRlbXMYASADKAsyHC5hcHAudjEuUGVyc29uYWxDYWxlbmRhckl0ZW1SFXBlcnNvbmFsQ2Fs'
        'ZW5kYXJJdGVtc0oECAIQA1IPbmV4dF9wYWdlX3Rva2Vu');

const $core.Map<$core.String, $core.dynamic>
    PersonalCalendarItemServiceBase$json = {
  '1': 'PersonalCalendarItemService',
  '2': [
    {
      '1': 'ListPersonalCalendarItems',
      '2': '.app.v1.ListPersonalCalendarItemsRequest',
      '3': '.app.v1.ListPersonalCalendarItemsResponse'
    },
  ],
};

@$core.Deprecated('Use personalCalendarItemServiceDescriptor instead')
const $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>>
    PersonalCalendarItemServiceBase$messageJson = {
  '.app.v1.ListPersonalCalendarItemsRequest':
      ListPersonalCalendarItemsRequest$json,
  '.google.type.Date': $0.Date$json,
  '.app.v1.ListPersonalCalendarItemsResponse':
      ListPersonalCalendarItemsResponse$json,
  '.app.v1.PersonalCalendarItem': PersonalCalendarItem$json,
  '.app.v1.Subject': $1.Subject$json,
  '.app.v1.SubjectFaculty': $1.SubjectFaculty$json,
  '.app.v1.Faculty': $4.Faculty$json,
  '.app.v1.SubjectEligibleAttribute': $1.SubjectEligibleAttribute$json,
  '.app.v1.SubjectRequirement': $1.SubjectRequirement$json,
  '.app.v1.SubjectSyllabus': $1.SubjectSyllabus$json,
  '.app.v1.Room': $2.Room$json,
};

/// Descriptor for `PersonalCalendarItemService`. Decode as a `google.protobuf.ServiceDescriptorProto`.
final $typed_data.Uint8List personalCalendarItemServiceDescriptor =
    $convert.base64Decode(
        'ChtQZXJzb25hbENhbGVuZGFySXRlbVNlcnZpY2UScAoZTGlzdFBlcnNvbmFsQ2FsZW5kYXJJdG'
        'VtcxIoLmFwcC52MS5MaXN0UGVyc29uYWxDYWxlbmRhckl0ZW1zUmVxdWVzdBopLmFwcC52MS5M'
        'aXN0UGVyc29uYWxDYWxlbmRhckl0ZW1zUmVzcG9uc2U=');
