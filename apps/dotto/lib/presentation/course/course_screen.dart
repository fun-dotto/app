import 'dart:async';

import 'package:dotto/application/open_course_link_use_case.dart';
import 'package:dotto/domain/entity/breaking_announcement.dart';
import 'package:dotto/domain/entity/course_link_event.dart';
import 'package:dotto/domain/entity/personal_timetable_day.dart';
import 'package:dotto/domain/service/timetable_date_service.dart';
import 'package:dotto/foundation/flag/flags.dart';
import 'package:dotto/helper/datetime.dart';
import 'package:dotto/l10n/app_localizations.dart';
import 'package:dotto/l10n/app_localizations_ja.dart';
import 'package:dotto/presentation/common/is_authenticated.dart';
import 'package:dotto/presentation/common/use_flag.dart';
import 'package:dotto/presentation/common/user_state.dart';
import 'package:dotto/presentation/course/course_resources_state.dart';
import 'package:dotto/presentation/course/course_state.dart';
import 'package:dotto/presentation/course/personal_timetable_calendar_view.dart';
import 'package:dotto/presentation/course/quick_button.dart';
import 'package:dotto/router/routes/course_routes.dart';
import 'package:dotto_design_system/component/button.dart';
import 'package:dotto_design_system/style/semantic_color.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

