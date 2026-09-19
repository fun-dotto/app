import 'package:dotto/helper/s3_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

/// 過去問PDFのオブジェクトキーから表示用のファイル名を取り出す。
String pastExamFileName(String objectKey) {
  final match = RegExp(r'/(.*)$').firstMatch(objectKey);
  return match?.group(1) ?? objectKey;
}

final class SubjectDetailPastExamScreen extends HookWidget {
  const SubjectDetailPastExamScreen({
    required this.pastExamId,
    required this.isAuthenticated,
    required this.onPastExamSelected,
    super.key,
  });

  final String pastExamId;
  final bool isAuthenticated;

  /// 過去問が選択されたときの処理。引数は過去問PDFのオブジェクトキー。
  final void Function(String objectKey) onPastExamSelected;

  @override
  Widget build(BuildContext context) {
    if (!isAuthenticated) {
      return const Center(child: Text('Googleアカウント (@fun.ac.jp) による認証が必要です'));
    }

    final pastExamsSnapshot = useFuture(
      useMemoized(() => S3Repository().getListObjectsKey(url: pastExamId)),
    );

    if (pastExamsSnapshot.connectionState == ConnectionState.waiting) {
      return const Center(child: CircularProgressIndicator());
    }
    if (pastExamsSnapshot.hasError) {
      return const Center(child: Text('過去問の読み込みに失敗しました。'));
    }
    if (pastExamsSnapshot.hasData) {
      final pastExams = pastExamsSnapshot.data!;
      if (pastExams.isEmpty) {
        return const Center(child: Text('過去問はありません'));
      }
      return ListView(children: pastExams.map(_kakomonListRow).toList());
    }
    return const SizedBox.shrink();
  }

  Widget _kakomonListRow(String url) {
    return Column(
      children: [
        TextButton(
          onPressed: () => onPastExamSelected(url),
          child: ListTile(title: Text(pastExamFileName(url))),
        ),
        const Divider(height: 0),
      ],
    );
  }
}
