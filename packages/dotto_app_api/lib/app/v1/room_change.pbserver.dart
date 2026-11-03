// This is a generated file - do not edit.
//
// Generated from app/v1/room_change.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'room_change.pb.dart' as $5;
import 'room_change.pbjson.dart';

export 'room_change.pb.dart';

abstract class RoomChangeServiceBase extends $pb.GeneratedService {
  $async.Future<$5.ListRoomChangesResponse> listRoomChanges(
      $pb.ServerContext ctx, $5.ListRoomChangesRequest request);

  $pb.GeneratedMessage createRequest($core.String methodName) {
    switch (methodName) {
      case 'ListRoomChanges':
        return $5.ListRoomChangesRequest();
      default:
        throw $core.ArgumentError('Unknown method: $methodName');
    }
  }

  $async.Future<$pb.GeneratedMessage> handleCall($pb.ServerContext ctx,
      $core.String methodName, $pb.GeneratedMessage request) {
    switch (methodName) {
      case 'ListRoomChanges':
        return listRoomChanges(ctx, request as $5.ListRoomChangesRequest);
      default:
        throw $core.ArgumentError('Unknown method: $methodName');
    }
  }

  $core.Map<$core.String, $core.dynamic> get $json =>
      RoomChangeServiceBase$json;
  $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>>
      get $messageJson => RoomChangeServiceBase$messageJson;
}
