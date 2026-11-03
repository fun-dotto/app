//
//  Generated code. Do not modify.
//  source: app/v1/cancelled_class.proto
//

import "package:connectrpc/connect.dart" as connect;
import "cancelled_class.pb.dart" as appv1cancelled_class;
import "cancelled_class.connect.spec.dart" as specs;

/// 休講を提供する。
extension type CancelledClassServiceClient (connect.Transport _transport) {
  /// 休講の一覧を取得する。
  Future<appv1cancelled_class.ListCancelledClassesResponse> listCancelledClasses(
    appv1cancelled_class.ListCancelledClassesRequest input, {
    connect.Headers? headers,
    connect.AbortSignal? signal,
    Function(connect.Headers)? onHeader,
    Function(connect.Headers)? onTrailer,
  }) {
    return connect.Client(_transport).unary(
      specs.CancelledClassService.listCancelledClasses,
      input,
      signal: signal,
      headers: headers,
      onHeader: onHeader,
      onTrailer: onTrailer,
    );
  }
}
