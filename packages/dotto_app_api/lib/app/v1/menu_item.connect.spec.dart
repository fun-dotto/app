//
//  Generated code. Do not modify.
//  source: app/v1/menu_item.proto
//

import "package:connectrpc/connect.dart" as connect;
import "menu_item.pb.dart" as appv1menu_item;

/// 学食のメニューを提供する。
abstract final class MenuItemService {
  /// Fully-qualified name of the MenuItemService service.
  static const name = 'app.v1.MenuItemService';

  /// メニューの一覧を取得する。
  static const listMenuItems = connect.Spec(
    '/$name/ListMenuItems',
    connect.StreamType.unary,
    appv1menu_item.ListMenuItemsRequest.new,
    appv1menu_item.ListMenuItemsResponse.new,
  );
}
