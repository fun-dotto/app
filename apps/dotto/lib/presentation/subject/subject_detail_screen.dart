import 'package:dotto/presentation/common/is_authenticated.dart';
import 'package:dotto/presentation/subject/subject_detail_feedback_screen.dart';
import 'package:dotto/presentation/subject/subject_detail_past_exam_screen.dart';
import 'package:dotto/presentation/subject/subject_detail_state.dart';
import 'package:dotto/presentation/subject/subject_detail_syllabus_screen.dart';
import 'package:dotto/presentation/subject/subject_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

/// 科目詳細画面のタブ。
enum SubjectDetailTab {
  /// シラバス。
  syllabus,

  /// レビュー。
  reviews,

  /// 過去問。
  pastExams,
}

final class SubjectDetailScreen extends HookConsumerWidget {
  const new({
    required this.id,
    required this.initialTab,
    required this.onPastExamSelected,
    super.key,
  });

  final String id;

  /// 最初に表示するタブ。
  final SubjectDetailTab initialTab;

  /// 過去問が選択されたときの処理。引数は過去問PDFのオブジェクトキー。
  final void Function(String objectKey) onPastExamSelected;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final subjectState = ref.watch(subjectDetailStateProvider(id));
    final isAuthenticated = ref.watch(isAuthenticatedProvider);

    return DefaultTabController(
      length: SubjectDetailTab.values.length,
      initialIndex: initialTab.index,
      child: Scaffold(
        appBar: AppBar(
          title: Text(subjectState.value?.name ?? ''),
          bottom: TabBar(
            dividerColor: Colors.transparent,
            tabs: <Widget>[
              Tab(text: context.subjectL10n.subjectSyllabus),
              Tab(text: context.subjectL10n.subjectReviews),
              Tab(text: context.subjectL10n.subjectPastExams),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            switch (subjectState) {
              AsyncData(:final value) => SubjectDetailSyllabusScreen(
                syllabus: value.syllabus,
              ),
              AsyncError() => Center(
                child: Text(
                  context.subjectL10n.subjectCouldNotLoadSubjectInformation,
                ),
              ),
              _ => const _SubjectDetailSyllabusSkeleton(),
            },
            switch (subjectState) {
              AsyncData(:final value) => SubjectDetailFeedbackScreen(
                lessonId: value.syllabus.id,
              ),
              AsyncError() => Center(
                child: Text(
                  context.subjectL10n.subjectCouldNotLoadSubjectInformation,
                ),
              ),
              _ => const _SubjectDetailFeedbackSkeleton(),
            },
            switch (subjectState) {
              AsyncData(:final value) => SubjectDetailPastExamScreen(
                pastExamId: value.pastExamId,
                isAuthenticated: isAuthenticated,
                onPastExamSelected: onPastExamSelected,
              ),
              AsyncError() => Center(
                child: Text(
                  context.subjectL10n.subjectCouldNotLoadSubjectInformation,
                ),
              ),
              _ => const _SubjectDetailPastExamSkeleton(),
            },
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
  Widget build(BuildContext context) => Shimmer(
    child: Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(radius),
      ),
    ),
  );
}

final class _SubjectDetailSyllabusSkeleton extends StatelessWidget {
  const new();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (var index = 0; index < 6; index++) ...[
            _SkeletonBox(
              height: 18,
              width: 96 + (index.isEven ? 24 : 48),
              radius: 4,
            ),
            const SizedBox(height: 12),
            const _SkeletonBox(height: 14, width: double.infinity, radius: 4),
            const SizedBox(height: 8),
            _SkeletonBox(
              height: 14,
              width: index.isEven ? 240 : 280,
              radius: 4,
            ),
            if (index < 5) ...[
              const SizedBox(height: 16),
              const Divider(height: 0),
              const SizedBox(height: 16),
            ],
          ],
        ],
      ),
    );
  }
}

final class _SubjectDetailFeedbackSkeleton extends StatelessWidget {
  const new();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _SkeletonBox(height: 36, width: 64, radius: 6),
                    SizedBox(height: 8),
                    _SkeletonBox(height: 12, width: 84, radius: 4),
                  ],
                ),
                const SizedBox(width: 32),
                Expanded(
                  child: Column(
                    children: List.generate(
                      5,
                      (index) => Padding(
                        padding: EdgeInsets.only(bottom: index == 4 ? 0 : 8),
                        child: const Row(
                          children: [
                            _SkeletonBox(height: 12, width: 56, radius: 4),
                            SizedBox(width: 8),
                            Expanded(
                              child: _SkeletonBox(height: 8, radius: 999),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 0),
          Expanded(
            child: ListView.separated(
              itemCount: 4,
              separatorBuilder: (_, _) => const Divider(height: 0),
              itemBuilder: (_, _) {
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _SkeletonBox(height: 12, width: 72, radius: 4),
                      SizedBox(height: 8),
                      _SkeletonBox(
                        height: 14,
                        width: double.infinity,
                        radius: 4,
                      ),
                      SizedBox(height: 6),
                      _SkeletonBox(height: 14, width: 220, radius: 4),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

final class _SubjectDetailPastExamSkeleton extends StatelessWidget {
  const new();

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: 6,
      separatorBuilder: (_, _) => const Divider(height: 0),
      itemBuilder: (_, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Row(
            children: [
              Expanded(
                child: _SkeletonBox(
                  height: 16,
                  width: index.isEven ? 240 : 200,
                  radius: 4,
                ),
              ),
              const SizedBox(width: 12),
              Icon(Icons.chevron_right, color: Colors.grey.shade400),
            ],
          ),
        );
      },
    );
  }
}
