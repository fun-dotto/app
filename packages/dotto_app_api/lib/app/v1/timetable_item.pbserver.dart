// This is a generated file - do not edit.
//
// Generated from app/v1/timetable_item.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'timetable_item.pb.dart' as $5;
import 'timetable_item.pbjson.dart';

export 'timetable_item.pb.dart';

abstract class TimetableItemServiceBase extends $pb.GeneratedService {
  $async.Future<$5.ListTimetableItemsResponse> listTimetableItems(
      $pb.ServerContext ctx, $5.ListTimetableItemsRequest request);

  $pb.GeneratedMessage createRequest($core.String methodName) {
    switch (methodName) {
      case 'ListTimetableItems':
        return $5.ListTimetableItemsRequest();
      default:
        throw $core.ArgumentError('Unknown method: $methodName');
    }
  }

  $async.Future<$pb.GeneratedMessage> handleCall($pb.ServerContext ctx,
      $core.String methodName, $pb.GeneratedMessage request) {
    switch (methodName) {
      case 'ListTimetableItems':
        return listTimetableItems(ctx, request as $5.ListTimetableItemsRequest);
      default:
        throw $core.ArgumentError('Unknown method: $methodName');
    }
  }

  $core.Map<$core.String, $core.dynamic> get $json =>
      TimetableItemServiceBase$json;
  $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>>
      get $messageJson => TimetableItemServiceBase$messageJson;
}
