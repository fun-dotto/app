// This is a generated file - do not edit.
//
// Generated from app/v1/article.proto.

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

@$core.Deprecated('Use articleDescriptor instead')
const Article$json = {
  '1': 'Article',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '8': {}, '10': 'id'},
    {'1': 'url', '3': 2, '4': 1, '5': 9, '8': {}, '10': 'url'},
    {'1': 'title', '3': 3, '4': 1, '5': 9, '8': {}, '10': 'title'},
    {
      '1': 'publish_time',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '8': {},
      '10': 'publishTime'
    },
  ],
};

/// Descriptor for `Article`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List articleDescriptor = $convert.base64Decode(
    'CgdBcnRpY2xlEhMKAmlkGAEgASgJQgPgQQNSAmlkEhUKA3VybBgCIAEoCUID4EEDUgN1cmwSGQ'
    'oFdGl0bGUYAyABKAlCA+BBA1IFdGl0bGUSQgoMcHVibGlzaF90aW1lGAQgASgLMhouZ29vZ2xl'
    'LnByb3RvYnVmLlRpbWVzdGFtcEID4EEDUgtwdWJsaXNoVGltZQ==');

@$core.Deprecated('Use listArticlesRequestDescriptor instead')
const ListArticlesRequest$json = {
  '1': 'ListArticlesRequest',
};

/// Descriptor for `ListArticlesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listArticlesRequestDescriptor =
    $convert.base64Decode('ChNMaXN0QXJ0aWNsZXNSZXF1ZXN0');

@$core.Deprecated('Use listArticlesResponseDescriptor instead')
const ListArticlesResponse$json = {
  '1': 'ListArticlesResponse',
  '2': [
    {
      '1': 'articles',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.app.v1.Article',
      '10': 'articles'
    },
  ],
};

/// Descriptor for `ListArticlesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listArticlesResponseDescriptor = $convert.base64Decode(
    'ChRMaXN0QXJ0aWNsZXNSZXNwb25zZRIrCghhcnRpY2xlcxgBIAMoCzIPLmFwcC52MS5BcnRpY2'
    'xlUghhcnRpY2xlcw==');

const $core.Map<$core.String, $core.dynamic> ArticleServiceBase$json = {
  '1': 'ArticleService',
  '2': [
    {
      '1': 'ListArticles',
      '2': '.app.v1.ListArticlesRequest',
      '3': '.app.v1.ListArticlesResponse'
    },
  ],
};

@$core.Deprecated('Use articleServiceDescriptor instead')
const $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>>
    ArticleServiceBase$messageJson = {
  '.app.v1.ListArticlesRequest': ListArticlesRequest$json,
  '.app.v1.ListArticlesResponse': ListArticlesResponse$json,
  '.app.v1.Article': Article$json,
  '.google.protobuf.Timestamp': $0.Timestamp$json,
};

/// Descriptor for `ArticleService`. Decode as a `google.protobuf.ServiceDescriptorProto`.
final $typed_data.Uint8List articleServiceDescriptor = $convert.base64Decode(
    'Cg5BcnRpY2xlU2VydmljZRJJCgxMaXN0QXJ0aWNsZXMSGy5hcHAudjEuTGlzdEFydGljbGVzUm'
    'VxdWVzdBocLmFwcC52MS5MaXN0QXJ0aWNsZXNSZXNwb25zZQ==');
