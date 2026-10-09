import 'dart:async';

import 'package:dotto/application/open_course_link_use_case.dart';
import 'package:dotto/domain/entity/course_link_event.dart';
import 'package:dotto/domain/entity/flags.dart';
import 'package:dotto/domain/entity/personal_timetable_day.dart';
import 'package:dotto/domain/entity/timetable_period_style.dart';
import 'package:dotto/domain/service/timetable_date_service.dart';
import 'package:dotto/helper/datetime.dart';
import 'package:dotto/l10n/app_localizations.dart';
import 'package:dotto/l10n/app_localizations_ja.dart';
import 'package:dotto/presentation/common/is_authenticated.dart';
import 'package:dotto/presentation/common/use_flag.dart';
import 'package:dotto/presentation/common/user_preference_state.dart';
import 'package:dotto/presentation/common/user_state.dart';
import 'package:dotto/presentation/course/course_content.dart';
import 'package:dotto/presentation/course/course_resources_state.dart';
import 'package:dotto/presentation/course/course_state.dart';
import 'package:dotto/presentation/course/quick_button.dart';
import 'package:dotto/router/routes/course_routes.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';

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
    final isTimetableTimeVisible = switch (ref.watch(
      userPreferenceStateProvider,
    )) {
      AsyncData(value: final preference) =>
        preference.timetablePeriodStyle == TimetablePeriodStyle.numberAndTime,
      AsyncError() || AsyncLoading() => false,
    };

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

    Future<void> refresh() async {
      if (!isAuthenticated) {
        return;
      }
      await ref.read(courseStateProvider.notifier).refresh();
    }

    return CourseContent(
      breakingAnnouncement: breakingAnnouncement,
      onBreakingAnnouncementTap: (announcement) => unawaited(
        _launchQuickLink(
          context,
          url: announcement.url,
          label: announcement.title,
        ),
      ),
      onCustomizeTap: () =>
          unawaited(const CourseCustomizeRouteData().push<void>(context)),
      body: switch (state) {
        AsyncData(value: final days) => CourseTimetableBody(
          isAuthenticated: isAuthenticated,
          days: days,
          selectedDate: selectedDate.value,
          isTimetableTimeVisible: isTimetableTimeVisible,
          quickFeatures: quickFeatures,
          quickFiles: quickFiles,
          quickLinks: quickLinks,
          onRefresh: refresh,
          onDateSelected: (date) => selectedDate.value = date,
          onSubjectSelected: (subject) => unawaited(
            CourseSubjectSyllabusRouteData(id: subject.id).push<void>(context),
          ),
          onWeeklyTimetableTap: () async {
            await const CourseRegistrationRouteData().push<void>(context);
            if (!context.mounted) {
              return;
            }
            await ref.read(courseStateProvider.notifier).refresh();
          },
          onSignIn: () =>
              unawaited(ref.read(userStateProvider.notifier).signIn()),
        ),
        AsyncLoading() => CourseLoadingSkeleton(
          isAuthenticated: isAuthenticated,
          quickFeatures: quickFeatures,
          quickFiles: quickFiles,
          quickLinks: quickLinks,
        ),
        AsyncError() => RefreshIndicator(
          onRefresh: refresh,
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
