//
//  Generated code. Do not modify.
//  source: app/v1/room_change.proto
//

import "package:connectrpc/connect.dart" as connect;
import "room_change.pb.dart" as appv1room_change;
import "room_change.connect.spec.dart" as specs;

/// 教室変更を提供する。
extension type RoomChangeServiceClient (connect.Transport _transport) {
  /// 教室変更の一覧を取得する。
  Future<appv1room_change.ListRoomChangesResponse> listRoomChanges(
    appv1room_change.ListRoomChangesRequest input, {
    connect.Headers? headers,
    connect.AbortSignal? signal,
    Function(connect.Headers)? onHeader,
    Function(connect.Headers)? onTrailer,
  }) {
    return connect.Client(_transport).unary(
      specs.RoomChangeService.listRoomChanges,
      input,
      signal: signal,
      headers: headers,
      onHeader: onHeader,
      onTrailer: onTrailer,
    );
  }
}
