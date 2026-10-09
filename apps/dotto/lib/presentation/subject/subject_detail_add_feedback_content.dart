import 'package:dotto/presentation/subject/subject_localizations.dart';
import 'package:dotto_design_system/style/semantic_color.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:material_ui/material_ui.dart';

/// 科目のレビューを入力するフォーム。
final class SubjectDetailAddFeedbackContent extends StatelessWidget {
  const new({
    required this.canSubmit,
    required this.onClose,
    required this.onSubmit,
    required this.onScoreChanged,
    required this.onCommentChanged,
    super.key,
  });

  final bool canSubmit;
  final VoidCallback onClose;
  final VoidCallback onSubmit;
  final ValueChanged<int> onScoreChanged;
  final ValueChanged<String> onCommentChanged;

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context).textTheme.titleMedium
        ?.copyWith(color: SemanticColor.light.accentPrimary);
    return Scaffold(
      appBar: AppBar(
        title: Text(context.subjectL10n.subjectPostFeedback),
        leading: IconButton(onPressed: onClose, icon: const Icon(Icons.close)),
        actions: [
          TextButton(
            onPressed: canSubmit ? onSubmit : null,
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
                    style: titleStyle,
                  ),
                ),
                RatingBar.builder(
                  itemBuilder: (context, index) => Icon(
                    Icons.star,
                    color: SemanticColor.light.accentPrimary,
                  ),
                  onRatingUpdate: (rating) => onScoreChanged(rating.toInt()),
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
                Text(context.subjectL10n.subjectComment, style: titleStyle),
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
                  onChanged: onCommentChanged,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
