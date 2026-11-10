import 'package:dotto/domain/entity/timetable_period_style.dart';
import 'package:dotto/presentation/common/use_localization.dart';
import 'package:dotto/presentation/common/user_preference_state.dart';
import 'package:dotto_design_system/component/dotto_app_bar.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';

final class CourseCustomizeScreen extends HookConsumerWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = useLocalization();
    final userPreference = ref.watch(userPreferenceStateProvider);

    return Scaffold(
      appBar: DottoAppBar(title: Text(l10n.courseCustomize)),
      body: switch (userPreference) {
        AsyncData(value: final preference) => SwitchListTile(
          title: Text(l10n.courseShowTime),
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
        AsyncError() => Center(child: Text(l10n.coursePreferenceError)),
        AsyncLoading() => const Center(child: CircularProgressIndicator()),
      },
    );
  }
}
