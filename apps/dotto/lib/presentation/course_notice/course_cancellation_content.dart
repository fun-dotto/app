import 'package:dotto/domain/entity/course_notice.dart';
import 'package:dotto/domain/entity/course_notice_scope.dart';
import 'package:dotto/helper/date_formatter.dart';
import 'package:dotto/l10n/app_localizations.dart';
import 'package:dotto/l10n/app_localizations_ja.dart';
import 'package:dotto_design_system/component/button.dart';
import 'package:dotto_design_system/style/semantic_color.dart';
import 'package:material_ui/material_ui.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

/// 休講・補講・教室変更画面のタブ。
enum CourseNoticeTab { cancellations, makeups, roomChanges }

/// 休講・補講・教室変更の画面の枠組み。
///
/// タブの中身は [body] で受け取り、[CourseNoticeTabView] などを渡す。
final class CourseCancellationContent extends StatelessWidget {
  const new({
    required this.initialTab,
    required this.scope,
    required this.onScopeToggled,
    required this.body,
    super.key,
  });

  final CourseNoticeTab initialTab;
  final CourseNoticeScope scope;
  final VoidCallback onScopeToggled;
  final Widget body;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context) ?? AppLocalizationsJa();
    final isRegistered = scope == CourseNoticeScope.registered;
    return DefaultTabController(
      length: CourseNoticeTab.values.length,
      initialIndex: initialTab.index,
      child: Scaffold(
        appBar: AppBar(
          title: Text(l10n.courseNoticeTitle),
          actions: [
            DottoButton(
              onPressed: onScopeToggled,
              type: DottoButtonType.text,
              child: Row(
                spacing: 4,
                children: [
                  Icon(
                    isRegistered ? Icons.filter_alt : Icons.filter_alt_outlined,
                  ),
                  Text(
                    isRegistered
                        ? l10n.courseNoticeRegistered
                        : l10n.courseNoticeAll,
                  ),
                ],
              ),
            ),
          ],
          bottom: TabBar(
            dividerHeight: 0,
            tabs: [
              Tab(text: l10n.courseNoticeCancellation),
              Tab(text: l10n.courseNoticeMakeup),
              Tab(text: l10n.courseNoticeRoomChange),
            ],
          ),
        ),
        body: body,
      ),
    );
  }
}

/// 種類ごとのタブに振り分けた、休講・補講・教室変更の一覧。
final class CourseNoticeTabView extends StatelessWidget {
  const new({required this.notices, required this.onRefresh, super.key});

  final List<CourseNotice> notices;
  final RefreshCallback onRefresh;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context) ?? AppLocalizationsJa();
    return TabBarView(
      children: [
        for (final tab in CourseNoticeTab.values)
          _CourseNoticeList(
            items: notices
                .where(
                  (notice) => switch ((tab, notice)) {
                    (CourseNoticeTab.cancellations, CancellationNotice()) ||
                    (CourseNoticeTab.makeups, MakeupNotice()) ||
                    (CourseNoticeTab.roomChanges, RoomChangeNotice()) => true,
                    _ => false,
                  },
                )
                .toList(),
            emptyMessage: switch (tab) {
              CourseNoticeTab.cancellations =>
                l10n.courseNoticeEmptyCancellation,
              CourseNoticeTab.makeups => l10n.courseNoticeEmptyMakeup,
              CourseNoticeTab.roomChanges => l10n.courseNoticeEmptyRoomChange,
            },
            onRefresh: onRefresh,
          ),
      ],
    );
  }
}

/// 読み込み中のプレースホルダー。
final class CourseNoticeLoadingSkeleton extends StatelessWidget {
  const new({super.key});
  static const _itemCount = 8;
  @override
  Widget build(BuildContext context) => ListView.separated(
    physics: const NeverScrollableScrollPhysics(),
    itemCount: _itemCount,
    separatorBuilder: (_, _) => const Divider(height: 0),
    itemBuilder: (_, _) => const _ListTileSkeleton(),
  );
}

final class _CourseNoticeList extends StatelessWidget {
  const new({
    required this.items,
    required this.emptyMessage,
    required this.onRefresh,
  });
  final List<CourseNotice> items;
  final String emptyMessage;
  final Future<void> Function() onRefresh;
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: items.isEmpty
          ? ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              children: [
                const SizedBox(height: 160),
                Center(child: Text(emptyMessage)),
              ],
            )
          : ListView.separated(
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: items.length,
              separatorBuilder: (_, _) => const Divider(height: 0),
              itemBuilder: (context, index) =>
                  _CourseNoticeTile(notice: items[index]),
            ),
    );
  }
}

final class _CourseNoticeTile extends StatelessWidget {
  const new({required this.notice});
  final CourseNotice notice;
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context) ?? AppLocalizationsJa();
    final subtitle = switch (notice) {
      CancellationNotice(:final comment) ||
      MakeupNotice(:final comment) => comment.trim(),
      RoomChangeNotice(:final originalRoomName, :final newRoomName) =>
        '$originalRoomName → $newRoomName',
    };
    final noticeDate = DateFormatter.dateWithDayOfWeek(
      notice.date,
      locale: Localizations.localeOf(context).toString(),
    );
    return ListTile(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$noticeDate '
            '${l10n.courseNoticePeriod(notice.periodNumber)}',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          Text(
            notice.subject.name,
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ],
      ),
      subtitle: subtitle.isEmpty
          ? null
          : Text(subtitle, style: Theme.of(context).textTheme.labelMedium),
    );
  }
}

final class _ListTileSkeleton extends StatelessWidget {
  const new();
  @override
  Widget build(BuildContext context) => const Padding(
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SkeletonBox(height: 12, width: 120),
        SizedBox(height: 8),
        _SkeletonBox(height: 14, width: 200),
      ],
    ),
  );
}

final class _SkeletonBox extends StatelessWidget {
  const new({required this.height, required this.width});
  final double height;
  final double width;
  @override
  Widget build(BuildContext context) => Shimmer(
    child: Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: SemanticColor.light.backgroundTertiary,
        borderRadius: BorderRadius.circular(4),
      ),
    ),
  );
}
