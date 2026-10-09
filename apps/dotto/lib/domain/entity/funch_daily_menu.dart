import 'package:dotto/domain/entity/funch_menu.dart';
import 'package:dotto/domain/entity/funch_menu_category.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'funch_daily_menu.freezed.dart';

@Freezed(makeCollectionsUnmodifiable: true)
abstract class FunchDailyMenu with _$FunchDailyMenu {
  const factory({required List<FunchMenu> menuItems}) = _FunchDailyMenu;
  const new _();
  List<FunchMenu> getMenuByCategory(FunchMenuCategory category) =>
      List.unmodifiable(
        menuItems.where(
          (menu) => category.categoryIds.contains(menu.categoryId),
        ),
      );
}
