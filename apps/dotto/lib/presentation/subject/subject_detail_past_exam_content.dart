import 'package:dotto/presentation/subject/subject_localizations.dart';
import 'package:material_ui/material_ui.dart';

/// 過去問のオブジェクトキーから表示用の名前を取り出す。
String pastExamFileName(String objectKey) =>
    RegExp(r'/(.*)$').firstMatch(objectKey)?.group(1) ?? objectKey;

/// 過去問の一覧の表示。
final class SubjectDetailPastExamContent extends StatelessWidget {
  const new({
    required this.pastExams,
    required this.onPastExamSelected,
    super.key,
  });

  /// 過去問のオブジェクトキー。
  final List<String> pastExams;
  final ValueChanged<String> onPastExamSelected;

  @override
  Widget build(BuildContext context) {
    if (pastExams.isEmpty) {
      return Center(
        child: Text(context.subjectL10n.subjectNoPastExamsAvailable),
      );
    }
    return ListView.separated(
      itemCount: pastExams.length,
      separatorBuilder: (_, _) => const Divider(height: 0),
      itemBuilder: (context, index) => ListTile(
        title: Text(pastExamFileName(pastExams[index])),
        onTap: () => onPastExamSelected(pastExams[index]),
      ),
    );
  }
}
