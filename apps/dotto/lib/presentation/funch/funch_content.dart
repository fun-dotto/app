import 'package:dotto/domain/entity/funch_menu_category.dart';
import 'package:dotto/helper/date_formatter.dart';
import 'package:dotto/l10n/app_localizations.dart';
import 'package:dotto/l10n/app_localizations_ja.dart';
import 'package:material_ui/material_ui.dart';

/// 学食の 1 日分のメニューを、カテゴリで絞り込んで表示する。
final class FunchContent extends StatelessWidget {
  const new({
    required this.date,
    required this.category,
    required this.body,
    required this.onDateTap,
    required this.onCategorySelected,
    super.key,
  });

  final DateTime date;
  final FunchMenuCategory category;

  /// メニュー一覧の部分。読み込み中・エラーの表示は呼び出し側で差し替える。
  final Widget body;
  final VoidCallback onDateTap;
  final ValueChanged<FunchMenuCategory> onCategorySelected;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context) ?? AppLocalizationsJa();
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.funchTitle),
        actions: [
          TextButton(
            onPressed: onDateTap,
            child: Text(
              DateFormatter.dateWithDayOfWeek(
                date,
                locale: Localizations.localeOf(context).toString(),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                for (final item in FunchMenuCategory.values)
                  Padding(
                    padding: const EdgeInsets.all(4),
                    child: ChoiceChip(
                      label: Text(switch (item) {
                        FunchMenuCategory.set => l10n.funchSet,
                        FunchMenuCategory.donCurry => l10n.funchDonCurry,
                        FunchMenuCategory.noodle => l10n.funchNoodle,
                        FunchMenuCategory.sideDish => l10n.funchSideDish,
                        FunchMenuCategory.dessert => l10n.funchDessert,
                      }),
                      selected: category == item,
                      onSelected: (_) => onCategorySelected(item),
                    ),
                  ),
              ],
            ),
          ),
          Text(l10n.funchNotice),
          Expanded(child: body),
        ],
      ),
    );
  }
}
