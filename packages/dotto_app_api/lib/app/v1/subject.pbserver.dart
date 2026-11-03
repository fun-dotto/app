// This is a generated file - do not edit.
//
// Generated from app/v1/subject.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'subject.pb.dart' as $2;
import 'subject.pbjson.dart';

export 'subject.pb.dart';

abstract class SubjectServiceBase extends $pb.GeneratedService {
  $async.Future<$2.ListSubjectsResponse> listSubjects(
      $pb.ServerContext ctx, $2.ListSubjectsRequest request);
  $async.Future<$2.GetSubjectResponse> getSubject(
      $pb.ServerContext ctx, $2.GetSubjectRequest request);

  $pb.GeneratedMessage createRequest($core.String methodName) {
    switch (methodName) {
      case 'ListSubjects':
        return $2.ListSubjectsRequest();
      case 'GetSubject':
        return $2.GetSubjectRequest();
      default:
        throw $core.ArgumentError('Unknown method: $methodName');
    }
  }

  $async.Future<$pb.GeneratedMessage> handleCall($pb.ServerContext ctx,
      $core.String methodName, $pb.GeneratedMessage request) {
    switch (methodName) {
      case 'ListSubjects':
        return listSubjects(ctx, request as $2.ListSubjectsRequest);
      case 'GetSubject':
        return getSubject(ctx, request as $2.GetSubjectRequest);
      default:
        throw $core.ArgumentError('Unknown method: $methodName');
    }
  }

  $core.Map<$core.String, $core.dynamic> get $json => SubjectServiceBase$json;
  $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>>
      get $messageJson => SubjectServiceBase$messageJson;
}
