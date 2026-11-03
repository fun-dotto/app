// This is a generated file - do not edit.
//
// Generated from app/v1/user.proto.

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

import 'package:protobuf/well_known_types/google/protobuf/field_mask.pbjson.dart'
    as $0;

@$core.Deprecated('Use userDescriptor instead')
const User$json = {
  '1': 'User',
  '2': [
    {
      '1': 'grade',
      '3': 1,
      '4': 1,
      '5': 14,
      '6': '.app.v1.Grade',
      '8': {},
      '9': 0,
      '10': 'grade',
      '17': true
    },
    {
      '1': 'course',
      '3': 2,
      '4': 1,
      '5': 14,
      '6': '.app.v1.Course',
      '8': {},
      '9': 1,
      '10': 'course',
      '17': true
    },
    {
      '1': 'class',
      '3': 3,
      '4': 1,
      '5': 14,
      '6': '.app.v1.Class',
      '8': {},
      '9': 2,
      '10': 'class',
      '17': true
    },
  ],
  '8': [
    {'1': '_grade'},
    {'1': '_course'},
    {'1': '_class'},
  ],
};

/// Descriptor for `User`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List userDescriptor = $convert.base64Decode(
    'CgRVc2VyEi0KBWdyYWRlGAEgASgOMg0uYXBwLnYxLkdyYWRlQgPgQQFIAFIFZ3JhZGWIAQESMA'
    'oGY291cnNlGAIgASgOMg4uYXBwLnYxLkNvdXJzZUID4EEBSAFSBmNvdXJzZYgBARItCgVjbGFz'
    'cxgDIAEoDjINLmFwcC52MS5DbGFzc0ID4EEBSAJSBWNsYXNziAEBQggKBl9ncmFkZUIJCgdfY2'
    '91cnNlQggKBl9jbGFzcw==');

@$core.Deprecated('Use getUserRequestDescriptor instead')
const GetUserRequest$json = {
  '1': 'GetUserRequest',
};

/// Descriptor for `GetUserRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getUserRequestDescriptor =
    $convert.base64Decode('Cg5HZXRVc2VyUmVxdWVzdA==');

@$core.Deprecated('Use getUserResponseDescriptor instead')
const GetUserResponse$json = {
  '1': 'GetUserResponse',
  '2': [
    {'1': 'user', '3': 1, '4': 1, '5': 11, '6': '.app.v1.User', '10': 'user'},
  ],
};

/// Descriptor for `GetUserResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getUserResponseDescriptor = $convert.base64Decode(
    'Cg9HZXRVc2VyUmVzcG9uc2USIAoEdXNlchgBIAEoCzIMLmFwcC52MS5Vc2VyUgR1c2Vy');

@$core.Deprecated('Use updateUserRequestDescriptor instead')
const UpdateUserRequest$json = {
  '1': 'UpdateUserRequest',
  '2': [
    {
      '1': 'grade',
      '3': 1,
      '4': 1,
      '5': 14,
      '6': '.app.v1.Grade',
      '8': {},
      '9': 0,
      '10': 'grade',
      '17': true
    },
    {
      '1': 'course',
      '3': 2,
      '4': 1,
      '5': 14,
      '6': '.app.v1.Course',
      '8': {},
      '9': 1,
      '10': 'course',
      '17': true
    },
    {
      '1': 'class',
      '3': 3,
      '4': 1,
      '5': 14,
      '6': '.app.v1.Class',
      '8': {},
      '9': 2,
      '10': 'class',
      '17': true
    },
    {
      '1': 'update_mask',
      '3': 99,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.FieldMask',
      '8': {},
      '10': 'updateMask'
    },
  ],
  '8': [
    {'1': '_grade'},
    {'1': '_course'},
    {'1': '_class'},
  ],
};

/// Descriptor for `UpdateUserRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateUserRequestDescriptor = $convert.base64Decode(
    'ChFVcGRhdGVVc2VyUmVxdWVzdBItCgVncmFkZRgBIAEoDjINLmFwcC52MS5HcmFkZUID4EEBSA'
    'BSBWdyYWRliAEBEjAKBmNvdXJzZRgCIAEoDjIOLmFwcC52MS5Db3Vyc2VCA+BBAUgBUgZjb3Vy'
    'c2WIAQESLQoFY2xhc3MYAyABKA4yDS5hcHAudjEuQ2xhc3NCA+BBAUgCUgVjbGFzc4gBARJACg'
    't1cGRhdGVfbWFzaxhjIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5GaWVsZE1hc2tCA+BBAVIKdXBk'
    'YXRlTWFza0IICgZfZ3JhZGVCCQoHX2NvdXJzZUIICgZfY2xhc3M=');

@$core.Deprecated('Use updateUserResponseDescriptor instead')
const UpdateUserResponse$json = {
  '1': 'UpdateUserResponse',
  '2': [
    {'1': 'user', '3': 1, '4': 1, '5': 11, '6': '.app.v1.User', '10': 'user'},
  ],
};

/// Descriptor for `UpdateUserResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateUserResponseDescriptor = $convert.base64Decode(
    'ChJVcGRhdGVVc2VyUmVzcG9uc2USIAoEdXNlchgBIAEoCzIMLmFwcC52MS5Vc2VyUgR1c2Vy');

const $core.Map<$core.String, $core.dynamic> UserServiceBase$json = {
  '1': 'UserService',
  '2': [
    {
      '1': 'GetUser',
      '2': '.app.v1.GetUserRequest',
      '3': '.app.v1.GetUserResponse'
    },
    {
      '1': 'UpdateUser',
      '2': '.app.v1.UpdateUserRequest',
      '3': '.app.v1.UpdateUserResponse'
    },
  ],
};

@$core.Deprecated('Use userServiceDescriptor instead')
const $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>>
    UserServiceBase$messageJson = {
  '.app.v1.GetUserRequest': GetUserRequest$json,
  '.app.v1.GetUserResponse': GetUserResponse$json,
  '.app.v1.User': User$json,
  '.app.v1.UpdateUserRequest': UpdateUserRequest$json,
  '.google.protobuf.FieldMask': $0.FieldMask$json,
  '.app.v1.UpdateUserResponse': UpdateUserResponse$json,
};

/// Descriptor for `UserService`. Decode as a `google.protobuf.ServiceDescriptorProto`.
final $typed_data.Uint8List userServiceDescriptor = $convert.base64Decode(
    'CgtVc2VyU2VydmljZRI6CgdHZXRVc2VyEhYuYXBwLnYxLkdldFVzZXJSZXF1ZXN0GhcuYXBwLn'
    'YxLkdldFVzZXJSZXNwb25zZRJDCgpVcGRhdGVVc2VyEhkuYXBwLnYxLlVwZGF0ZVVzZXJSZXF1'
    'ZXN0GhouYXBwLnYxLlVwZGF0ZVVzZXJSZXNwb25zZQ==');
