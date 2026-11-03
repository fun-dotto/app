// This is a generated file - do not edit.
//
// Generated from app/v1/personal_calendar_item.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

/// 個人カレンダーアイテムの状態。教室変更よりも休講・補講を優先する。
class PersonalCalendarItem_State extends $pb.ProtobufEnum {
  /// 未指定。
  static const PersonalCalendarItem_State STATE_UNSPECIFIED =
      PersonalCalendarItem_State._(
          0, _omitEnumNames ? '' : 'STATE_UNSPECIFIED');

  /// 通常。
  static const PersonalCalendarItem_State STATE_NORMAL =
      PersonalCalendarItem_State._(1, _omitEnumNames ? '' : 'STATE_NORMAL');

  /// 休講。
  static const PersonalCalendarItem_State STATE_CANCELLED =
      PersonalCalendarItem_State._(2, _omitEnumNames ? '' : 'STATE_CANCELLED');

  /// 補講。
  static const PersonalCalendarItem_State STATE_MAKEUP =
      PersonalCalendarItem_State._(3, _omitEnumNames ? '' : 'STATE_MAKEUP');

  /// 教室変更。
  static const PersonalCalendarItem_State STATE_ROOM_CHANGED =
      PersonalCalendarItem_State._(
          4, _omitEnumNames ? '' : 'STATE_ROOM_CHANGED');

  static const $core.List<PersonalCalendarItem_State> values =
      <PersonalCalendarItem_State>[
    STATE_UNSPECIFIED,
    STATE_NORMAL,
    STATE_CANCELLED,
    STATE_MAKEUP,
    STATE_ROOM_CHANGED,
  ];

  static final $core.List<PersonalCalendarItem_State?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 4);
  static PersonalCalendarItem_State? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const PersonalCalendarItem_State._(super.value, super.name);
}

const $core.bool _omitEnumNames =
    $core.bool.fromEnvironment('protobuf.omit_enum_names');
