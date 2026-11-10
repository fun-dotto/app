import 'package:dotto/domain/entity/subject_feedback.dart';
import 'package:dotto/presentation/common/is_authenticated.dart';
import 'package:dotto/presentation/subject/subject_detail_add_feedback_screen.dart';
import 'package:dotto/presentation/subject/subject_feedbacks_state.dart';
import 'package:dotto/presentation/subject/subject_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';

/// 科目のレビューを投稿するツールバーボタン。
///
/// 未ログインのときは投稿画面を開かず、ログインを促すメッセージを表示する。
final class SubjectAddFeedbackButton extends HookConsumerWidget {
  const new({required this.lessonId, super.key});

  final String lessonId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isAuthenticated = ref.watch(isAuthenticatedProvider);

    return IconButton(
      icon: const Icon(Icons.add),
      onPressed: () async {
        if (!isAuthenticated) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                context
                    .subjectL10n
                    .subjectSignInWithAGoogleAccountFunAcJpPrompt,
              ),
            ),
          );
          return;
        }
        final result = await showModalBottomSheet<SubjectFeedback>(
          context: context,
          isScrollControlled: true,
          useSafeArea: true,
          builder: (_) => SubjectDetailAddFeedbackScreen(lessonId: lessonId),
        );
        if (result != null && context.mounted) {
          ref.invalidate(subjectFeedbacksStateProvider(lessonId));
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(context.subjectL10n.subjectFeedbackSubmitted),
            ),
          );
        }
      },
    );
  }
}
