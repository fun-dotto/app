// This is a generated file - do not edit.
//
// Generated from app/v1/bus_trip.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

/// バスの運行の注意情報。
class BusTripAlert extends $pb.ProtobufEnum {
  /// 未指定。
  static const BusTripAlert BUS_TRIP_ALERT_UNSPECIFIED =
      BusTripAlert._(0, _omitEnumNames ? '' : 'BUS_TRIP_ALERT_UNSPECIFIED');

  /// なし。
  static const BusTripAlert BUS_TRIP_ALERT_NONE =
      BusTripAlert._(1, _omitEnumNames ? '' : 'BUS_TRIP_ALERT_NONE');

  /// 運休。
  static const BusTripAlert BUS_TRIP_ALERT_CANCELLATION =
      BusTripAlert._(2, _omitEnumNames ? '' : 'BUS_TRIP_ALERT_CANCELLATION');

  static const $core.List<BusTripAlert> values = <BusTripAlert>[
    BUS_TRIP_ALERT_UNSPECIFIED,
    BUS_TRIP_ALERT_NONE,
    BUS_TRIP_ALERT_CANCELLATION,
  ];

  static final $core.List<BusTripAlert?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 2);
  static BusTripAlert? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const BusTripAlert._(super.value, super.name);
}

const $core.bool _omitEnumNames =
    $core.bool.fromEnvironment('protobuf.omit_enum_names');
