// This is a generated file - do not edit.
//
// Generated from app/v1/cancelled_class.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'cancelled_class.pb.dart' as $4;
import 'cancelled_class.pbjson.dart';

export 'cancelled_class.pb.dart';

abstract class CancelledClassServiceBase extends $pb.GeneratedService {
  $async.Future<$4.ListCancelledClassesResponse> listCancelledClasses(
      $pb.ServerContext ctx, $4.ListCancelledClassesRequest request);

  $pb.GeneratedMessage createRequest($core.String methodName) {
    switch (methodName) {
      case 'ListCancelledClasses':
        return $4.ListCancelledClassesRequest();
      default:
        throw $core.ArgumentError('Unknown method: $methodName');
    }
  }

  $async.Future<$pb.GeneratedMessage> handleCall($pb.ServerContext ctx,
      $core.String methodName, $pb.GeneratedMessage request) {
    switch (methodName) {
      case 'ListCancelledClasses':
        return listCancelledClasses(
            ctx, request as $4.ListCancelledClassesRequest);
      default:
        throw $core.ArgumentError('Unknown method: $methodName');
    }
  }

  $core.Map<$core.String, $core.dynamic> get $json =>
      CancelledClassServiceBase$json;
  $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>>
      get $messageJson => CancelledClassServiceBase$messageJson;
}
