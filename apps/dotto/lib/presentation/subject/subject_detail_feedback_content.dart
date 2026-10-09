import 'package:dotto/domain/entity/subject_feedback.dart';
import 'package:dotto/presentation/subject/subject_localizations.dart';
import 'package:dotto_design_system/style/semantic_color.dart';
import 'package:material_ui/material_ui.dart';

/// 科目のレビューの集計と一覧の表示。
final class SubjectDetailFeedbackContent extends StatelessWidget {
  const new({required this.feedbacks, super.key});

  final List<SubjectFeedback> feedbacks;

  @override
  Widget build(BuildContext context) {
    if (feedbacks.isEmpty) {
      return Center(child: Text(context.subjectL10n.subjectNoFeedbackYet));
    }
    return Column(
      children: [
        _FeedbackSummary(feedbacks: feedbacks),
        const Divider(height: 0),
        Expanded(child: _FeedbackList(feedbacks: feedbacks)),
      ],
    );
  }
}

final class _FeedbackSummary extends StatelessWidget {
  const new({required this.feedbacks});
  final List<SubjectFeedback> feedbacks;
  @override
  Widget build(BuildContext context) {
    final averageScore =
        feedbacks.fold(0, (sum, item) => sum + item.score) / feedbacks.length;
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 32,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                averageScore.toStringAsFixed(1),
                style: Theme.of(context).textTheme.displayLarge,
              ),
              Text(context.subjectL10n.subjectOutOf5),
            ],
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                for (final rating in [5, 4, 3, 2, 1])
                  _RatingBar(
                    rating: rating,
                    ratio:
                        feedbacks.where((item) => item.score == rating).length /
                        feedbacks.length,
                  ),
                Text(
                  context.subjectL10n.subjectFeedbackCount(feedbacks.length),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

final class _FeedbackList extends StatelessWidget {
  const new({required this.feedbacks});
  final List<SubjectFeedback> feedbacks;
  @override
  Widget build(BuildContext context) {
    final items = feedbacks.where((item) => item.comment.isNotEmpty).toList()
      ..sort((a, b) => b.score.compareTo(a.score));
    return ListView.separated(
      itemCount: items.length,
      separatorBuilder: (_, _) => const Divider(height: 0),
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 4,
          children: [
            _Stars(rating: items[index].score),
            Text(items[index].comment),
          ],
        ),
      ),
    );
  }
}

final class _RatingBar extends StatelessWidget {
  const new({required this.rating, required this.ratio});
  final int rating;
  final double ratio;
  @override
  Widget build(BuildContext context) => Row(
    spacing: 4,
    children: [
      _Stars(rating: rating, isInverse: true),
      Expanded(
        child: LinearProgressIndicator(
          value: ratio,
          color: SemanticColor.light.accentPrimary,
          backgroundColor: SemanticColor.light.backgroundTertiary,
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    ],
  );
}

final class _Stars extends StatelessWidget {
  const new({required this.rating, this.isInverse = false});
  final int rating;
  final bool isInverse;
  @override
  Widget build(BuildContext context) => Row(
    children: [
      for (var index = 0; index < 5; index++)
        if (isInverse ? index >= 5 - rating : index < rating)
          const Icon(Icons.star, size: 12)
        else
          const SizedBox(width: 12),
    ],
  );
}
