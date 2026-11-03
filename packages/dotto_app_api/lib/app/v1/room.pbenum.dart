// This is a generated file - do not edit.
//
// Generated from app/v1/room.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

/// フロア。
class RoomFloor extends $pb.ProtobufEnum {
  /// 未指定。
  static const RoomFloor ROOM_FLOOR_UNSPECIFIED =
      RoomFloor._(0, _omitEnumNames ? '' : 'ROOM_FLOOR_UNSPECIFIED');

  /// 1 階。
  static const RoomFloor ROOM_FLOOR_1 =
      RoomFloor._(1, _omitEnumNames ? '' : 'ROOM_FLOOR_1');

  /// 2 階。
  static const RoomFloor ROOM_FLOOR_2 =
      RoomFloor._(2, _omitEnumNames ? '' : 'ROOM_FLOOR_2');

  /// 3 階。
  static const RoomFloor ROOM_FLOOR_3 =
      RoomFloor._(3, _omitEnumNames ? '' : 'ROOM_FLOOR_3');

  /// 4 階。
  static const RoomFloor ROOM_FLOOR_4 =
      RoomFloor._(4, _omitEnumNames ? '' : 'ROOM_FLOOR_4');

  /// 5 階。
  static const RoomFloor ROOM_FLOOR_5 =
      RoomFloor._(5, _omitEnumNames ? '' : 'ROOM_FLOOR_5');

  /// 6 階。
  static const RoomFloor ROOM_FLOOR_6 =
      RoomFloor._(6, _omitEnumNames ? '' : 'ROOM_FLOOR_6');

  /// 7 階。
  static const RoomFloor ROOM_FLOOR_7 =
      RoomFloor._(7, _omitEnumNames ? '' : 'ROOM_FLOOR_7');

  /// 仮想教室。
  static const RoomFloor ROOM_FLOOR_VIRTUAL =
      RoomFloor._(8, _omitEnumNames ? '' : 'ROOM_FLOOR_VIRTUAL');

  static const $core.List<RoomFloor> values = <RoomFloor>[
    ROOM_FLOOR_UNSPECIFIED,
    ROOM_FLOOR_1,
    ROOM_FLOOR_2,
    ROOM_FLOOR_3,
    ROOM_FLOOR_4,
    ROOM_FLOOR_5,
    ROOM_FLOOR_6,
    ROOM_FLOOR_7,
    ROOM_FLOOR_VIRTUAL,
  ];

  static final $core.List<RoomFloor?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 8);
  static RoomFloor? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const RoomFloor._(super.value, super.name);
}

const $core.bool _omitEnumNames =
    $core.bool.fromEnvironment('protobuf.omit_enum_names');
