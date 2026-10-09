import 'package:dotto/presentation/common/error_view.dart';
import 'package:dotto/presentation/common/loading_view.dart';
import 'package:dotto/presentation/subject/subject_detail_add_feedback_screen.dart';
import 'package:dotto/presentation/subject/subject_detail_state.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';

/// 科目詳細からレビューの投稿先を解決する。
final class SubjectReviewNewScreen extends HookConsumerWidget {
  const new({required this.id, super.key});
  final String id;
  @override
  Widget build(BuildContext context, WidgetRef ref) =>
      switch (ref.watch(subjectDetailStateProvider(id))) {
        AsyncData(:final value) => SubjectDetailAddFeedbackScreen(
          lessonId: value.syllabus.id,
        ),
        AsyncError() => const Scaffold(body: ErrorView()),
        _ => const Scaffold(body: LoadingView()),
      };
}
