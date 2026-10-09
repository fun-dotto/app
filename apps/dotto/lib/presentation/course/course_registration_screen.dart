import 'dart:async';

import 'package:dotto/l10n/app_localizations.dart';
import 'package:dotto/l10n/app_localizations_ja.dart';
import 'package:dotto/presentation/course/course_registration_content.dart';
import 'package:dotto/presentation/course/course_registration_state.dart';
import 'package:dotto/presentation/course/select_course_screen.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';

final class CourseRegistrationScreen extends HookConsumerWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(courseRegistrationStateProvider);
    Future<void> refresh() =>
        ref.read(courseRegistrationStateProvider.notifier).refresh();

    return CourseRegistrationContent(
      body: switch (state) {
        AsyncData(value: final timetableItemsBySemester) =>
          CourseRegistrationTabView(
            timetableItemsBySemester: timetableItemsBySemester,
            onRefresh: refresh,
            onSlotTap: (semester, dayOfWeek, period, items) => unawaited(
              showModalBottomSheet<void>(
                context: context,
                isScrollControlled: true,
                useSafeArea: true,
                builder: (_) => SelectCourseScreen(
                  semester,
                  dayOfWeek,
                  period,
                  items,
                  onChanged: refresh,
                ),
              ),
            ),
          ),
        AsyncLoading() => const CourseRegistrationSkeleton(),
        AsyncError() => Center(
          child: Text(
            (AppLocalizations.of(context) ?? AppLocalizationsJa())
                .courseFetchError,
          ),
        ),
      },
    );
  }
}
