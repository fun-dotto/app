import 'package:dotto/application/save_subject_feedback_use_case.dart';
import 'package:dotto/domain/entity/subject_feedback.dart';
import 'package:dotto/presentation/common/user_state.dart';
import 'package:dotto/presentation/subject/subject_feedbacks_state.dart';
import 'package:dotto/presentation/subject/subject_localizations.dart';
import 'package:dotto_design_system/style/semantic_color.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
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
    final commentTextEditingController = useTextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text(context.subjectL10n.subjectPostFeedback),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.close),
        ),
        actions: [
          TextButton(
            onPressed: switch (user) {
              AsyncData(:final value) when !isSubmitting.value => () async {
                if (value == null) return;
                try {
                  final selectedScore = score.value;
                  if (selectedScore == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(context.subjectL10n.subjectSelectARating),
                      ),
                    );
                    return;
                  }
                  final feedback = SubjectFeedback(
                    score: selectedScore,
                    comment: commentTextEditingController.text,
                  );
                  isSubmitting.value = true;
                  await ref.read(saveSubjectFeedbackUseCaseProvider)(
                    userId: value.id,
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
                        content: Text(
                          context.subjectL10n.subjectCouldNotSubmitFeedback,
                        ),
                      ),
                    );
                  }
                } finally {
                  if (context.mounted) isSubmitting.value = false;
                }
              },
              _ => null,
            },
            child: Text(context.subjectL10n.subjectSubmit),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          spacing: 16,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    context.subjectL10n.subjectTapToRate,
                    style: Theme.of(context).textTheme.titleMedium
                        ?.copyWith(color: SemanticColor.light.accentPrimary),
                  ),
                ),
                RatingBar.builder(
                  itemBuilder: (context, index) => Icon(
                    Icons.star,
                    color: SemanticColor.light.accentPrimary,
                  ),
                  onRatingUpdate: (rating) => score.value = rating.toInt(),
                  glow: false,
                  itemSize: 32,
                  minRating: 1,
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 8,
              children: [
                Text(
                  context.subjectL10n.subjectComment,
                  style: Theme.of(context).textTheme.titleMedium
                      ?.copyWith(color: SemanticColor.light.accentPrimary),
                ),
                TextFormField(
                  maxLength: 30,
                  maxLines: 3,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    floatingLabelAlignment: FloatingLabelAlignment.start,
                    border: const OutlineInputBorder(),
                    hintText:
                        context.subjectL10n.subjectCreditsAttendanceExamsEtc,
                  ),
                  controller: commentTextEditingController,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
