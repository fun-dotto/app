import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotto/domain/entity/funch_menu.dart';
import 'package:dotto/helper/date_formatter.dart';
import 'package:dotto/l10n/app_localizations.dart';
import 'package:dotto/l10n/app_localizations_ja.dart';
import 'package:dotto/presentation/common/error_view.dart';
import 'package:dotto/presentation/common/funch/funch_menu_card.dart';
import 'package:dotto/presentation/common/funch/funch_menus_state.dart';
import 'package:dotto/presentation/common/loading_view.dart';
import 'package:dotto/router/routes/funch_routes.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';

/// ホームと学食画面で共有する本日の献立カード。
final class FunchMyPageCard extends HookConsumerWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final menus = ref.watch(funchMenusStateProvider(isTodayOnly: true));
    final index = useState(0);
    final l10n = AppLocalizations.of(context) ?? AppLocalizationsJa();
    return InkWell(
      onTap: () async {
        await const FunchRouteData().push<void>(context);
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(l10n.funchToday(DateFormatter.dateWithoutYear(today))),
              switch (menus) {
                AsyncData(:final value) => _TodayMenus(
                  items: value[today]?.menuItems ?? [],
                  selectedIndex: index.value,
                  onChanged: (value) => index.value = value,
                ),
                AsyncError() => const ErrorView(),
                _ => const SizedBox(height: 240, child: LoadingView()),
              },
              Text(l10n.funchNotice),
            ],
          ),
        ),
      ),
    );
  }
}

final class _TodayMenus extends StatelessWidget {
  const new({
    required this.items,
    required this.selectedIndex,
    required this.onChanged,
  });
  final List<FunchMenu> items;
  final int selectedIndex;
  final ValueChanged<int> onChanged;
  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return Text(
        (AppLocalizations.of(context) ?? AppLocalizationsJa()).funchEmpty,
      );
    }
    return Column(
      children: [
        CarouselSlider(
          items: [for (final item in items) MenuCard(item)],
          options: CarouselOptions(
            height: 300,
            autoPlay: true,
            viewportFraction: 1,
            onPageChanged: (index, _) => onChanged(index),
          ),
        ),
        Text('${selectedIndex + 1} / ${items.length}'),
      ],
    );
  }
}
