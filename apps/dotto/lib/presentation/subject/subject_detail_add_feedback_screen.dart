import 'dart:async';

import 'package:dotto/application/save_subject_feedback_use_case.dart';
import 'package:dotto/domain/entity/subject_feedback.dart';
import 'package:dotto/presentation/common/user_state.dart';
import 'package:dotto/presentation/subject/subject_detail_add_feedback_content.dart';
import 'package:dotto/presentation/subject/subject_feedbacks_state.dart';
import 'package:dotto/presentation/subject/subject_localizations.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';

final class SubjectDetailAddFeedbackScreen extends HookConsumerWidget {
  const new({required this.lessonId, super.key});

  final String lessonId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userStateProvider);
    final isSubmitting = useState(false);
    final score = useState<int?>(null);
    final comment = useState('');

    Future<void> submit(String userId) async {
      final selectedScore = score.value;
      if (selectedScore == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(context.subjectL10n.subjectSelectARating)),
        );
        return;
      }
      final feedback = SubjectFeedback(
        score: selectedScore,
        comment: comment.value,
      );
      isSubmitting.value = true;
      try {
        await ref.read(saveSubjectFeedbackUseCaseProvider)(
          userId: userId,
          lessonId: lessonId,
          feedback: feedback,
        );
        if (context.mounted) {
          ref.invalidate(subjectFeedbacksStateProvider(lessonId));
          Navigator.of(context).pop(feedback);
        }
      } on Exception catch (_) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(context.subjectL10n.subjectCouldNotSubmitFeedback),
            ),
          );
        }
      } finally {
        if (context.mounted) isSubmitting.value = false;
      }
    }

    final userId = switch (user) {
      AsyncData(:final value) => value?.id,
      _ => null,
    };

    return SubjectDetailAddFeedbackContent(
      canSubmit: user is AsyncData && !isSubmitting.value,
      onClose: () => Navigator.of(context).pop(),
      onSubmit: () {
        if (userId != null) unawaited(submit(userId));
      },
      onScoreChanged: (value) => score.value = value,
      onCommentChanged: (value) => comment.value = value,
    );
  }
}
