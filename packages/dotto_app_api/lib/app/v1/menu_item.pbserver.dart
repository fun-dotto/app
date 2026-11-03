// This is a generated file - do not edit.
//
// Generated from app/v1/menu_item.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'menu_item.pb.dart' as $1;
import 'menu_item.pbjson.dart';

export 'menu_item.pb.dart';

abstract class MenuItemServiceBase extends $pb.GeneratedService {
  $async.Future<$1.ListMenuItemsResponse> listMenuItems(
      $pb.ServerContext ctx, $1.ListMenuItemsRequest request);

  $pb.GeneratedMessage createRequest($core.String methodName) {
    switch (methodName) {
      case 'ListMenuItems':
        return $1.ListMenuItemsRequest();
      default:
        throw $core.ArgumentError('Unknown method: $methodName');
    }
  }

  $async.Future<$pb.GeneratedMessage> handleCall($pb.ServerContext ctx,
      $core.String methodName, $pb.GeneratedMessage request) {
    switch (methodName) {
      case 'ListMenuItems':
        return listMenuItems(ctx, request as $1.ListMenuItemsRequest);
      default:
        throw $core.ArgumentError('Unknown method: $methodName');
    }
  }

  $core.Map<$core.String, $core.dynamic> get $json => MenuItemServiceBase$json;
  $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>>
      get $messageJson => MenuItemServiceBase$messageJson;
}
