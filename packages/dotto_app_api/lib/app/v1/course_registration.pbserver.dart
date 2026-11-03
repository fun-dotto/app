// This is a generated file - do not edit.
//
// Generated from app/v1/course_registration.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'course_registration.pb.dart' as $2;
import 'course_registration.pbjson.dart';

export 'course_registration.pb.dart';

abstract class CourseRegistrationServiceBase extends $pb.GeneratedService {
  $async.Future<$2.ListCourseRegistrationsResponse> listCourseRegistrations(
      $pb.ServerContext ctx, $2.ListCourseRegistrationsRequest request);
  $async.Future<$2.CreateCourseRegistrationResponse> createCourseRegistration(
      $pb.ServerContext ctx, $2.CreateCourseRegistrationRequest request);
  $async.Future<$2.DeleteCourseRegistrationResponse> deleteCourseRegistration(
      $pb.ServerContext ctx, $2.DeleteCourseRegistrationRequest request);

  $pb.GeneratedMessage createRequest($core.String methodName) {
    switch (methodName) {
      case 'ListCourseRegistrations':
        return $2.ListCourseRegistrationsRequest();
      case 'CreateCourseRegistration':
        return $2.CreateCourseRegistrationRequest();
      case 'DeleteCourseRegistration':
        return $2.DeleteCourseRegistrationRequest();
      default:
        throw $core.ArgumentError('Unknown method: $methodName');
    }
  }

  $async.Future<$pb.GeneratedMessage> handleCall($pb.ServerContext ctx,
      $core.String methodName, $pb.GeneratedMessage request) {
    switch (methodName) {
      case 'ListCourseRegistrations':
        return listCourseRegistrations(
            ctx, request as $2.ListCourseRegistrationsRequest);
      case 'CreateCourseRegistration':
        return createCourseRegistration(
            ctx, request as $2.CreateCourseRegistrationRequest);
      case 'DeleteCourseRegistration':
        return deleteCourseRegistration(
            ctx, request as $2.DeleteCourseRegistrationRequest);
      default:
        throw $core.ArgumentError('Unknown method: $methodName');
    }
  }

  $core.Map<$core.String, $core.dynamic> get $json =>
      CourseRegistrationServiceBase$json;
  $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>>
      get $messageJson => CourseRegistrationServiceBase$messageJson;
}
