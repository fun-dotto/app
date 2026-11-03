// This is a generated file - do not edit.
//
// Generated from app/v1/makeup_class.proto.

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

@$core.Deprecated('Use makeupClassDescriptor instead')
const MakeupClass$json = {
  '1': 'MakeupClass',
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

/// Descriptor for `MakeupClass`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List makeupClassDescriptor = $convert.base64Decode(
    'CgtNYWtldXBDbGFzcxITCgJpZBgBIAEoCUID4EEDUgJpZBIuCgdzdWJqZWN0GAIgASgLMg8uYX'
    'BwLnYxLlN1YmplY3RCA+BBA1IHc3ViamVjdBIqCgRkYXRlGAMgASgLMhEuZ29vZ2xlLnR5cGUu'
    'RGF0ZUID4EEDUgRkYXRlEisKBnBlcmlvZBgEIAEoDjIOLmFwcC52MS5QZXJpb2RCA+BBA1IGcG'
    'VyaW9kEh0KB2NvbW1lbnQYBSABKAlCA+BBA1IHY29tbWVudA==');

@$core.Deprecated('Use listMakeupClassesRequestDescriptor instead')
const ListMakeupClassesRequest$json = {
  '1': 'ListMakeupClassesRequest',
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

/// Descriptor for `ListMakeupClassesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listMakeupClassesRequestDescriptor = $convert.base64Decode(
    'ChhMaXN0TWFrZXVwQ2xhc3Nlc1JlcXVlc3QSJAoLc3ViamVjdF9pZHMYAyADKAlCA+BBAVIKc3'
    'ViamVjdElkcxI4Cglmcm9tX2RhdGUYBCABKAsyES5nb29nbGUudHlwZS5EYXRlQgPgQQFIAFII'
    'ZnJvbURhdGWIAQESOgoKdW50aWxfZGF0ZRgFIAEoCzIRLmdvb2dsZS50eXBlLkRhdGVCA+BBAU'
    'gBUgl1bnRpbERhdGWIAQFCDAoKX2Zyb21fZGF0ZUINCgtfdW50aWxfZGF0ZUoECAEQAkoECAIQ'
    'A1IJcGFnZV9zaXplUgpwYWdlX3Rva2Vu');

@$core.Deprecated('Use listMakeupClassesResponseDescriptor instead')
const ListMakeupClassesResponse$json = {
  '1': 'ListMakeupClassesResponse',
  '2': [
    {
      '1': 'makeup_classes',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.app.v1.MakeupClass',
      '10': 'makeupClasses'
    },
  ],
  '9': [
    {'1': 2, '2': 3},
  ],
  '10': ['next_page_token'],
};

/// Descriptor for `ListMakeupClassesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listMakeupClassesResponseDescriptor = $convert.base64Decode(
    'ChlMaXN0TWFrZXVwQ2xhc3Nlc1Jlc3BvbnNlEjoKDm1ha2V1cF9jbGFzc2VzGAEgAygLMhMuYX'
    'BwLnYxLk1ha2V1cENsYXNzUg1tYWtldXBDbGFzc2VzSgQIAhADUg9uZXh0X3BhZ2VfdG9rZW4=');

const $core.Map<$core.String, $core.dynamic> MakeupClassServiceBase$json = {
  '1': 'MakeupClassService',
  '2': [
    {
      '1': 'ListMakeupClasses',
      '2': '.app.v1.ListMakeupClassesRequest',
      '3': '.app.v1.ListMakeupClassesResponse'
    },
  ],
};

@$core.Deprecated('Use makeupClassServiceDescriptor instead')
const $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>>
    MakeupClassServiceBase$messageJson = {
  '.app.v1.ListMakeupClassesRequest': ListMakeupClassesRequest$json,
  '.google.type.Date': $1.Date$json,
  '.app.v1.ListMakeupClassesResponse': ListMakeupClassesResponse$json,
  '.app.v1.MakeupClass': MakeupClass$json,
  '.app.v1.Subject': $0.Subject$json,
  '.app.v1.SubjectFaculty': $0.SubjectFaculty$json,
  '.app.v1.Faculty': $3.Faculty$json,
  '.app.v1.SubjectEligibleAttribute': $0.SubjectEligibleAttribute$json,
  '.app.v1.SubjectRequirement': $0.SubjectRequirement$json,
  '.app.v1.SubjectSyllabus': $0.SubjectSyllabus$json,
};

/// Descriptor for `MakeupClassService`. Decode as a `google.protobuf.ServiceDescriptorProto`.
final $typed_data.Uint8List makeupClassServiceDescriptor = $convert.base64Decode(
    'ChJNYWtldXBDbGFzc1NlcnZpY2USWAoRTGlzdE1ha2V1cENsYXNzZXMSIC5hcHAudjEuTGlzdE'
    '1ha2V1cENsYXNzZXNSZXF1ZXN0GiEuYXBwLnYxLkxpc3RNYWtldXBDbGFzc2VzUmVzcG9uc2U=');
