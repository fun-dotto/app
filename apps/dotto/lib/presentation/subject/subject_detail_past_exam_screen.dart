import 'package:dotto/presentation/common/error_view.dart';
import 'package:dotto/presentation/common/loading_view.dart';
import 'package:dotto/presentation/subject/past_exams_state.dart';
import 'package:dotto/presentation/subject/subject_detail_past_exam_content.dart';
import 'package:dotto/presentation/subject/subject_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';

export 'package:dotto/presentation/subject/subject_detail_past_exam_content.dart'
    show pastExamFileName;

final class SubjectDetailPastExamScreen extends HookConsumerWidget {
  const new({
    required this.pastExamId,
    required this.isAuthenticated,
    required this.onPastExamSelected,
    super.key,
  });
  final String pastExamId;
  final bool isAuthenticated;
  final ValueChanged<String> onPastExamSelected;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (!isAuthenticated) {
      return Center(
        child: Text(context.subjectL10n.subjectSignInWithAGoogleAccountFunAcJp),
      );
    }
    return switch (ref.watch(pastExamsStateProvider(pastExamId))) {
      AsyncData(:final value) => SubjectDetailPastExamContent(
        pastExams: value,
        onPastExamSelected: onPastExamSelected,
      ),
      AsyncError() => const ErrorView(),
      _ => const LoadingView(),
    };
  }
}
