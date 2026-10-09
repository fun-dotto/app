import 'dart:math' as math;

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotto/domain/entity/lecture_status.dart';
import 'package:dotto/domain/entity/period.dart';
import 'package:dotto/domain/entity/personal_timetable_day.dart';
import 'package:dotto/domain/entity/personal_timetable_item.dart';
import 'package:dotto/domain/entity/subject_summary.dart';
import 'package:dotto/domain/entity/timetable_period_style.dart';
import 'package:dotto/helper/date_formatter.dart';
import 'package:dotto/presentation/common/user_preference_state.dart';
import 'package:dotto_design_system/style/semantic_color.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';

final class PersonalTimetableCalendarView extends HookConsumerWidget {
  const new({
    required this.personalTimetableDays,
    required this.selectedDate,
    required this.onDateSelected,
    required this.onSubjectSelected,
    super.key,
  });

  final List<PersonalTimetableDay> personalTimetableDays;
  final DateTime? selectedDate;
  final void Function(DateTime) onDateSelected;
  final void Function(SubjectSummary) onSubjectSelected;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userPreference = ref.watch(userPreferenceStateProvider);
    final isTimetableTimeVisible = switch (userPreference) {
      AsyncData(value: final preference) =>
        preference.timetablePeriodStyle == TimetablePeriodStyle.numberAndTime,
      AsyncError() || AsyncLoading() => false,
    };
    final safeSelectedDate =
        selectedDate ??
        (personalTimetableDays.isNotEmpty
            ? personalTimetableDays.first.date
            : DateTime.now());
    final selectedDayIndex = personalTimetableDays.indexWhere(
      (day) => _isSameDate(day.date, safeSelectedDate),
    );
    final initialPage = selectedDayIndex >= 0 ? selectedDayIndex : 0;
    final currentPage = useState(initialPage);
    final pageController = usePageController(initialPage: initialPage);

    useEffect(() {
      if (personalTimetableDays.isEmpty) {
        return null;
      }
      final lastPageIndex = personalTimetableDays.length - 1;
      if (currentPage.value > lastPageIndex && pageController.hasClients) {
        currentPage.value = lastPageIndex;
        pageController.jumpToPage(lastPageIndex);
      }
      final targetPage = personalTimetableDays.indexWhere(
        (day) => _isSameDate(day.date, safeSelectedDate),
      );
      if (targetPage < 0 ||
          targetPage == currentPage.value ||
          !pageController.hasClients) {
        return null;
      }
      pageController
          .animateToPage(
            targetPage,
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeOutCubic,
          )
          .ignore();
      return null;
    }, [personalTimetableDays, safeSelectedDate, pageController]);

    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: _Calendar(
        this,
        days: personalTimetableDays,
        selectedDate: safeSelectedDate,
        currentPage: currentPage.value,
        onPageChanged: (newPage) => currentPage.value = newPage,
        pageController: pageController,
        onDateSelected: onDateSelected,
        isTimetableTimeVisible: isTimetableTimeVisible,
      ),
    );
  }

  double _dayTimetableHeight(PersonalTimetableDay day) {
    // ボタンの標準タップ領域に合わせ、時間割の高さを確保する。
    const itemButtonHeight = kMinInteractiveDimension;
    const itemSpacing = 8.0;
    const periodSpacing = 4.0;

    final totalRowHeight = Period.values
        .map((period) {
          final itemCount = day.items
              .where((item) => item.period == period)
              .length;
          final visibleItemCount = itemCount == 0 ? 1 : itemCount;
          return (visibleItemCount * itemButtonHeight) +
              ((visibleItemCount - 1) * itemSpacing);
        })
        .fold<double>(0, (sum, rowHeight) => sum + rowHeight);
    final rowGap = (Period.values.length - 1) * periodSpacing;
    return totalRowHeight + rowGap;
  }

  bool _isSameDate(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }
}

