import 'package:dotto/domain/entity/breaking_announcement.dart';
import 'package:dotto/domain/entity/personal_timetable_day.dart';
import 'package:dotto/domain/entity/subject_summary.dart';
import 'package:dotto/l10n/app_localizations.dart';
import 'package:dotto/l10n/app_localizations_ja.dart';
import 'package:dotto/presentation/course/personal_timetable_calendar_view.dart';
import 'package:dotto/presentation/course/quick_button.dart';
import 'package:dotto_design_system/component/button.dart';
import 'package:dotto_design_system/style/semantic_color.dart';
import 'package:material_ui/material_ui.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

/// 時間割タブの枠組み。
///
/// 本体は [body] で受け取り、[CourseTimetableBody] などを渡す。
final class CourseContent extends StatelessWidget {
  const new({
    required this.breakingAnnouncement,
    required this.onBreakingAnnouncementTap,
    required this.onCustomizeTap,
    required this.body,
    super.key,
  });

  /// 時間割の上部に表示する緊急のお知らせ。ない場合は `null`。
  final BreakingAnnouncement? breakingAnnouncement;
  final ValueChanged<BreakingAnnouncement> onBreakingAnnouncementTap;
  final VoidCallback onCustomizeTap;
  final Widget body;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          (AppLocalizations.of(context) ?? AppLocalizationsJa()).courseTitle,
          style: Theme.of(context).textTheme.titleLarge
              ?.copyWith(color: SemanticColor.light.accentPrimary),
        ),
        centerTitle: false,
        actions: [
          IconButton(onPressed: onCustomizeTap, icon: const Icon(Icons.tune)),
        ],
        bottom: switch (breakingAnnouncement) {
          final announcement? => _CourseAnnouncement(
            announcement: announcement,
            onTap: () => onBreakingAnnouncementTap(announcement),
          ),
          null => null,
        },
      ),
      body: body,
    );
  }
}

/// 時間割と各種ショートカット。
final class CourseTimetableBody extends StatelessWidget {
  const new({
    required this.isAuthenticated,
    required this.days,
    required this.selectedDate,
    required this.isTimetableTimeVisible,
    required this.quickFeatures,
    required this.quickFiles,
    required this.quickLinks,
    required this.onRefresh,
    required this.onDateSelected,
    required this.onSubjectSelected,
    required this.onWeeklyTimetableTap,
    required this.onSignIn,
    super.key,
  });

  /// 未ログインの場合は、時間割の代わりにログインボタンを表示する。
  final bool isAuthenticated;
  final List<PersonalTimetableDay> days;
  final DateTime? selectedDate;
  final bool isTimetableTimeVisible;
  final List<QuickButton> quickFeatures;
  final List<QuickButton> quickFiles;
  final List<QuickButton> quickLinks;
  final RefreshCallback onRefresh;
  final ValueChanged<DateTime> onDateSelected;
  final ValueChanged<SubjectSummary> onSubjectSelected;
  final VoidCallback onWeeklyTimetableTap;
  final VoidCallback onSignIn;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => RefreshIndicator(
        onRefresh: onRefresh,
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
                            personalTimetableDays: days,
                            selectedDate: selectedDate,
                            isTimetableTimeVisible: isTimetableTimeVisible,
                            onDateSelected: onDateSelected,
                            onSubjectSelected: onSubjectSelected,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: .end,
                          children: [
                            DottoButton(
                              onPressed: onWeeklyTimetableTap,
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
                          onPressed: onSignIn,
                          child: Text(
                            (AppLocalizations.of(context) ??
                                    AppLocalizationsJa())
                                .courseSignIn,
                          ),
                        ),
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsetsGeometry.symmetric(horizontal: 16),
                    child: _ShortcutSections(
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
    );
  }
}

/// 読み込み中のプレースホルダー。
final class CourseLoadingSkeleton extends StatelessWidget {
  const new({
    required this.isAuthenticated,
    required this.quickFeatures,
    required this.quickFiles,
    required this.quickLinks,
    super.key,
  });
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
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: _CourseTimetableSkeleton(),
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
  const new();

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
              (_) => const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  children: [
                    _SkeletonBox(height: 14, width: 28),
                    SizedBox(height: 8),
                    _SkeletonCircle(48),
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
                const Expanded(child: _CourseTimetableCellSkeleton()),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

final class _SkeletonCircle extends StatelessWidget {
  const new(this.size);
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
  const new();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52,
      decoration: BoxDecoration(
        color: SemanticColor.light.backgroundPrimary,
        borderRadius: const BorderRadius.all(Radius.circular(8)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _SkeletonBox(height: 12, width: 96, radius: 4),
          SizedBox(height: 8),
          _SkeletonBox(height: 10, width: 48, radius: 4),
        ],
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

final class _ShortcutSections extends StatelessWidget {
  const new({
    required this.isAuthenticated,
    required this.quickFeatures,
    required this.quickFiles,
    required this.quickLinks,
  });
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
            _ShortcutSection(quickButtons: quickFeatures),
            const Divider(height: 0),
            _ShortcutSection(quickButtons: quickFiles),
            const Divider(height: 0),
            _ShortcutSection(quickButtons: quickLinks),
          ],
        ),
      ),
    );
  }
}

final class _ShortcutSection extends StatelessWidget {
  const new({required this.quickButtons});
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
  const new({required this.announcement, required this.onTap});
  final BreakingAnnouncement announcement;
  final VoidCallback onTap;
  @override
  Size get preferredSize => const Size.fromHeight(32);
  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(32),
      child: Material(
        color: SemanticColor.light.accentPrimary.withValues(alpha: 0.75),
        child: InkWell(
          onTap: onTap,
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
