//
//  Generated code. Do not modify.
//  source: app/v1/makeup_class.proto
//

import "package:connectrpc/connect.dart" as connect;
import "makeup_class.pb.dart" as appv1makeup_class;

/// 補講を提供する。
abstract final class MakeupClassService {
  /// Fully-qualified name of the MakeupClassService service.
  static const name = 'app.v1.MakeupClassService';

  /// 補講の一覧を取得する。
  static const listMakeupClasses = connect.Spec(
    '/$name/ListMakeupClasses',
    connect.StreamType.unary,
    appv1makeup_class.ListMakeupClassesRequest.new,
    appv1makeup_class.ListMakeupClassesResponse.new,
  );
}
