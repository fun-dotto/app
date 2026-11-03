// This is a generated file - do not edit.
//
// Generated from app/v1/announcement.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'announcement.pb.dart' as $1;
import 'announcement.pbjson.dart';

export 'announcement.pb.dart';

abstract class AnnouncementServiceBase extends $pb.GeneratedService {
  $async.Future<$1.ListAnnouncementsResponse> listAnnouncements(
      $pb.ServerContext ctx, $1.ListAnnouncementsRequest request);

  $pb.GeneratedMessage createRequest($core.String methodName) {
    switch (methodName) {
      case 'ListAnnouncements':
        return $1.ListAnnouncementsRequest();
      default:
        throw $core.ArgumentError('Unknown method: $methodName');
    }
  }

  $async.Future<$pb.GeneratedMessage> handleCall($pb.ServerContext ctx,
      $core.String methodName, $pb.GeneratedMessage request) {
    switch (methodName) {
      case 'ListAnnouncements':
        return listAnnouncements(ctx, request as $1.ListAnnouncementsRequest);
      default:
        throw $core.ArgumentError('Unknown method: $methodName');
    }
  }

  $core.Map<$core.String, $core.dynamic> get $json =>
      AnnouncementServiceBase$json;
  $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>>
      get $messageJson => AnnouncementServiceBase$messageJson;
}
