//
//  Generated code. Do not modify.
//  source: app/v1/course_registration.proto
//

import "package:connectrpc/connect.dart" as connect;
import "course_registration.pb.dart" as appv1course_registration;

/// ログイン中のユーザーの履修情報を管理する。
abstract final class CourseRegistrationService {
  /// Fully-qualified name of the CourseRegistrationService service.
  static const name = 'app.v1.CourseRegistrationService';

  /// 履修情報の一覧を取得する。
  static const listCourseRegistrations = connect.Spec(
    '/$name/ListCourseRegistrations',
    connect.StreamType.unary,
    appv1course_registration.ListCourseRegistrationsRequest.new,
    appv1course_registration.ListCourseRegistrationsResponse.new,
  );

  /// 履修情報を作成する。
  static const createCourseRegistration = connect.Spec(
    '/$name/CreateCourseRegistration',
    connect.StreamType.unary,
    appv1course_registration.CreateCourseRegistrationRequest.new,
    appv1course_registration.CreateCourseRegistrationResponse.new,
  );

  /// 履修情報を削除する。ログイン中のユーザーの履修情報でない場合は PERMISSION_DENIED を返す。
  static const deleteCourseRegistration = connect.Spec(
    '/$name/DeleteCourseRegistration',
    connect.StreamType.unary,
    appv1course_registration.DeleteCourseRegistrationRequest.new,
    appv1course_registration.DeleteCourseRegistrationResponse.new,
  );
}
