import 'dart:async';

import 'package:dotto/l10n/app_localizations.dart';
import 'package:dotto/l10n/app_localizations_ja.dart';
import 'package:dotto/presentation/common/user_preference_state.dart';
import 'package:dotto/presentation/course/course_customize_content.dart';
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
        AsyncData(value: final preference) => CourseCustomizeContent(
          timetablePeriodStyle: preference.timetablePeriodStyle,
          onTimetablePeriodStyleChanged: (style) => unawaited(
            ref
                .read(userPreferenceStateProvider.notifier)
                .setTimetablePeriodStyle(style),
          ),
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
