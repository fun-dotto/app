//
//  Generated code. Do not modify.
//  source: app/v1/course_registration.proto
//

import "package:connectrpc/connect.dart" as connect;
import "course_registration.pb.dart" as appv1course_registration;
import "course_registration.connect.spec.dart" as specs;

/// ログイン中のユーザーの履修情報を管理する。
extension type CourseRegistrationServiceClient (connect.Transport _transport) {
  /// 履修情報の一覧を取得する。
  Future<appv1course_registration.ListCourseRegistrationsResponse> listCourseRegistrations(
    appv1course_registration.ListCourseRegistrationsRequest input, {
    connect.Headers? headers,
    connect.AbortSignal? signal,
    Function(connect.Headers)? onHeader,
    Function(connect.Headers)? onTrailer,
  }) {
    return connect.Client(_transport).unary(
      specs.CourseRegistrationService.listCourseRegistrations,
      input,
      signal: signal,
      headers: headers,
      onHeader: onHeader,
      onTrailer: onTrailer,
    );
  }

  /// 履修情報を作成する。
  Future<appv1course_registration.CreateCourseRegistrationResponse> createCourseRegistration(
    appv1course_registration.CreateCourseRegistrationRequest input, {
    connect.Headers? headers,
    connect.AbortSignal? signal,
    Function(connect.Headers)? onHeader,
    Function(connect.Headers)? onTrailer,
  }) {
    return connect.Client(_transport).unary(
      specs.CourseRegistrationService.createCourseRegistration,
      input,
      signal: signal,
      headers: headers,
      onHeader: onHeader,
      onTrailer: onTrailer,
    );
  }

  /// 履修情報を削除する。ログイン中のユーザーの履修情報でない場合は PERMISSION_DENIED を返す。
  Future<appv1course_registration.DeleteCourseRegistrationResponse> deleteCourseRegistration(
    appv1course_registration.DeleteCourseRegistrationRequest input, {
    connect.Headers? headers,
    connect.AbortSignal? signal,
    Function(connect.Headers)? onHeader,
    Function(connect.Headers)? onTrailer,
  }) {
    return connect.Client(_transport).unary(
      specs.CourseRegistrationService.deleteCourseRegistration,
      input,
      signal: signal,
      headers: headers,
      onHeader: onHeader,
      onTrailer: onTrailer,
    );
  }
}
