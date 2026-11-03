// This is a generated file - do not edit.
//
// Generated from app/v1/makeup_class.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'makeup_class.pb.dart' as $4;
import 'makeup_class.pbjson.dart';

export 'makeup_class.pb.dart';

abstract class MakeupClassServiceBase extends $pb.GeneratedService {
  $async.Future<$4.ListMakeupClassesResponse> listMakeupClasses(
      $pb.ServerContext ctx, $4.ListMakeupClassesRequest request);

  $pb.GeneratedMessage createRequest($core.String methodName) {
    switch (methodName) {
      case 'ListMakeupClasses':
        return $4.ListMakeupClassesRequest();
      default:
        throw $core.ArgumentError('Unknown method: $methodName');
    }
  }

  $async.Future<$pb.GeneratedMessage> handleCall($pb.ServerContext ctx,
      $core.String methodName, $pb.GeneratedMessage request) {
    switch (methodName) {
      case 'ListMakeupClasses':
        return listMakeupClasses(ctx, request as $4.ListMakeupClassesRequest);
      default:
        throw $core.ArgumentError('Unknown method: $methodName');
    }
  }

  $core.Map<$core.String, $core.dynamic> get $json =>
      MakeupClassServiceBase$json;
  $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>>
      get $messageJson => MakeupClassServiceBase$messageJson;
}
