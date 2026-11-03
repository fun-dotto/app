// This is a generated file - do not edit.
//
// Generated from app/v1/course_registration.proto.

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

import 'faculty.pbjson.dart' as $1;
import 'subject.pbjson.dart' as $0;

@$core.Deprecated('Use courseRegistrationDescriptor instead')
const CourseRegistration$json = {
  '1': 'CourseRegistration',
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
  ],
};

/// Descriptor for `CourseRegistration`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List courseRegistrationDescriptor = $convert.base64Decode(
    'ChJDb3Vyc2VSZWdpc3RyYXRpb24SEwoCaWQYASABKAlCA+BBA1ICaWQSLgoHc3ViamVjdBgCIA'
    'EoCzIPLmFwcC52MS5TdWJqZWN0QgPgQQNSB3N1YmplY3Q=');

@$core.Deprecated('Use listCourseRegistrationsRequestDescriptor instead')
const ListCourseRegistrationsRequest$json = {
  '1': 'ListCourseRegistrationsRequest',
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

/// Descriptor for `ListCourseRegistrationsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listCourseRegistrationsRequestDescriptor =
    $convert.base64Decode(
        'Ch5MaXN0Q291cnNlUmVnaXN0cmF0aW9uc1JlcXVlc3QSHAoEeWVhchgDIAEoBUID4EEBSABSBH'
        'llYXKIAQESOgoJc2VtZXN0ZXJzGAQgAygOMhcuYXBwLnYxLlN1YmplY3RTZW1lc3RlckID4EEC'
        'UglzZW1lc3RlcnNCBwoFX3llYXJKBAgBEAJKBAgCEANSCXBhZ2Vfc2l6ZVIKcGFnZV90b2tlbg'
        '==');

@$core.Deprecated('Use listCourseRegistrationsResponseDescriptor instead')
const ListCourseRegistrationsResponse$json = {
  '1': 'ListCourseRegistrationsResponse',
  '2': [
    {
      '1': 'course_registrations',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.app.v1.CourseRegistration',
      '10': 'courseRegistrations'
    },
  ],
  '9': [
    {'1': 2, '2': 3},
  ],
  '10': ['next_page_token'],
};

/// Descriptor for `ListCourseRegistrationsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listCourseRegistrationsResponseDescriptor =
    $convert.base64Decode(
        'Ch9MaXN0Q291cnNlUmVnaXN0cmF0aW9uc1Jlc3BvbnNlEk0KFGNvdXJzZV9yZWdpc3RyYXRpb2'
        '5zGAEgAygLMhouYXBwLnYxLkNvdXJzZVJlZ2lzdHJhdGlvblITY291cnNlUmVnaXN0cmF0aW9u'
        'c0oECAIQA1IPbmV4dF9wYWdlX3Rva2Vu');

@$core.Deprecated('Use createCourseRegistrationRequestDescriptor instead')
const CreateCourseRegistrationRequest$json = {
  '1': 'CreateCourseRegistrationRequest',
  '2': [
    {'1': 'subject_id', '3': 1, '4': 1, '5': 9, '8': {}, '10': 'subjectId'},
  ],
};

/// Descriptor for `CreateCourseRegistrationRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createCourseRegistrationRequestDescriptor =
    $convert.base64Decode(
        'Ch9DcmVhdGVDb3Vyc2VSZWdpc3RyYXRpb25SZXF1ZXN0EiIKCnN1YmplY3RfaWQYASABKAlCA+'
        'BBAlIJc3ViamVjdElk');

@$core.Deprecated('Use createCourseRegistrationResponseDescriptor instead')
const CreateCourseRegistrationResponse$json = {
  '1': 'CreateCourseRegistrationResponse',
  '2': [
    {
      '1': 'course_registration',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.app.v1.CourseRegistration',
      '10': 'courseRegistration'
    },
  ],
};

/// Descriptor for `CreateCourseRegistrationResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createCourseRegistrationResponseDescriptor =
    $convert.base64Decode(
        'CiBDcmVhdGVDb3Vyc2VSZWdpc3RyYXRpb25SZXNwb25zZRJLChNjb3Vyc2VfcmVnaXN0cmF0aW'
        '9uGAEgASgLMhouYXBwLnYxLkNvdXJzZVJlZ2lzdHJhdGlvblISY291cnNlUmVnaXN0cmF0aW9u');

@$core.Deprecated('Use deleteCourseRegistrationRequestDescriptor instead')
const DeleteCourseRegistrationRequest$json = {
  '1': 'DeleteCourseRegistrationRequest',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '8': {}, '10': 'id'},
  ],
};

