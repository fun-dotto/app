import 'package:dotto/domain/entity/subject_feedback.dart';
import 'package:dotto/presentation/common/error_view.dart';
import 'package:dotto/presentation/common/is_authenticated.dart';
import 'package:dotto/presentation/common/loading_view.dart';
import 'package:dotto/presentation/subject/subject_detail_add_feedback_screen.dart';
import 'package:dotto/presentation/subject/subject_detail_feedback_content.dart';
import 'package:dotto/presentation/subject/subject_feedbacks_state.dart';
import 'package:dotto/presentation/subject/subject_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';

final class SubjectDetailFeedbackScreen extends HookConsumerWidget {
  const new({required this.lessonId, super.key});
  final String lessonId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isAuthenticated = ref.watch(isAuthenticatedProvider);
    final feedbacks = ref.watch(subjectFeedbacksStateProvider(lessonId));
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: switch (feedbacks) {
          AsyncData(:final value) => SubjectDetailFeedbackContent(
            feedbacks: value,
          ),
          AsyncError() => const ErrorView(),
          _ => const LoadingView(),
        },
      ),
      floatingActionButton: FloatingActionButton(
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
        child: const Icon(Icons.add),
      ),
    );
  }
}
