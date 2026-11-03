//
//  Generated code. Do not modify.
//  source: app/v1/room_change.proto
//

import "package:connectrpc/connect.dart" as connect;
import "room_change.pb.dart" as appv1room_change;

/// 教室変更を提供する。
abstract final class RoomChangeService {
  /// Fully-qualified name of the RoomChangeService service.
  static const name = 'app.v1.RoomChangeService';

  /// 教室変更の一覧を取得する。
  static const listRoomChanges = connect.Spec(
    '/$name/ListRoomChanges',
    connect.StreamType.unary,
    appv1room_change.ListRoomChangesRequest.new,
    appv1room_change.ListRoomChangesResponse.new,
  );
}
