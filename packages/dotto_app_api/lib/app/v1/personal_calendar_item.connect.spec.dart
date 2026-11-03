//
//  Generated code. Do not modify.
//  source: app/v1/personal_calendar_item.proto
//

import "package:connectrpc/connect.dart" as connect;
import "personal_calendar_item.pb.dart" as appv1personal_calendar_item;

/// ログイン中のユーザーの個人カレンダーを提供する。
abstract final class PersonalCalendarItemService {
  /// Fully-qualified name of the PersonalCalendarItemService service.
  static const name = 'app.v1.PersonalCalendarItemService';

  /// 個人カレンダーアイテムの一覧を取得する。時間割、履修情報、休講・補講、振替授業日情報から構築する。
  static const listPersonalCalendarItems = connect.Spec(
    '/$name/ListPersonalCalendarItems',
    connect.StreamType.unary,
    appv1personal_calendar_item.ListPersonalCalendarItemsRequest.new,
    appv1personal_calendar_item.ListPersonalCalendarItemsResponse.new,
  );
}
