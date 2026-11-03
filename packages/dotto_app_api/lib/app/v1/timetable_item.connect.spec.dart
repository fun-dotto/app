//
//  Generated code. Do not modify.
//  source: app/v1/timetable_item.proto
//

import "package:connectrpc/connect.dart" as connect;
import "timetable_item.pb.dart" as appv1timetable_item;

/// 時間割を提供する。
abstract final class TimetableItemService {
  /// Fully-qualified name of the TimetableItemService service.
  static const name = 'app.v1.TimetableItemService';

  /// 時間割の一覧を取得する。
  static const listTimetableItems = connect.Spec(
    '/$name/ListTimetableItems',
    connect.StreamType.unary,
    appv1timetable_item.ListTimetableItemsRequest.new,
    appv1timetable_item.ListTimetableItemsResponse.new,
  );
}
