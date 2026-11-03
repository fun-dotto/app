//
//  Generated code. Do not modify.
//  source: app/v1/timetable_item.proto
//

import "package:connectrpc/connect.dart" as connect;
import "timetable_item.pb.dart" as appv1timetable_item;
import "timetable_item.connect.spec.dart" as specs;

/// 時間割を提供する。
extension type TimetableItemServiceClient (connect.Transport _transport) {
  /// 時間割の一覧を取得する。
  Future<appv1timetable_item.ListTimetableItemsResponse> listTimetableItems(
    appv1timetable_item.ListTimetableItemsRequest input, {
    connect.Headers? headers,
    connect.AbortSignal? signal,
    Function(connect.Headers)? onHeader,
    Function(connect.Headers)? onTrailer,
  }) {
    return connect.Client(_transport).unary(
      specs.TimetableItemService.listTimetableItems,
      input,
      signal: signal,
      headers: headers,
      onHeader: onHeader,
      onTrailer: onTrailer,
    );
  }
}
