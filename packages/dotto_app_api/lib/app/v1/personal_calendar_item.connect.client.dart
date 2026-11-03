//
//  Generated code. Do not modify.
//  source: app/v1/personal_calendar_item.proto
//

import "package:connectrpc/connect.dart" as connect;
import "personal_calendar_item.pb.dart" as appv1personal_calendar_item;
import "personal_calendar_item.connect.spec.dart" as specs;

/// ログイン中のユーザーの個人カレンダーを提供する。
extension type PersonalCalendarItemServiceClient (connect.Transport _transport) {
  /// 個人カレンダーアイテムの一覧を取得する。時間割、履修情報、休講・補講、振替授業日情報から構築する。
  Future<appv1personal_calendar_item.ListPersonalCalendarItemsResponse> listPersonalCalendarItems(
    appv1personal_calendar_item.ListPersonalCalendarItemsRequest input, {
    connect.Headers? headers,
    connect.AbortSignal? signal,
    Function(connect.Headers)? onHeader,
    Function(connect.Headers)? onTrailer,
  }) {
    return connect.Client(_transport).unary(
      specs.PersonalCalendarItemService.listPersonalCalendarItems,
      input,
      signal: signal,
      headers: headers,
      onHeader: onHeader,
      onTrailer: onTrailer,
    );
  }
}
