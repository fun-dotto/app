//
//  Generated code. Do not modify.
//  source: app/v1/cancelled_class.proto
//

import "package:connectrpc/connect.dart" as connect;
import "cancelled_class.pb.dart" as appv1cancelled_class;

/// 休講を提供する。
abstract final class CancelledClassService {
  /// Fully-qualified name of the CancelledClassService service.
  static const name = 'app.v1.CancelledClassService';

  /// 休講の一覧を取得する。
  static const listCancelledClasses = connect.Spec(
    '/$name/ListCancelledClasses',
    connect.StreamType.unary,
    appv1cancelled_class.ListCancelledClassesRequest.new,
    appv1cancelled_class.ListCancelledClassesResponse.new,
  );
}
