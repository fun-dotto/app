// This is a generated file - do not edit.
//
// Generated from app/v1/menu_item.proto.

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

@$core.Deprecated('Use menuItemCategoryDescriptor instead')
const MenuItemCategory$json = {
  '1': 'MenuItemCategory',
  '2': [
    {'1': 'MENU_ITEM_CATEGORY_UNSPECIFIED', '2': 0},
    {'1': 'MENU_ITEM_CATEGORY_SET_AND_SINGLE', '2': 1},
    {'1': 'MENU_ITEM_CATEGORY_BOWL_AND_CURRY', '2': 2},
    {'1': 'MENU_ITEM_CATEGORY_NOODLE', '2': 3},
    {'1': 'MENU_ITEM_CATEGORY_SIDE', '2': 4},
    {'1': 'MENU_ITEM_CATEGORY_DESSERT', '2': 5},
  ],
};

/// Descriptor for `MenuItemCategory`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List menuItemCategoryDescriptor = $convert.base64Decode(
    'ChBNZW51SXRlbUNhdGVnb3J5EiIKHk1FTlVfSVRFTV9DQVRFR09SWV9VTlNQRUNJRklFRBAAEi'
    'UKIU1FTlVfSVRFTV9DQVRFR09SWV9TRVRfQU5EX1NJTkdMRRABEiUKIU1FTlVfSVRFTV9DQVRF'
    'R09SWV9CT1dMX0FORF9DVVJSWRACEh0KGU1FTlVfSVRFTV9DQVRFR09SWV9OT09ETEUQAxIbCh'
    'dNRU5VX0lURU1fQ0FURUdPUllfU0lERRAEEh4KGk1FTlVfSVRFTV9DQVRFR09SWV9ERVNTRVJU'
    'EAU=');

@$core.Deprecated('Use menuItemSizeDescriptor instead')
const MenuItemSize$json = {
  '1': 'MenuItemSize',
  '2': [
    {'1': 'MENU_ITEM_SIZE_UNSPECIFIED', '2': 0},
    {'1': 'MENU_ITEM_SIZE_SMALL', '2': 1},
    {'1': 'MENU_ITEM_SIZE_MEDIUM', '2': 2},
    {'1': 'MENU_ITEM_SIZE_LARGE', '2': 3},
  ],
};

/// Descriptor for `MenuItemSize`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List menuItemSizeDescriptor = $convert.base64Decode(
    'CgxNZW51SXRlbVNpemUSHgoaTUVOVV9JVEVNX1NJWkVfVU5TUEVDSUZJRUQQABIYChRNRU5VX0'
    'lURU1fU0laRV9TTUFMTBABEhkKFU1FTlVfSVRFTV9TSVpFX01FRElVTRACEhgKFE1FTlVfSVRF'
    'TV9TSVpFX0xBUkdFEAM=');

@$core.Deprecated('Use menuItemPriceDescriptor instead')
const MenuItemPrice$json = {
  '1': 'MenuItemPrice',
  '2': [
    {
      '1': 'size',
      '3': 1,
      '4': 1,
      '5': 14,
      '6': '.app.v1.MenuItemSize',
      '8': {},
      '10': 'size'
    },
    {'1': 'price', '3': 2, '4': 1, '5': 5, '8': {}, '10': 'price'},
  ],
};

/// Descriptor for `MenuItemPrice`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List menuItemPriceDescriptor = $convert.base64Decode(
    'Cg1NZW51SXRlbVByaWNlEi0KBHNpemUYASABKA4yFC5hcHAudjEuTWVudUl0ZW1TaXplQgPgQQ'
    'NSBHNpemUSGQoFcHJpY2UYAiABKAVCA+BBA1IFcHJpY2U=');

@$core.Deprecated('Use menuItemDescriptor instead')
const MenuItem$json = {
  '1': 'MenuItem',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '8': {}, '10': 'id'},
    {
      '1': 'date',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.google.type.Date',
      '8': {},
      '10': 'date'
    },
    {'1': 'name', '3': 3, '4': 1, '5': 9, '8': {}, '10': 'name'},
    {'1': 'image_url', '3': 4, '4': 1, '5': 9, '8': {}, '10': 'imageUrl'},
    {
      '1': 'category',
      '3': 5,
      '4': 1,
      '5': 14,
      '6': '.app.v1.MenuItemCategory',
      '8': {},
      '10': 'category'
    },
    {
      '1': 'prices',
      '3': 6,
      '4': 3,
      '5': 11,
      '6': '.app.v1.MenuItemPrice',
      '8': {},
      '10': 'prices'
    },
  ],
};

