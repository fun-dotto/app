import 'package:dotto/domain/entity/funch_daily_menu.dart';
import 'package:dotto/domain/entity/funch_menu.dart';
import 'package:dotto/domain/entity/funch_menu_category.dart';
import 'package:dotto/domain/entity/funch_price.dart';
import 'package:dotto/presentation/funch/funch_content.dart';
import 'package:dotto/presentation/funch/funch_menu_list.dart';
import 'package:flutter/widgets.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

// 画像はネットワークから取得しないよう、空の URL とする (代替画像が表示される)。
const _dailyMenu = FunchDailyMenu(
  menuItems: [
    FunchMenu(
      id: '1',
      name: '日替わり定食',
      categoryId: 1,
      prices: FunchPrice(medium: 500, large: 600, small: 400),
      imageUrl: '',
      energy: 800,
    ),
    FunchMenu(
      id: '2',
      name: 'とても長い名前のメニューで省略表示されることを確認するためのダミー定食',
      categoryId: 7,
      prices: FunchPrice(medium: 550),
      imageUrl: '',
    ),
  ],
);

Widget _content({
  required FunchDailyMenu? dailyMenu,
  FunchMenuCategory category = FunchMenuCategory.set,
}) => FunchContent(
  date: DateTime(2026, 4, 13),
  category: category,
  onDateTap: () {},
  onCategorySelected: (_) {},
  body: FunchMenuList(dailyMenu: dailyMenu, category: category),
);

@widgetbook.UseCase(name: 'Default', type: FunchContent)
Widget funchContentDefault(BuildContext context) =>
    _content(dailyMenu: _dailyMenu);

@widgetbook.UseCase(name: 'Category empty', type: FunchContent)
Widget funchContentCategoryEmpty(BuildContext context) =>
    _content(dailyMenu: _dailyMenu, category: FunchMenuCategory.dessert);

@widgetbook.UseCase(name: 'No menu', type: FunchContent)
Widget funchContentNoMenu(BuildContext context) => _content(dailyMenu: null);
