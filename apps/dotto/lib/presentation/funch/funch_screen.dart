import 'package:dotto/domain/entity/funch_menu_category.dart';
import 'package:dotto/helper/date_formatter.dart';
import 'package:dotto/presentation/common/error_view.dart';
import 'package:dotto/presentation/common/funch/funch_menus_state.dart';
import 'package:dotto/presentation/common/loading_view.dart';
import 'package:dotto/presentation/funch/funch_content.dart';
import 'package:dotto/presentation/funch/funch_menu_list.dart';
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

    Future<void> selectDate() async {
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
                  title: Text(
                    DateFormatter.dateWithDayOfWeek(
                      day,
                      locale: Localizations.localeOf(context).toString(),
                    ),
                  ),
                  onTap: () => Navigator.of(context).pop(day),
                ),
            ],
          ),
        ),
      );
      if (selected != null && context.mounted) date.value = selected;
    }

    return FunchContent(
      date: date.value,
      category: category.value,
      onDateTap: selectDate,
      onCategorySelected: (value) => category.value = value,
      body: switch (menus) {
        AsyncData(:final value) => FunchMenuList(
          dailyMenu: value[date.value],
          category: category.value,
        ),
        AsyncError() => const ErrorView(),
        _ => const LoadingView(),
      },
    );
  }
}