/// Descriptor for `MenuItem`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List menuItemDescriptor = $convert.base64Decode(
    'CghNZW51SXRlbRITCgJpZBgBIAEoCUID4EEDUgJpZBIqCgRkYXRlGAIgASgLMhEuZ29vZ2xlLn'
    'R5cGUuRGF0ZUID4EEDUgRkYXRlEhcKBG5hbWUYAyABKAlCA+BBA1IEbmFtZRIgCglpbWFnZV91'
    'cmwYBCABKAlCA+BBA1IIaW1hZ2VVcmwSOQoIY2F0ZWdvcnkYBSABKA4yGC5hcHAudjEuTWVudU'
    'l0ZW1DYXRlZ29yeUID4EEDUghjYXRlZ29yeRIyCgZwcmljZXMYBiADKAsyFS5hcHAudjEuTWVu'
    'dUl0ZW1QcmljZUID4EEDUgZwcmljZXM=');

@$core.Deprecated('Use listMenuItemsRequestDescriptor instead')
const ListMenuItemsRequest$json = {
  '1': 'ListMenuItemsRequest',
  '2': [
    {
      '1': 'date',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.google.type.Date',
      '8': {},
      '10': 'date'
    },
  ],
  '9': [
    {'1': 1, '2': 2},
    {'1': 2, '2': 3},
  ],
  '10': ['page_size', 'page_token'],
};

/// Descriptor for `ListMenuItemsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listMenuItemsRequestDescriptor = $convert.base64Decode(
    'ChRMaXN0TWVudUl0ZW1zUmVxdWVzdBIqCgRkYXRlGAMgASgLMhEuZ29vZ2xlLnR5cGUuRGF0ZU'
    'ID4EECUgRkYXRlSgQIARACSgQIAhADUglwYWdlX3NpemVSCnBhZ2VfdG9rZW4=');

@$core.Deprecated('Use listMenuItemsResponseDescriptor instead')
const ListMenuItemsResponse$json = {
  '1': 'ListMenuItemsResponse',
  '2': [
    {
      '1': 'menu_items',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.app.v1.MenuItem',
      '10': 'menuItems'
    },
  ],
  '9': [
    {'1': 2, '2': 3},
  ],
  '10': ['next_page_token'],
};

/// Descriptor for `ListMenuItemsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listMenuItemsResponseDescriptor = $convert.base64Decode(
    'ChVMaXN0TWVudUl0ZW1zUmVzcG9uc2USLwoKbWVudV9pdGVtcxgBIAMoCzIQLmFwcC52MS5NZW'
    '51SXRlbVIJbWVudUl0ZW1zSgQIAhADUg9uZXh0X3BhZ2VfdG9rZW4=');

const $core.Map<$core.String, $core.dynamic> MenuItemServiceBase$json = {
  '1': 'MenuItemService',
  '2': [
    {
      '1': 'ListMenuItems',
      '2': '.app.v1.ListMenuItemsRequest',
      '3': '.app.v1.ListMenuItemsResponse'
    },
  ],
};

@$core.Deprecated('Use menuItemServiceDescriptor instead')
const $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>>
    MenuItemServiceBase$messageJson = {
  '.app.v1.ListMenuItemsRequest': ListMenuItemsRequest$json,
  '.google.type.Date': $0.Date$json,
  '.app.v1.ListMenuItemsResponse': ListMenuItemsResponse$json,
  '.app.v1.MenuItem': MenuItem$json,
  '.app.v1.MenuItemPrice': MenuItemPrice$json,
};

/// Descriptor for `MenuItemService`. Decode as a `google.protobuf.ServiceDescriptorProto`.
final $typed_data.Uint8List menuItemServiceDescriptor = $convert.base64Decode(
    'Cg9NZW51SXRlbVNlcnZpY2USTAoNTGlzdE1lbnVJdGVtcxIcLmFwcC52MS5MaXN0TWVudUl0ZW'
    '1zUmVxdWVzdBodLmFwcC52MS5MaXN0TWVudUl0ZW1zUmVzcG9uc2U=');
