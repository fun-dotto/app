import 'package:dotto/helper/s3_repository.dart';
import 'package:dotto/router/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

final class SubjectDetailPastExamScreen extends HookWidget {
  const SubjectDetailPastExamScreen({
    required this.pastExamId,
    required this.isAuthenticated,
    super.key,
  });

  final String pastExamId;
  final bool isAuthenticated;

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
      return ListView(
        children: pastExams.map((e) => _kakomonListRow(context, e)).toList(),
      );
    }
    return const SizedBox.shrink();
  }

  Widget _kakomonListRow(BuildContext context, String url) {
    final exp = RegExp(r'/(.*)$');
    final match = exp.firstMatch(url);
    final filename = match?.group(1) ?? url;
    return Column(
      children: [
        TextButton(
          onPressed: () async {
            await SubjectPastExamPdfRouteData(
              id: pastExamId,
              url: url,
              filename: filename,
            ).push<void>(context);
          },
          child: ListTile(title: Text(filename)),
        ),
        const Divider(height: 0),
      ],
    );
  }
}
