// This is a generated file - do not edit.
//
// Generated from app/v1/room.proto.

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

@$core.Deprecated('Use roomFloorDescriptor instead')
const RoomFloor$json = {
  '1': 'RoomFloor',
  '2': [
    {'1': 'ROOM_FLOOR_UNSPECIFIED', '2': 0},
    {'1': 'ROOM_FLOOR_1', '2': 1},
    {'1': 'ROOM_FLOOR_2', '2': 2},
    {'1': 'ROOM_FLOOR_3', '2': 3},
    {'1': 'ROOM_FLOOR_4', '2': 4},
    {'1': 'ROOM_FLOOR_5', '2': 5},
    {'1': 'ROOM_FLOOR_6', '2': 6},
    {'1': 'ROOM_FLOOR_7', '2': 7},
    {'1': 'ROOM_FLOOR_VIRTUAL', '2': 8},
  ],
};

/// Descriptor for `RoomFloor`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List roomFloorDescriptor = $convert.base64Decode(
    'CglSb29tRmxvb3ISGgoWUk9PTV9GTE9PUl9VTlNQRUNJRklFRBAAEhAKDFJPT01fRkxPT1JfMR'
    'ABEhAKDFJPT01fRkxPT1JfMhACEhAKDFJPT01fRkxPT1JfMxADEhAKDFJPT01fRkxPT1JfNBAE'
    'EhAKDFJPT01fRkxPT1JfNRAFEhAKDFJPT01fRkxPT1JfNhAGEhAKDFJPT01fRkxPT1JfNxAHEh'
    'YKElJPT01fRkxPT1JfVklSVFVBTBAI');

@$core.Deprecated('Use roomDescriptor instead')
const Room$json = {
  '1': 'Room',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '8': {}, '10': 'id'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '8': {}, '10': 'name'},
    {
      '1': 'floor',
      '3': 3,
      '4': 1,
      '5': 14,
      '6': '.app.v1.RoomFloor',
      '8': {},
      '10': 'floor'
    },
    {
      '1': 'faculty',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.app.v1.Faculty',
      '8': {},
      '9': 0,
      '10': 'faculty',
      '17': true
    },
  ],
  '8': [
    {'1': '_faculty'},
  ],
};

/// Descriptor for `Room`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List roomDescriptor = $convert.base64Decode(
    'CgRSb29tEhMKAmlkGAEgASgJQgPgQQNSAmlkEhcKBG5hbWUYAiABKAlCA+BBA1IEbmFtZRIsCg'
    'VmbG9vchgDIAEoDjIRLmFwcC52MS5Sb29tRmxvb3JCA+BBA1IFZmxvb3ISMwoHZmFjdWx0eRgE'
    'IAEoCzIPLmFwcC52MS5GYWN1bHR5QgPgQQNIAFIHZmFjdWx0eYgBAUIKCghfZmFjdWx0eQ==');
