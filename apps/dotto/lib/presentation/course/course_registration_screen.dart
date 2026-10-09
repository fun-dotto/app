import 'package:dotto/domain/entity/day_of_week.dart';
import 'package:dotto/domain/entity/period.dart';
import 'package:dotto/domain/entity/timetable_item.dart';
import 'package:dotto/domain/entity/timetable_semester.dart';
import 'package:dotto/l10n/app_localizations.dart';
import 'package:dotto/l10n/app_localizations_ja.dart';
import 'package:dotto/presentation/common/use_tab_controller.dart';
import 'package:dotto/presentation/course/course_registration_state.dart';
import 'package:dotto/presentation/course/select_course_screen.dart';
import 'package:dotto_design_system/style/semantic_color.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

final class CourseRegistrationScreen extends HookConsumerWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(courseRegistrationStateProvider);
    final tabController = useTabController(
      initialLength: TimetableSemester.values.length,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(
          (AppLocalizations.of(context) ?? AppLocalizationsJa())
              .courseRegistration,
        ),
        bottom: TabBar(
          dividerColor: SemanticColor.light.backgroundPrimary.withValues(
            alpha: 0,
          ),
          controller: tabController,
          tabs: TimetableSemester.values
              .map((e) => Tab(text: e.label))
              .toList(),
        ),
      ),
      body: switch (state) {
        AsyncData(value: final timetableItemsBySemester) => TabBarView(
          controller: tabController,
          children: TimetableSemester.values
              .map(
                (e) => _PersonalWeeklyTimetable(
                  this,
                  e,
                  timetableItemsBySemester[e] ?? const <TimetableItem>[],
                ),
              )
              .toList(),
        ),
        AsyncLoading() => _CourseRegistrationSkeleton(this),
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

final class _CourseRegistrationSkeleton extends StatelessWidget {
  const new(this.owner);
  final CourseRegistrationScreen owner;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Table(
          columnWidths: {
            for (final e in Period.values) e.number: const FlexColumnWidth(),
          },
          children: <TableRow>[
            TableRow(
              children: DayOfWeek.weekdays
                  .map(
                    (e) => TableCell(
                      child: Center(
                        child: Text(
                          e.label,
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
            ...Period.values.map(
              (_) => TableRow(
                children: DayOfWeek.weekdays
                    .map((_) => _PersonalWeeklyTimetableCellSkeleton(owner))
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

final class _SkeletonBox extends StatelessWidget {
  const new(this.owner, {required this.height, this.width, this.radius = 8});
  final CourseRegistrationScreen owner;
  final double height;
  final double? width;
  final double radius;
  @override
  Widget build(BuildContext context) {
    return Shimmer(
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: SemanticColor.light.backgroundTertiary,
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
    );
  }
}

final class _PersonalWeeklyTimetableCellSkeleton extends StatelessWidget {
  const new(this.owner);
  final CourseRegistrationScreen owner;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(2),
      height: 100,
      decoration: BoxDecoration(
        color: SemanticColor.light.backgroundPrimary,
        borderRadius: const BorderRadius.all(Radius.circular(4)),
      ),
      padding: const EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _SkeletonBox(owner, height: 14, width: 56, radius: 4),
          const SizedBox(height: 8),
          _SkeletonBox(owner, height: 12, width: 40, radius: 4),
        ],
      ),
    );
  }
}

final class _PersonalWeeklyTimetable extends HookConsumerWidget {
  const new(this.owner, this.semester, this.timetableItems);
  final CourseRegistrationScreen owner;
  final TimetableSemester semester;
  final List<TimetableItem> timetableItems;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return RefreshIndicator(
      onRefresh: () =>
          ref.read(courseRegistrationStateProvider.notifier).refresh(),
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Table(
            columnWidths: {
              for (final e in Period.values) e.number: const FlexColumnWidth(),
            },
            children: <TableRow>[
              TableRow(
                children: DayOfWeek.weekdays
                    .map(
                      (e) => TableCell(
                        child: Center(
                          child: Text(
                            e.label,
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
              ...Period.values.map(
                (period) => TableRow(
                  children: DayOfWeek.weekdays.map((dayOfWeek) {
                    final filteredTimetableItems = timetableItems
                        .where(
                          (item) =>
                              item.slot?.dayOfWeek == dayOfWeek &&
                              item.slot?.period == period,
                        )
                        .toList();
                    final filteredRegisteredTimetableItems =
                        filteredTimetableItems
                            .where((item) => item.isAddedToTimetable ?? false)
                            .toList();
                    return _PersonalWeeklyTimetablecell(
                      owner,
                      filteredRegisteredTimetableItems,
                      onTap: () async {
                        await showModalBottomSheet<void>(
                          context: context,
                          isScrollControlled: true,
                          useSafeArea: true,
                          builder: (_) => SelectCourseScreen(
                            semester,
                            dayOfWeek,
                            period,
                            filteredTimetableItems,
                            onChanged: () async {
                              await ref
                                  .read(
                                    courseRegistrationStateProvider.notifier,
                                  )
                                  .refresh();
                            },
                          ),
                        );
                      },
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

final class _PersonalWeeklyTimetablecell extends StatelessWidget {
  const new(this.owner, this.registeredTimetableItems, {required this.onTap});
  final CourseRegistrationScreen owner;
  final List<TimetableItem> registeredTimetableItems;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(2),
        height: 100,
        child: registeredTimetableItems.isNotEmpty
            ? Column(
                children: registeredTimetableItems
                    .map(
                      (item) => Expanded(
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: SemanticColor.light.borderPrimary,
                            ),
                            color: SemanticColor.light.backgroundTertiary,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(4),
                            ),
                          ),
                          padding: const EdgeInsets.all(2),
                          child: Text(
                            item.subject.name,
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                        ),
                      ),
                    )
                    .toList(),
              )
            : Container(
                decoration: BoxDecoration(
                  color: SemanticColor.light.backgroundPrimary,
                  borderRadius: const BorderRadius.all(Radius.circular(4)),
                ),
                child: Center(
                  child: Icon(
                    Icons.add,
                    color: SemanticColor.light.borderPrimary,
                  ),
                ),
              ),
      ),
    );
  }
}