final class _Calendar extends StatelessWidget {
  const new(
    this.owner, {
    required this.days,
    required this.selectedDate,
    required this.currentPage,
    required this.onPageChanged,
    required this.pageController,
    required this.onDateSelected,
    required this.isTimetableTimeVisible,
  });
  final PersonalTimetableCalendarView owner;
  final List<PersonalTimetableDay> days;
  final DateTime selectedDate;
  final int currentPage;
  final void Function(int) onPageChanged;
  final PageController pageController;
  final void Function(DateTime) onDateSelected;
  final bool isTimetableTimeVisible;
  @override
  Widget build(BuildContext context) {
    // 5日ずつ週に分割
    final datePages = <List<DateTime>>[];
    for (var i = 0; i < days.length; i += 5) {
      final end = math.min(i + 5, days.length);
      datePages.add(days.sublist(i, end).map((e) => e.date).toList());
    }
    final clampedPage = days.isEmpty
        ? 0
        : math.max(0, math.min(currentPage, days.length - 1));
    final dateCarouselInitialPage = datePages.isEmpty
        ? 0
        : math.max(0, math.min(clampedPage ~/ 5, datePages.length - 1));
    final currentDay = days.isEmpty ? null : days[clampedPage];
    final displayWeekDates = datePages.isEmpty
        ? <DateTime>[]
        : datePages[dateCarouselInitialPage];
    final timetableHeight = currentDay == null
        ? 0.0
        : owner._dayTimetableHeight(currentDay);

    return Column(
      spacing: 8,
      children: [
        if (displayWeekDates.isNotEmpty)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 16,
            children: displayWeekDates
                .map(
                  (date) => SizedBox(
                    width: 48,
                    child: Center(
                      child: Text(
                        DateFormatter.dayOfWeek(date),
                        style: Theme.of(context).textTheme.labelMedium
                            ?.copyWith(color: SemanticColor.light.labelPrimary),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        CarouselSlider(
          key: ValueKey(dateCarouselInitialPage),
          items: datePages
              .map(
                (dates) => _DateButtons(
                  owner,
                  dates: dates,
                  selectedDate: selectedDate,
                  onDateSelected: onDateSelected,
                ),
              )
              .toList(),
          options: CarouselOptions(
            height: 48,
            viewportFraction: 1,
            enableInfiniteScroll: false,
            initialPage: dateCarouselInitialPage,
            onPageChanged: (index, _) {
              final pageDates = datePages[index];
              if (pageDates.isEmpty ||
                  pageDates.any(
                    (date) => owner._isSameDate(date, selectedDate),
                  )) {
                return;
              }
              // 前の週へ戻った場合は金曜日、進んだ場合は月曜日を選択
              final prevWeekIndex = dateCarouselInitialPage;
              onDateSelected(
                index < prevWeekIndex ? pageDates.last : pageDates.first,
              );
            },
          ),
        ),
        if (currentDay != null)
          AnimatedSize(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeInOutCubic,
            alignment: Alignment.topCenter,
            child: SizedBox(
              height: timetableHeight,
              child: PageView.builder(
                controller: pageController,
                itemCount: days.length,
                onPageChanged: (index) {
                  onPageChanged(index);
                  onDateSelected(days[index].date);
                },
                itemBuilder: (context, index) {
                  return _DayTimetable(
                    owner,
                    days[index],
                    isTimetableTimeVisible: isTimetableTimeVisible,
                  );
                },
              ),
            ),
          ),
      ],
    );
  }
}

final class _DateButtons extends StatelessWidget {
  const new(
    this.owner, {
    required this.dates,
    required this.selectedDate,
    required this.onDateSelected,
  });
  final PersonalTimetableCalendarView owner;
  final List<DateTime> dates;
  final DateTime selectedDate;
  final void Function(DateTime) onDateSelected;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 16,
      children: dates
          .map(
            (date) => _DateButton(
              owner,
              date: date,
              isSelected: owner._isSameDate(selectedDate, date),
              onPressed: () => onDateSelected(date),
            ),
          )
          .toList(),
    );
  }
}

final class _DateButton extends StatelessWidget {
  const new(
    this.owner, {
    required this.date,
    required this.isSelected,
    required this.onPressed,
  });
  final PersonalTimetableCalendarView owner;
  final DateTime date;
  final bool isSelected;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 48,
      height: 48,
      child: TextButton(
        style: TextButton.styleFrom(
          textStyle: Theme.of(context).textTheme.titleMedium,
          foregroundColor: isSelected
              ? SemanticColor.light.labelTertiary
              : SemanticColor.light.labelSecondary,
          backgroundColor: isSelected
              ? SemanticColor.light.accentPrimary
              : SemanticColor.light.backgroundSecondary,
          overlayColor: SemanticColor.light.accentPrimary,
          side: BorderSide(color: SemanticColor.light.borderPrimary),
          shape: const CircleBorder(),
          fixedSize: const Size(48, 48),
        ),
        onPressed: onPressed,
        child: Text(DateFormatter.dayOfMonth(date)),
      ),
    );
  }
}

final class _DayTimetable extends StatelessWidget {
  const new(
    this.owner,
    this.selectedDay, {
    required this.isTimetableTimeVisible,
  });
  final PersonalTimetableCalendarView owner;
  final PersonalTimetableDay? selectedDay;
  final bool isTimetableTimeVisible;
  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 4,
      children: Period.values
          .map(
            (period) => _PeriodRow(
              owner,
              period: period,
              items:
                  selectedDay?.items
                      .where((item) => item.period == period)
                      .toList() ??
                  const [],
              isTimetableTimeVisible: isTimetableTimeVisible,
            ),
          )
          .toList(),
    );
  }
}

