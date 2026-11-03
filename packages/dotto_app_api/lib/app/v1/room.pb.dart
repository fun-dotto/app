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

import 'faculty.pb.dart' as $0;
import 'room.pbenum.dart';

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

export 'room.pbenum.dart';

/// 教室。
class Room extends $pb.GeneratedMessage {
  factory Room({
    $core.String? id,
    $core.String? name,
    RoomFloor? floor,
    $0.Faculty? faculty,
  }) {
    final result = Room._();
    if (id != null) result.id = id;
    if (name != null) result.name = name;
    if (floor != null) result.floor = floor;
    if (faculty != null) result.faculty = faculty;
    return result;
  }

  Room._();

  factory Room.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      Room()..mergeFromBuffer(data, registry);
  factory Room.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      Room()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Room',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'app.v1'),
      createEmptyInstance: Room.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..aE<RoomFloor>(3, _omitFieldNames ? '' : 'floor',
        enumValues: RoomFloor.values)
    ..aOM<$0.Faculty>(4, _omitFieldNames ? '' : 'faculty',
        subBuilder: $0.Faculty.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Room clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Room copyWith(void Function(Room) updates) =>
      super.copyWith((message) => updates(message as Room)) as Room;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use Room() / Room.new instead')
  static Room create() => Room._();
  static $pb.GeneratedMessage $_createMessage() => Room._();
  @$core.override
  Room createEmptyInstance() => Room._();
  @$core.pragma('dart2js:noInline')
  static Room getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<Room>(Room.$_createMessage);
  static Room? _defaultInstance;

  /// ID。
  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  /// 部屋名。
  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => $_clearField(2);

  /// フロア。オンラインなどの仮想教室の場合は ROOM_FLOOR_VIRTUAL。
  @$pb.TagNumber(3)
  RoomFloor get floor => $_getN(2);
  @$pb.TagNumber(3)
  set floor(RoomFloor value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasFloor() => $_has(2);
  @$pb.TagNumber(3)
  void clearFloor() => $_clearField(3);

  /// 教員室の教員。空室の教員室や教員室でない場合は未設定。
  @$pb.TagNumber(4)
  $0.Faculty get faculty => $_getN(3);
  @$pb.TagNumber(4)
  set faculty($0.Faculty value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasFaculty() => $_has(3);
  @$pb.TagNumber(4)
  void clearFaculty() => $_clearField(4);
  @$pb.TagNumber(4)
  $0.Faculty ensureFaculty() => $_ensure(3);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
