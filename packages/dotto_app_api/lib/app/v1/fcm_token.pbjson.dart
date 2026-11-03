// This is a generated file - do not edit.
//
// Generated from app/v1/fcm_token.proto.

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
    as $0;

@$core.Deprecated('Use fcmTokenDescriptor instead')
const FcmToken$json = {
  '1': 'FcmToken',
  '2': [
    {'1': 'token', '3': 1, '4': 1, '5': 9, '8': {}, '10': 'token'},
    {
      '1': 'created_at',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '8': {},
      '10': 'createdAt'
    },
    {
      '1': 'updated_at',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '8': {},
      '10': 'updatedAt'
    },
  ],
};

/// Descriptor for `FcmToken`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List fcmTokenDescriptor = $convert.base64Decode(
    'CghGY21Ub2tlbhIZCgV0b2tlbhgBIAEoCUID4EEDUgV0b2tlbhI+CgpjcmVhdGVkX2F0GAIgAS'
    'gLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcEID4EEDUgljcmVhdGVkQXQSPgoKdXBkYXRl'
    'ZF9hdBgDIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBCA+BBA1IJdXBkYXRlZEF0');

@$core.Deprecated('Use registerFcmTokenRequestDescriptor instead')
const RegisterFcmTokenRequest$json = {
  '1': 'RegisterFcmTokenRequest',
  '2': [
    {'1': 'token', '3': 1, '4': 1, '5': 9, '8': {}, '10': 'token'},
  ],
};

/// Descriptor for `RegisterFcmTokenRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List registerFcmTokenRequestDescriptor =
    $convert.base64Decode(
        'ChdSZWdpc3RlckZjbVRva2VuUmVxdWVzdBIZCgV0b2tlbhgBIAEoCUID4EECUgV0b2tlbg==');

@$core.Deprecated('Use registerFcmTokenResponseDescriptor instead')
const RegisterFcmTokenResponse$json = {
  '1': 'RegisterFcmTokenResponse',
  '2': [
    {
      '1': 'fcm_token',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.app.v1.FcmToken',
      '10': 'fcmToken'
    },
  ],
};

/// Descriptor for `RegisterFcmTokenResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List registerFcmTokenResponseDescriptor =
    $convert.base64Decode(
        'ChhSZWdpc3RlckZjbVRva2VuUmVzcG9uc2USLQoJZmNtX3Rva2VuGAEgASgLMhAuYXBwLnYxLk'
        'ZjbVRva2VuUghmY21Ub2tlbg==');

const $core.Map<$core.String, $core.dynamic> FcmTokenServiceBase$json = {
  '1': 'FcmTokenService',
  '2': [
    {
      '1': 'RegisterFcmToken',
      '2': '.app.v1.RegisterFcmTokenRequest',
      '3': '.app.v1.RegisterFcmTokenResponse'
    },
  ],
};

@$core.Deprecated('Use fcmTokenServiceDescriptor instead')
const $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>>
    FcmTokenServiceBase$messageJson = {
  '.app.v1.RegisterFcmTokenRequest': RegisterFcmTokenRequest$json,
  '.app.v1.RegisterFcmTokenResponse': RegisterFcmTokenResponse$json,
  '.app.v1.FcmToken': FcmToken$json,
  '.google.protobuf.Timestamp': $0.Timestamp$json,
};

/// Descriptor for `FcmTokenService`. Decode as a `google.protobuf.ServiceDescriptorProto`.
final $typed_data.Uint8List fcmTokenServiceDescriptor = $convert.base64Decode(
    'Cg9GY21Ub2tlblNlcnZpY2USVQoQUmVnaXN0ZXJGY21Ub2tlbhIfLmFwcC52MS5SZWdpc3Rlck'
    'ZjbVRva2VuUmVxdWVzdBogLmFwcC52MS5SZWdpc3RlckZjbVRva2VuUmVzcG9uc2U=');
