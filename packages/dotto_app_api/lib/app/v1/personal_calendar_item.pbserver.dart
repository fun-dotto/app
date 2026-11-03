// This is a generated file - do not edit.
//
// Generated from app/v1/personal_calendar_item.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'personal_calendar_item.pb.dart' as $5;
import 'personal_calendar_item.pbjson.dart';

export 'personal_calendar_item.pb.dart';

abstract class PersonalCalendarItemServiceBase extends $pb.GeneratedService {
  $async.Future<$5.ListPersonalCalendarItemsResponse> listPersonalCalendarItems(
      $pb.ServerContext ctx, $5.ListPersonalCalendarItemsRequest request);

  $pb.GeneratedMessage createRequest($core.String methodName) {
    switch (methodName) {
      case 'ListPersonalCalendarItems':
        return $5.ListPersonalCalendarItemsRequest();
      default:
        throw $core.ArgumentError('Unknown method: $methodName');
    }
  }

  $async.Future<$pb.GeneratedMessage> handleCall($pb.ServerContext ctx,
      $core.String methodName, $pb.GeneratedMessage request) {
    switch (methodName) {
      case 'ListPersonalCalendarItems':
        return listPersonalCalendarItems(
            ctx, request as $5.ListPersonalCalendarItemsRequest);
      default:
        throw $core.ArgumentError('Unknown method: $methodName');
    }
  }

  $core.Map<$core.String, $core.dynamic> get $json =>
      PersonalCalendarItemServiceBase$json;
  $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>>
      get $messageJson => PersonalCalendarItemServiceBase$messageJson;
}
