//
//  Generated code. Do not modify.
//  source: app/v1/makeup_class.proto
//

import "package:connectrpc/connect.dart" as connect;
import "makeup_class.pb.dart" as appv1makeup_class;
import "makeup_class.connect.spec.dart" as specs;

/// 補講を提供する。
extension type MakeupClassServiceClient (connect.Transport _transport) {
  /// 補講の一覧を取得する。
  Future<appv1makeup_class.ListMakeupClassesResponse> listMakeupClasses(
    appv1makeup_class.ListMakeupClassesRequest input, {
    connect.Headers? headers,
    connect.AbortSignal? signal,
    Function(connect.Headers)? onHeader,
    Function(connect.Headers)? onTrailer,
  }) {
    return connect.Client(_transport).unary(
      specs.MakeupClassService.listMakeupClasses,
      input,
      signal: signal,
      headers: headers,
      onHeader: onHeader,
      onTrailer: onTrailer,
    );
  }
}
