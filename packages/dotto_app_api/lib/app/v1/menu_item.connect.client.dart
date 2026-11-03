//
//  Generated code. Do not modify.
//  source: app/v1/menu_item.proto
//

import "package:connectrpc/connect.dart" as connect;
import "menu_item.pb.dart" as appv1menu_item;
import "menu_item.connect.spec.dart" as specs;

/// 学食のメニューを提供する。
extension type MenuItemServiceClient (connect.Transport _transport) {
  /// メニューの一覧を取得する。
  Future<appv1menu_item.ListMenuItemsResponse> listMenuItems(
    appv1menu_item.ListMenuItemsRequest input, {
    connect.Headers? headers,
    connect.AbortSignal? signal,
    Function(connect.Headers)? onHeader,
    Function(connect.Headers)? onTrailer,
  }) {
    return connect.Client(_transport).unary(
      specs.MenuItemService.listMenuItems,
      input,
      signal: signal,
      headers: headers,
      onHeader: onHeader,
      onTrailer: onTrailer,
    );
  }
}
