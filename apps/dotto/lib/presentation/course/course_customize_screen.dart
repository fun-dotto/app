import 'package:dotto/domain/entity/timetable_period_style.dart';
import 'package:dotto/l10n/app_localizations.dart';
import 'package:dotto/l10n/app_localizations_ja.dart';
import 'package:dotto/presentation/common/user_preference_state.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';

final class CourseCustomizeScreen extends HookConsumerWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userPreference = ref.watch(userPreferenceStateProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          (AppLocalizations.of(context) ?? AppLocalizationsJa())
              .courseCustomize,
        ),
      ),
      body: switch (userPreference) {
        AsyncData(value: final preference) => SwitchListTile(
          title: Text(
            (AppLocalizations.of(context) ?? AppLocalizationsJa())
                .courseShowTime,
          ),
          value:
              preference.timetablePeriodStyle ==
              TimetablePeriodStyle.numberAndTime,
          onChanged: (value) async {
            await ref
                .read(userPreferenceStateProvider.notifier)
                .setTimetablePeriodStyle(
                  value
                      ? TimetablePeriodStyle.numberAndTime
                      : TimetablePeriodStyle.numberOnly,
                );
          },
        ),
        AsyncError() => Center(
          child: Text(
            (AppLocalizations.of(context) ?? AppLocalizationsJa())
                .coursePreferenceError,
          ),
        ),
        AsyncLoading() => const Center(child: CircularProgressIndicator()),
      },
    );
  }
}
