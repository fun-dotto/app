import 'package:dotto/domain/entity/day_of_week.dart';
import 'package:dotto/domain/entity/period.dart';
import 'package:dotto/domain/entity/timetable_item.dart';
import 'package:dotto/domain/entity/timetable_semester.dart';
import 'package:dotto/l10n/app_localizations.dart';
import 'package:dotto/l10n/app_localizations_ja.dart';
import 'package:dotto_design_system/style/semantic_color.dart';
import 'package:material_ui/material_ui.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

/// 履修登録画面の枠組み。
///
/// 学期ごとのタブの中身は [body] で受け取り、[CourseRegistrationTabView] などを渡す。
final class CourseRegistrationContent extends StatelessWidget {
  const new({required this.body, super.key});

  final Widget body;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: TimetableSemester.values.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            (AppLocalizations.of(context) ?? AppLocalizationsJa())
                .courseRegistration,
          ),
          bottom: TabBar(
            dividerColor: SemanticColor.light.backgroundPrimary.withValues(
              alpha: 0,
            ),
            tabs: TimetableSemester.values
                .map((e) => Tab(text: e.label))
                .toList(),
          ),
        ),
        body: body,
      ),
    );
  }
}

/// 学期ごとの時間割で、登録済みの科目を表示する。
final class CourseRegistrationTabView extends StatelessWidget {
  const new({
    required this.timetableItemsBySemester,
    required this.onRefresh,
    required this.onSlotTap,
    super.key,
  });

  final Map<TimetableSemester, List<TimetableItem>> timetableItemsBySemester;
  final RefreshCallback onRefresh;

  /// コマがタップされたときに呼ばれる。引数の items はそのコマで履修できる科目。
  final void Function(
    TimetableSemester semester,
    DayOfWeek dayOfWeek,
    Period period,
    List<TimetableItem> items,
  )
  onSlotTap;

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      children: [
        for (final semester in TimetableSemester.values)
          _PersonalWeeklyTimetable(
            timetableItems:
                timetableItemsBySemester[semester] ?? const <TimetableItem>[],
            onRefresh: onRefresh,
            onSlotTap: (dayOfWeek, period, items) =>
                onSlotTap(semester, dayOfWeek, period, items),
          ),
      ],
    );
  }
}

/// 読み込み中のプレースホルダー。
final class CourseRegistrationSkeleton extends StatelessWidget {
  const new({super.key});

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
                    .map((_) => const _PersonalWeeklyTimetableCellSkeleton())
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
  const new({required this.height, this.width, this.radius = 8});
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
  const new();

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
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _SkeletonBox(height: 14, width: 56, radius: 4),
          SizedBox(height: 8),
          _SkeletonBox(height: 12, width: 40, radius: 4),
        ],
      ),
    );
  }
}

final class _PersonalWeeklyTimetable extends StatelessWidget {
  const new({
    required this.timetableItems,
    required this.onRefresh,
    required this.onSlotTap,
  });
  final List<TimetableItem> timetableItems;
  final RefreshCallback onRefresh;
  final void Function(
    DayOfWeek dayOfWeek,
    Period period,
    List<TimetableItem> items,
  )
  onSlotTap;
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
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
                      filteredRegisteredTimetableItems,
                      onTap: () =>
                          onSlotTap(dayOfWeek, period, filteredTimetableItems),
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
  const new(this.registeredTimetableItems, {required this.onTap});
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