final class _PeriodRow extends StatelessWidget {
  const new(
    this.owner, {
    required this.period,
    required this.items,
    required this.isTimetableTimeVisible,
  });
  final PersonalTimetableCalendarView owner;
  final Period period;
  final List<PersonalTimetableItem> items;
  final bool isTimetableTimeVisible;
  @override
  Widget build(BuildContext context) {
    final visibleItemCount = items.isEmpty ? 1 : items.length;
    final periodRowHeight =
        (visibleItemCount * kMinInteractiveDimension) +
        ((visibleItemCount - 1) * 8);

    return Row(
      spacing: 4,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: SizedBox(
            width: isTimetableTimeVisible ? 56 : 24,
            child: SizedBox(
              height: periodRowHeight,
              child: Row(
                mainAxisAlignment: isTimetableTimeVisible
                    ? MainAxisAlignment.spaceBetween
                    : MainAxisAlignment.center,
                children: [
                  Text(
                    period.number.toString(),
                    style: TextStyle(
                      fontSize: 20,
                      color: SemanticColor.light.accentPrimary,
                    ),
                  ),
                  if (isTimetableTimeVisible)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            DateFormatter.clockTime(
                              hour: period.startTime.hour,
                              minute: period.startTime.minute,
                            ),
                            textAlign: TextAlign.right,
                            style: Theme.of(context).textTheme.labelSmall
                                ?.copyWith(
                                  color: SemanticColor.light.accentPrimary,
                                ),
                          ),
                          Text(
                            '|',
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.labelSmall
                                ?.copyWith(
                                  color: SemanticColor.light.accentPrimary,
                                  fontSize: 4,
                                ),
                          ),
                          Text(
                            DateFormatter.clockTime(
                              hour: period.endTime.hour,
                              minute: period.endTime.minute,
                            ),
                            textAlign: TextAlign.right,
                            style: Theme.of(context).textTheme.labelSmall
                                ?.copyWith(
                                  color: SemanticColor.light.accentPrimary,
                                ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
        Expanded(
          child: Column(
            spacing: 8,
            children: items.isEmpty
                ? [_ItemButton(owner, null)]
                : items.map((item) => _ItemButton(owner, item)).toList(),
          ),
        ),
      ],
    );
  }
}

final class _ItemButton extends StatelessWidget {
  const new(this.owner, this.item);
  final PersonalTimetableCalendarView owner;
  final PersonalTimetableItem? item;
  @override
  Widget build(BuildContext context) {
    final item = this.item;
    return SizedBox(
      width: double.infinity,
      child: TextButton(
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          backgroundColor: switch (item?.lectureStatus) {
            LectureStatus.cancelled =>
              SemanticColor.light.accentError.withValues(alpha: 0.1),
            LectureStatus.madeUp =>
              SemanticColor.light.accentWarning.withValues(alpha: 0.1),
            LectureStatus.roomChanged =>
              SemanticColor.light.accentInfo.withValues(alpha: 0.1),
            LectureStatus.normal => SemanticColor.light.backgroundSecondary,
            null => SemanticColor.light.backgroundSecondary,
          },
          disabledBackgroundColor: SemanticColor.light.backgroundTertiary,
          overlayColor: SemanticColor.light.accentPrimary,
          side: BorderSide(color: SemanticColor.light.borderPrimary),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        onPressed: item == null
            ? null
            : () => owner.onSubjectSelected(item.subject),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          spacing: 8,
          children: [
            Expanded(
              child: Row(
                spacing: 8,
                children: [
                  Flexible(
                    child: Text(
                      item?.subject.name ?? '',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyLarge
                          ?.copyWith(color: SemanticColor.light.labelPrimary),
                    ),
                  ),
                  if (item != null)
                    switch (item.lectureStatus) {
                      LectureStatus.cancelled => Text(
                        '休講',
                        style: Theme.of(context).textTheme.labelMedium
                            ?.copyWith(color: SemanticColor.light.accentError),
                      ),
                      LectureStatus.madeUp => Text(
                        '補講',
                        style: Theme.of(context).textTheme.labelMedium
                            ?.copyWith(
                              color: SemanticColor.light.accentWarning,
                            ),
                      ),
                      LectureStatus.roomChanged => Text(
                        '教室変更',
                        style: Theme.of(context).textTheme.labelMedium
                            ?.copyWith(color: SemanticColor.light.accentInfo),
                      ),
                      LectureStatus.normal => const SizedBox.shrink(),
                    },
                ],
              ),
            ),
            if (item != null && item.roomName.trim().isNotEmpty)
              Text(
                item.roomName,
                style: Theme.of(context).textTheme.labelMedium
                    ?.copyWith(color: SemanticColor.light.labelSecondary),
              ),
          ],
        ),
      ),
    );
  }
}
