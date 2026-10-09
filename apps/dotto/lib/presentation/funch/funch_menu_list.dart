import 'package:dotto/domain/entity/funch_daily_menu.dart';
import 'package:dotto/domain/entity/funch_menu_category.dart';
import 'package:dotto/l10n/app_localizations.dart';
import 'package:dotto/l10n/app_localizations_ja.dart';
import 'package:dotto/presentation/common/funch/funch_menu_card.dart';
import 'package:material_ui/material_ui.dart';

/// 選択中のカテゴリのメニュー一覧。
///
/// [dailyMenu] が null の場合は、その日のメニューがないことを表す。
final class FunchMenuList extends StatelessWidget {
  const new({required this.dailyMenu, required this.category, super.key});

  final FunchDailyMenu? dailyMenu;
  final FunchMenuCategory category;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context) ?? AppLocalizationsJa();
    final menus = dailyMenu?.getMenuByCategory(category) ?? const [];
    if (menus.isEmpty) {
      final hasMenu = dailyMenu?.menuItems.isNotEmpty ?? false;
      return Center(
        child: Text(hasMenu ? l10n.funchCategoryEmpty : l10n.funchEmpty),
      );
    }
    return ListView(children: [for (final menu in menus) MenuCard(menu)]);
  }
}
