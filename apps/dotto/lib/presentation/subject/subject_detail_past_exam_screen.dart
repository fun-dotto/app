import 'package:dotto/presentation/common/error_view.dart';
import 'package:dotto/presentation/common/loading_view.dart';
import 'package:dotto/presentation/subject/past_exams_state.dart';
import 'package:dotto/presentation/subject/subject_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';

/// 過去問のオブジェクトキーから表示用の名前を取り出す。
String pastExamFileName(String objectKey) =>
    RegExp(r'/(.*)$').firstMatch(objectKey)?.group(1) ?? objectKey;

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
      AsyncData(:final value) when value.isEmpty => Center(
        child: Text(context.subjectL10n.subjectNoPastExamsAvailable),
      ),
      AsyncData(:final value) => ListView.separated(
        itemCount: value.length,
        separatorBuilder: (_, _) => const Divider(height: 0),
        itemBuilder: (context, index) => ListTile(
          title: Text(pastExamFileName(value[index])),
          onTap: () => onPastExamSelected(value[index]),
        ),
      ),
      AsyncError() => const ErrorView(),
      _ => const LoadingView(),
    };
  }
}
