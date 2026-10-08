import 'package:dotto/domain/entity/funch_menu.dart';
import 'package:dotto/domain/entity/funch_menu_category.dart';
import 'package:dotto/helper/date_formatter.dart';
import 'package:dotto/l10n/app_localizations.dart';
import 'package:dotto/l10n/app_localizations_ja.dart';
import 'package:dotto/presentation/common/error_view.dart';
import 'package:dotto/presentation/common/funch/funch_menu_card.dart';
import 'package:dotto/presentation/common/funch/funch_menus_state.dart';
import 'package:dotto/presentation/common/loading_view.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';

final class FunchScreen extends HookConsumerWidget {
  const new({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final now = DateTime.now();
    final date = useState(DateTime(now.year, now.month, now.day));
    final category = useState(FunchMenuCategory.set);
    final menus = ref.watch(funchMenusStateProvider());
    final l10n = AppLocalizations.of(context) ?? AppLocalizationsJa();
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.funchTitle),
        actions: [
          TextButton(
            onPressed: () async {
              final dates = switch (menus) {
                AsyncData(:final value) => value.keys.toList()..sort(),
                _ => <DateTime>[],
              };
              final selected = await showModalBottomSheet<DateTime>(
                context: context,
                builder: (context) => SafeArea(
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      for (final day in dates)
                        ListTile(
                          title: Text(DateFormatter.dateWithDayOfWeek(day)),
                          onTap: () => Navigator.of(context).pop(day),
                        ),
                    ],
                  ),
                ),
              );
              if (selected != null && context.mounted) date.value = selected;
            },
            child: Text(DateFormatter.dateWithDayOfWeek(date.value)),
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
                      selected: category.value == item,
                      onSelected: (_) => category.value = item,
                    ),
                  ),
              ],
            ),
          ),
          Text(l10n.funchNotice),
          Expanded(
            child: switch (menus) {
              AsyncData(:final value) => _MenuList(
                items: [
                  for (final item
                      in value[date.value]?.getMenuByCategory(category.value) ??
                          const <FunchMenu>[])
                    MenuCard(item),
                ],
                hasMenu: value[date.value]?.menuItems.isNotEmpty ?? false,
              ),
              AsyncError() => const ErrorView(),
              _ => const LoadingView(),
            },
          ),
        ],
      ),
    );
  }
}

final class _MenuList extends StatelessWidget {
  const new({required this.items, required this.hasMenu});
  final List<Widget> items;
  final bool hasMenu;
  @override
  Widget build(BuildContext context) => items.isEmpty
      ? Center(
          child: Text(
            hasMenu
                ? (AppLocalizations.of(context) ?? AppLocalizationsJa())
                      .funchCategoryEmpty
                : (AppLocalizations.of(context) ?? AppLocalizationsJa())
                      .funchEmpty,
          ),
        )
      : ListView(children: items);
}