final class CourseScreen extends HookConsumerWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final resources = ref.watch(courseResourcesStateProvider);
    final breakingAnnouncement = resources.breakingAnnouncement;
    final dottoWebUrl = resources.dottoWebUrl;
    final macSupportDeskUrl = resources.macSupportDeskUrl;
    final opinionBoxUrl = resources.opinionBoxUrl;
    final isFunchEnabled = useFlag(Flags.funch);
    final isWebEnabled = useFlag(Flags.web);
    final isOpinionBoxEnabled = useFlag(Flags.opinionBox);
    final isAuthenticated = ref.watch(isAuthenticatedProvider);
    final state = isAuthenticated
        ? ref.watch(courseStateProvider)
        : const AsyncData(<PersonalTimetableDay>[]);
    final selectedDate = useState<DateTime?>(null);

    final quickFeatures = [
      if (isFunchEnabled)
        QuickButton(
          label: (AppLocalizations.of(context) ?? AppLocalizationsJa())
              .courseSearch,
          iconUrl: null,
          fallbackIcon: Icons.search,
          onPressed: () => const CourseSubjectsRouteData().push<void>(context),
        ),
      if (isAuthenticated)
        QuickButton(
          label: (AppLocalizations.of(context) ?? AppLocalizationsJa())
              .courseNotices,
          iconUrl: null,
          fallbackIcon: Icons.cached,
          onPressed: () =>
              const CourseNoticeCancellationsRouteData().push<void>(context),
        ),
    ];

    final academicYear = DateTimeUtility.academicYear(DateTime.now());
    final quickFiles = [
      QuickButton(
        label: (AppLocalizations.of(context) ?? AppLocalizationsJa())
            .courseAcademicCalendar,
        iconUrl: null,
        fallbackIcon: Icons.event_note,
        onPressed: () =>
            CourseCalendarRouteData(year: academicYear).push<void>(context),
      ),
      QuickButton(
        label: (AppLocalizations.of(context) ?? AppLocalizationsJa())
            .courseSpringTimetable,
        iconUrl: null,
        fallbackIcon: Icons.calendar_view_month,
        onPressed: () =>
            CourseSpringTimetableRouteData(year: academicYear)
                .push<void>(context),
      ),
      QuickButton(
        label: (AppLocalizations.of(context) ?? AppLocalizationsJa())
            .courseFallTimetable,
        iconUrl: null,
        fallbackIcon: Icons.calendar_view_month,
        onPressed: () =>
            CourseFallTimetableRouteData(year: academicYear)
                .push<void>(context),
      ),
    ];

    final quickLinks = [
      QuickButton(
        label:
            (AppLocalizations.of(context) ?? AppLocalizationsJa()).courseHope,
        iconUrl: resources.hopeIconUrl,
        fallbackIcon: Icons.language,
        onPressed: () => _launchQuickLink(
          context,
          url: resources.hopeUrl,
          label:
              (AppLocalizations.of(context) ?? AppLocalizationsJa()).courseHope,
        ),
      ),
      QuickButton(
        label: (AppLocalizations.of(context) ?? AppLocalizationsJa())
            .courseStudentPortal,
        iconUrl: resources.studentPortalIconUrl,
        fallbackIcon: Icons.language,
        onPressed: () => _launchQuickLink(
          context,
          url: resources.studentPortalUrl,
          label: (AppLocalizations.of(context) ?? AppLocalizationsJa())
              .courseStudentPortal,
        ),
      ),
      if (isAuthenticated && isWebEnabled)
        QuickButton(
          label: (AppLocalizations.of(context) ?? AppLocalizationsJa())
              .courseDottoWeb,
          iconUrl: '$dottoWebUrl/favicon.ico',
          fallbackIcon: Icons.language,
          onPressed: () async {
            await _launchQuickLink(
              context,
              url: dottoWebUrl,
              event: CourseLinkEvent.dottoWeb,
              label: (AppLocalizations.of(context) ?? AppLocalizationsJa())
                  .courseDottoWeb,
            );
          },
        ),
      if (isAuthenticated)
        QuickButton(
          label: (AppLocalizations.of(context) ?? AppLocalizationsJa())
              .courseMacSupport,
          iconUrl: null,
          fallbackIcon: Icons.laptop_mac,
          onPressed: () async {
            await _launchQuickLink(
              context,
              url: macSupportDeskUrl,
              event: CourseLinkEvent.macSupport,
              label: (AppLocalizations.of(context) ?? AppLocalizationsJa())
                  .courseMacSupport,
            );
          },
        ),
      if (isAuthenticated && isOpinionBoxEnabled)
        QuickButton(
          label: (AppLocalizations.of(context) ?? AppLocalizationsJa())
              .courseOpinionBox,
          iconUrl: null,
          fallbackIcon: Icons.forward_to_inbox_rounded,
          onPressed: () async {
            await _launchQuickLink(
              context,
              url: opinionBoxUrl,
              event: CourseLinkEvent.opinionBox,
              label: (AppLocalizations.of(context) ?? AppLocalizationsJa())
                  .courseOpinionBox,
            );
          },
        ),
    ];

    useEffect(() {
      final days = state.asData?.value;
      if (days == null || days.isEmpty) {
        return null;
      }
      if (selectedDate.value == null ||
          !days.any(
            (e) =>
                selectedDate.value is DateTime &&
                _isSameDate(e.date, selectedDate.value ?? e.date),
          )) {
        final initialDate = const TimetableDateService().initialDate(
          DateTime.now(),
        );
        final matchingEntry = days.where(
          (e) => _isSameDate(e.date, initialDate),
        );
        selectedDate.value = matchingEntry.isNotEmpty
            ? matchingEntry.first.date
            : days.first.date;
      }
      return null;
    }, [state]);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          (AppLocalizations.of(context) ?? AppLocalizationsJa()).courseTitle,
          style: Theme.of(context).textTheme.titleLarge
              ?.copyWith(color: SemanticColor.light.accentPrimary),
        ),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () =>
                const CourseCustomizeRouteData().push<void>(context),
            icon: const Icon(Icons.tune),
          ),
        ],
        bottom: switch (breakingAnnouncement) {
          final announcement? => _CourseAnnouncement(this, announcement),
          null => null,
        },
      ),
      body: switch (state) {
        AsyncData(value: final courseState) => LayoutBuilder(
          builder: (context, constraints) => RefreshIndicator(
            onRefresh: () async {
              if (!isAuthenticated) {
                return;
              }
              await ref.read(courseStateProvider.notifier).refresh();
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Column(
                    spacing: 16,
                    children: [
                      if (isAuthenticated)
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsetsGeometry.symmetric(
                                horizontal: 8,
                              ),
                              child: PersonalTimetableCalendarView(
                                personalTimetableDays: courseState,
                                selectedDate: selectedDate.value,
                                onDateSelected: (newDate) =>
                                    selectedDate.value = newDate,
                                onSubjectSelected: (subject) =>
                                    CourseSubjectSyllabusRouteData(
                                      id: subject.id,
                                    ).push<void>(context),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: .end,
                              children: [
                                DottoButton(
                                  onPressed: () async {
                                    await const CourseRegistrationRouteData()
                                        .push<void>(context);
                                    if (!context.mounted) {
                                      return;
                                    }
                                    await ref
                                        .read(courseStateProvider.notifier)
                                        .refresh();
                                  },
                                  type: DottoButtonType.text,
                                  child: Text(
                                    (AppLocalizations.of(context) ??
                                            AppLocalizationsJa())
                                        .courseWeeklyTimetable,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )
                      else
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 48,
                          ),
                          child: Center(
                            child: DottoButton(
                              onPressed: () async {
                                await ref
                                    .read(userStateProvider.notifier)
                                    .signIn();
                              },
                              child: Text(
                                (AppLocalizations.of(context) ??
                                        AppLocalizationsJa())
                                    .courseSignIn,
                              ),
                            ),
                          ),
                        ),
                      Padding(
                        padding: const EdgeInsetsGeometry.symmetric(
                          horizontal: 16,
                        ),
                        child: _ShortcutSections(
                          this,
                          isAuthenticated: isAuthenticated,
                          quickFeatures: quickFeatures,
                          quickFiles: quickFiles,
                          quickLinks: quickLinks,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        AsyncLoading() => _LoadingSkeleton(
          this,
          isAuthenticated: isAuthenticated,
          quickFeatures: quickFeatures,
          quickFiles: quickFiles,
          quickLinks: quickLinks,
        ),
        AsyncError() => RefreshIndicator(
          onRefresh: () async {
            if (!isAuthenticated) {
              return;
            }
            await ref.read(courseStateProvider.notifier).refresh();
          },
          child: ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            children: [
              SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.7,
                child: Center(
                  child: Text(
                    (AppLocalizations.of(context) ?? AppLocalizationsJa())
                        .courseFetchError,
                  ),
                ),
              ),
            ],
          ),
        ),
      },
    );
  }

  bool _isSameDate(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  Future<void> _launchQuickLink(
    BuildContext context, {
    required String url,
    required String label,
    CourseLinkEvent? event,
  }) async {
    final container = ProviderScope.containerOf(context, listen: false);
    final launched = await container.read(openCourseLinkUseCaseProvider)(
      url,
      event: event,
    );
    if (!context.mounted || launched) {
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          (AppLocalizations.of(context) ?? AppLocalizationsJa())
              .courseLinkError(label),
        ),
      ),
    );
  }
}

final class _LoadingSkeleton extends StatelessWidget {
  const new(
    this.owner, {
    required this.isAuthenticated,
    required this.quickFeatures,
    required this.quickFiles,
    required this.quickLinks,
  });
  final CourseScreen owner;
  final bool isAuthenticated;
  final List<QuickButton> quickFeatures;
  final List<QuickButton> quickFiles;
  final List<QuickButton> quickLinks;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => RefreshIndicator(
        onRefresh: () async {},
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: Column(
              children: [
                if (isAuthenticated)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: _CourseTimetableSkeleton(owner),
                  )
                else
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 48,
                    ),
                    child: Center(
                      child: DottoButton(
                        onPressed: null,
                        child: Text(
                          (AppLocalizations.of(context) ?? AppLocalizationsJa())
                              .courseSignIn,
                        ),
                      ),
                    ),
                  ),
                if (isAuthenticated)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      DottoButton(
                        onPressed: null,
                        type: DottoButtonType.text,
                        child: Text(
                          (AppLocalizations.of(context) ?? AppLocalizationsJa())
                              .courseWeeklyTimetable,
                        ),
                      ),
                    ],
                  ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: _ShortcutSections(
                    owner,
                    isAuthenticated: isAuthenticated,
                    quickFeatures: quickFeatures,
                    quickFiles: quickFiles,
                    quickLinks: quickLinks,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

final class _CourseTimetableSkeleton extends StatelessWidget {
  const new(this.owner);
  final CourseScreen owner;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              5,
              (_) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  children: [
                    _SkeletonBox(owner, height: 14, width: 28),
                    const SizedBox(height: 8),
                    _SkeletonCircle(owner, 48),
                  ],
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        ...List.generate(
          6,
          (index) => Padding(
            padding: EdgeInsets.only(top: index == 0 ? 0 : 8, right: 8),
            child: Row(
              children: [
                SizedBox(width: 28, child: Center(child: Text('${index + 1}'))),
                const SizedBox(width: 8),
                Expanded(child: _CourseTimetableCellSkeleton(owner)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

final class _SkeletonCircle extends StatelessWidget {
  const new(this.owner, this.size);
  final CourseScreen owner;
  final double size;
  @override
  Widget build(BuildContext context) {
    return Shimmer(
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: SemanticColor.light.backgroundTertiary,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}

final class _CourseTimetableCellSkeleton extends StatelessWidget {
  const new(this.owner);
  final CourseScreen owner;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52,
      decoration: BoxDecoration(
        color: SemanticColor.light.backgroundPrimary,
        borderRadius: const BorderRadius.all(Radius.circular(8)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _SkeletonBox(owner, height: 12, width: 96, radius: 4),
          const SizedBox(height: 8),
          _SkeletonBox(owner, height: 10, width: 48, radius: 4),
        ],
      ),
    );
  }
}

final class _SkeletonBox extends StatelessWidget {
  const new(this.owner, {required this.height, this.width, this.radius = 8});
  final CourseScreen owner;
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

final class _ShortcutSections extends StatelessWidget {
  const new(
    this.owner, {
    required this.isAuthenticated,
    required this.quickFeatures,
    required this.quickFiles,
    required this.quickLinks,
  });
  final CourseScreen owner;
  final bool isAuthenticated;
  final List<QuickButton> quickFeatures;
  final List<QuickButton> quickFiles;
  final List<QuickButton> quickLinks;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: SemanticColor.light.borderPrimary),
        borderRadius: BorderRadius.circular(16),
        color: SemanticColor.light.backgroundSecondary,
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 12,
          children: [
            _ShortcutSection(owner, quickButtons: quickFeatures),
            const Divider(height: 0),
            _ShortcutSection(owner, quickButtons: quickFiles),
            const Divider(height: 0),
            _ShortcutSection(owner, quickButtons: quickLinks),
          ],
        ),
      ),
    );
  }
}

final class _ShortcutSection extends StatelessWidget {
  const new(this.owner, {required this.quickButtons});
  final CourseScreen owner;
  final List<QuickButton> quickButtons;
  @override
  Widget build(BuildContext context) {
    if (quickButtons.isEmpty) {
      return const SizedBox.shrink();
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: quickButtons.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        mainAxisExtent: 64,
      ),
      itemBuilder: (context, index) => quickButtons[index],
    );
  }
}

final class _CourseAnnouncement extends StatelessWidget
    implements PreferredSizeWidget {
  const new(this.owner, this.announcement);
  final CourseScreen owner;
  final BreakingAnnouncement announcement;
  @override
  Size get preferredSize => const Size.fromHeight(32);
  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(32),
      child: Material(
        color: SemanticColor.light.accentPrimary.withValues(alpha: 0.75),
        child: InkWell(
          onTap: () => owner._launchQuickLink(
            context,
            url: announcement.url,
            label: announcement.title,
          ),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              announcement.title,
              style: Theme.of(context).textTheme.labelMedium
                  ?.copyWith(color: SemanticColor.light.labelTertiary),
              textAlign: .center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ),
    );
  }
}
