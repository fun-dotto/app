// This is a generated file - do not edit.
//
// Generated from app/v1/cancelled_class.proto.

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
import 'faculty.pbjson.dart' as $3;
import 'subject.pbjson.dart' as $0;

@$core.Deprecated('Use cancelledClassDescriptor instead')
const CancelledClass$json = {
  '1': 'CancelledClass',
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
    {'1': 'comment', '3': 5, '4': 1, '5': 9, '8': {}, '10': 'comment'},
  ],
};

/// Descriptor for `CancelledClass`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cancelledClassDescriptor = $convert.base64Decode(
    'Cg5DYW5jZWxsZWRDbGFzcxITCgJpZBgBIAEoCUID4EEDUgJpZBIuCgdzdWJqZWN0GAIgASgLMg'
    '8uYXBwLnYxLlN1YmplY3RCA+BBA1IHc3ViamVjdBIqCgRkYXRlGAMgASgLMhEuZ29vZ2xlLnR5'
    'cGUuRGF0ZUID4EEDUgRkYXRlEisKBnBlcmlvZBgEIAEoDjIOLmFwcC52MS5QZXJpb2RCA+BBA1'
    'IGcGVyaW9kEh0KB2NvbW1lbnQYBSABKAlCA+BBA1IHY29tbWVudA==');

@$core.Deprecated('Use listCancelledClassesRequestDescriptor instead')
const ListCancelledClassesRequest$json = {
  '1': 'ListCancelledClassesRequest',
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

/// Descriptor for `ListCancelledClassesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listCancelledClassesRequestDescriptor = $convert.base64Decode(
    'ChtMaXN0Q2FuY2VsbGVkQ2xhc3Nlc1JlcXVlc3QSJAoLc3ViamVjdF9pZHMYAyADKAlCA+BBAV'
    'IKc3ViamVjdElkcxI4Cglmcm9tX2RhdGUYBCABKAsyES5nb29nbGUudHlwZS5EYXRlQgPgQQFI'
    'AFIIZnJvbURhdGWIAQESOgoKdW50aWxfZGF0ZRgFIAEoCzIRLmdvb2dsZS50eXBlLkRhdGVCA+'
    'BBAUgBUgl1bnRpbERhdGWIAQFCDAoKX2Zyb21fZGF0ZUINCgtfdW50aWxfZGF0ZUoECAEQAkoE'
    'CAIQA1IJcGFnZV9zaXplUgpwYWdlX3Rva2Vu');

@$core.Deprecated('Use listCancelledClassesResponseDescriptor instead')
const ListCancelledClassesResponse$json = {
  '1': 'ListCancelledClassesResponse',
  '2': [
    {
      '1': 'cancelled_classes',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.app.v1.CancelledClass',
      '10': 'cancelledClasses'
    },
  ],
  '9': [
    {'1': 2, '2': 3},
  ],
  '10': ['next_page_token'],
};

/// Descriptor for `ListCancelledClassesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listCancelledClassesResponseDescriptor =
    $convert.base64Decode(
        'ChxMaXN0Q2FuY2VsbGVkQ2xhc3Nlc1Jlc3BvbnNlEkMKEWNhbmNlbGxlZF9jbGFzc2VzGAEgAy'
        'gLMhYuYXBwLnYxLkNhbmNlbGxlZENsYXNzUhBjYW5jZWxsZWRDbGFzc2VzSgQIAhADUg9uZXh0'
        'X3BhZ2VfdG9rZW4=');

const $core.Map<$core.String, $core.dynamic> CancelledClassServiceBase$json = {
  '1': 'CancelledClassService',
  '2': [
    {
      '1': 'ListCancelledClasses',
      '2': '.app.v1.ListCancelledClassesRequest',
      '3': '.app.v1.ListCancelledClassesResponse'
    },
  ],
};

@$core.Deprecated('Use cancelledClassServiceDescriptor instead')
const $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>>
    CancelledClassServiceBase$messageJson = {
  '.app.v1.ListCancelledClassesRequest': ListCancelledClassesRequest$json,
  '.google.type.Date': $1.Date$json,
  '.app.v1.ListCancelledClassesResponse': ListCancelledClassesResponse$json,
  '.app.v1.CancelledClass': CancelledClass$json,
  '.app.v1.Subject': $0.Subject$json,
  '.app.v1.SubjectFaculty': $0.SubjectFaculty$json,
  '.app.v1.Faculty': $3.Faculty$json,
  '.app.v1.SubjectEligibleAttribute': $0.SubjectEligibleAttribute$json,
  '.app.v1.SubjectRequirement': $0.SubjectRequirement$json,
  '.app.v1.SubjectSyllabus': $0.SubjectSyllabus$json,
};

/// Descriptor for `CancelledClassService`. Decode as a `google.protobuf.ServiceDescriptorProto`.
final $typed_data.Uint8List cancelledClassServiceDescriptor = $convert.base64Decode(
    'ChVDYW5jZWxsZWRDbGFzc1NlcnZpY2USYQoUTGlzdENhbmNlbGxlZENsYXNzZXMSIy5hcHAudj'
    'EuTGlzdENhbmNlbGxlZENsYXNzZXNSZXF1ZXN0GiQuYXBwLnYxLkxpc3RDYW5jZWxsZWRDbGFz'
    'c2VzUmVzcG9uc2U=');
