// This is a generated file - do not edit.
//
// Generated from app/v1/announcement.proto.

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

@$core.Deprecated('Use announcementDescriptor instead')
const Announcement$json = {
  '1': 'Announcement',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '8': {}, '10': 'id'},
    {'1': 'title', '3': 2, '4': 1, '5': 9, '8': {}, '10': 'title'},
    {'1': 'url', '3': 3, '4': 1, '5': 9, '8': {}, '10': 'url'},
    {
      '1': 'available_from',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '8': {},
      '10': 'availableFrom'
    },
  ],
};

/// Descriptor for `Announcement`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List announcementDescriptor = $convert.base64Decode(
    'CgxBbm5vdW5jZW1lbnQSEwoCaWQYASABKAlCA+BBA1ICaWQSGQoFdGl0bGUYAiABKAlCA+BBA1'
    'IFdGl0bGUSFQoDdXJsGAMgASgJQgPgQQNSA3VybBJGCg5hdmFpbGFibGVfZnJvbRgEIAEoCzIa'
    'Lmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBCA+BBA1INYXZhaWxhYmxlRnJvbQ==');

@$core.Deprecated('Use listAnnouncementsRequestDescriptor instead')
const ListAnnouncementsRequest$json = {
  '1': 'ListAnnouncementsRequest',
  '9': [
    {'1': 1, '2': 2},
    {'1': 2, '2': 3},
  ],
  '10': ['page_size', 'page_token'],
};

/// Descriptor for `ListAnnouncementsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listAnnouncementsRequestDescriptor =
    $convert.base64Decode(
        'ChhMaXN0QW5ub3VuY2VtZW50c1JlcXVlc3RKBAgBEAJKBAgCEANSCXBhZ2Vfc2l6ZVIKcGFnZV'
        '90b2tlbg==');

@$core.Deprecated('Use listAnnouncementsResponseDescriptor instead')
const ListAnnouncementsResponse$json = {
  '1': 'ListAnnouncementsResponse',
  '2': [
    {
      '1': 'announcements',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.app.v1.Announcement',
      '10': 'announcements'
    },
  ],
  '9': [
    {'1': 2, '2': 3},
  ],
  '10': ['next_page_token'],
};

/// Descriptor for `ListAnnouncementsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listAnnouncementsResponseDescriptor = $convert.base64Decode(
    'ChlMaXN0QW5ub3VuY2VtZW50c1Jlc3BvbnNlEjoKDWFubm91bmNlbWVudHMYASADKAsyFC5hcH'
    'AudjEuQW5ub3VuY2VtZW50Ug1hbm5vdW5jZW1lbnRzSgQIAhADUg9uZXh0X3BhZ2VfdG9rZW4=');

const $core.Map<$core.String, $core.dynamic> AnnouncementServiceBase$json = {
  '1': 'AnnouncementService',
  '2': [
    {
      '1': 'ListAnnouncements',
      '2': '.app.v1.ListAnnouncementsRequest',
      '3': '.app.v1.ListAnnouncementsResponse'
    },
  ],
};

@$core.Deprecated('Use announcementServiceDescriptor instead')
const $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>>
    AnnouncementServiceBase$messageJson = {
  '.app.v1.ListAnnouncementsRequest': ListAnnouncementsRequest$json,
  '.app.v1.ListAnnouncementsResponse': ListAnnouncementsResponse$json,
  '.app.v1.Announcement': Announcement$json,
  '.google.protobuf.Timestamp': $0.Timestamp$json,
};

/// Descriptor for `AnnouncementService`. Decode as a `google.protobuf.ServiceDescriptorProto`.
final $typed_data.Uint8List announcementServiceDescriptor = $convert.base64Decode(
    'ChNBbm5vdW5jZW1lbnRTZXJ2aWNlElgKEUxpc3RBbm5vdW5jZW1lbnRzEiAuYXBwLnYxLkxpc3'
    'RBbm5vdW5jZW1lbnRzUmVxdWVzdBohLmFwcC52MS5MaXN0QW5ub3VuY2VtZW50c1Jlc3BvbnNl');