/// Descriptor for `DeleteCourseRegistrationRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteCourseRegistrationRequestDescriptor =
    $convert.base64Decode(
        'Ch9EZWxldGVDb3Vyc2VSZWdpc3RyYXRpb25SZXF1ZXN0EhMKAmlkGAEgASgJQgPgQQJSAmlk');

@$core.Deprecated('Use deleteCourseRegistrationResponseDescriptor instead')
const DeleteCourseRegistrationResponse$json = {
  '1': 'DeleteCourseRegistrationResponse',
};

/// Descriptor for `DeleteCourseRegistrationResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteCourseRegistrationResponseDescriptor =
    $convert.base64Decode('CiBEZWxldGVDb3Vyc2VSZWdpc3RyYXRpb25SZXNwb25zZQ==');

const $core.Map<$core.String, $core.dynamic>
    CourseRegistrationServiceBase$json = {
  '1': 'CourseRegistrationService',
  '2': [
    {
      '1': 'ListCourseRegistrations',
      '2': '.app.v1.ListCourseRegistrationsRequest',
      '3': '.app.v1.ListCourseRegistrationsResponse'
    },
    {
      '1': 'CreateCourseRegistration',
      '2': '.app.v1.CreateCourseRegistrationRequest',
      '3': '.app.v1.CreateCourseRegistrationResponse'
    },
    {
      '1': 'DeleteCourseRegistration',
      '2': '.app.v1.DeleteCourseRegistrationRequest',
      '3': '.app.v1.DeleteCourseRegistrationResponse'
    },
  ],
};

@$core.Deprecated('Use courseRegistrationServiceDescriptor instead')
const $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>>
    CourseRegistrationServiceBase$messageJson = {
  '.app.v1.ListCourseRegistrationsRequest': ListCourseRegistrationsRequest$json,
  '.app.v1.ListCourseRegistrationsResponse':
      ListCourseRegistrationsResponse$json,
  '.app.v1.CourseRegistration': CourseRegistration$json,
  '.app.v1.Subject': $0.Subject$json,
  '.app.v1.SubjectFaculty': $0.SubjectFaculty$json,
  '.app.v1.Faculty': $1.Faculty$json,
  '.app.v1.SubjectEligibleAttribute': $0.SubjectEligibleAttribute$json,
  '.app.v1.SubjectRequirement': $0.SubjectRequirement$json,
  '.app.v1.SubjectSyllabus': $0.SubjectSyllabus$json,
  '.app.v1.CreateCourseRegistrationRequest':
      CreateCourseRegistrationRequest$json,
  '.app.v1.CreateCourseRegistrationResponse':
      CreateCourseRegistrationResponse$json,
  '.app.v1.DeleteCourseRegistrationRequest':
      DeleteCourseRegistrationRequest$json,
  '.app.v1.DeleteCourseRegistrationResponse':
      DeleteCourseRegistrationResponse$json,
};

/// Descriptor for `CourseRegistrationService`. Decode as a `google.protobuf.ServiceDescriptorProto`.
final $typed_data.Uint8List courseRegistrationServiceDescriptor = $convert.base64Decode(
    'ChlDb3Vyc2VSZWdpc3RyYXRpb25TZXJ2aWNlEmoKF0xpc3RDb3Vyc2VSZWdpc3RyYXRpb25zEi'
    'YuYXBwLnYxLkxpc3RDb3Vyc2VSZWdpc3RyYXRpb25zUmVxdWVzdBonLmFwcC52MS5MaXN0Q291'
    'cnNlUmVnaXN0cmF0aW9uc1Jlc3BvbnNlEm0KGENyZWF0ZUNvdXJzZVJlZ2lzdHJhdGlvbhInLm'
    'FwcC52MS5DcmVhdGVDb3Vyc2VSZWdpc3RyYXRpb25SZXF1ZXN0GiguYXBwLnYxLkNyZWF0ZUNv'
    'dXJzZVJlZ2lzdHJhdGlvblJlc3BvbnNlEm0KGERlbGV0ZUNvdXJzZVJlZ2lzdHJhdGlvbhInLm'
    'FwcC52MS5EZWxldGVDb3Vyc2VSZWdpc3RyYXRpb25SZXF1ZXN0GiguYXBwLnYxLkRlbGV0ZUNv'
    'dXJzZVJlZ2lzdHJhdGlvblJlc3BvbnNl');
