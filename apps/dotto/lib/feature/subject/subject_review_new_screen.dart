import 'package:dotto/api/api_client.dart';
import 'package:dotto/feature/subject/subject_detail_add_feedback_screen.dart';
import 'package:dotto/repository/subject_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// 科目のレビュー投稿画面。
///
/// URLからは科目IDのみ渡されるため、レビューの投稿先となるシラバスID
/// （lessonId）を科目詳細から解決してからフォームを表示する。
final class SubjectReviewNewScreen extends HookConsumerWidget {
  const SubjectReviewNewScreen({required this.id, super.key});

  final String id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final apiClient = ref.read(apiClientProvider);
    final subjectRepository = SubjectRepositoryImpl(apiClient);
    final subjectSnapshot = useFuture(
      useMemoized(() => subjectRepository.getSubject(id)),
    );

    if (subjectSnapshot.connectionState == ConnectionState.waiting) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    final subject = subjectSnapshot.data;
    if (subject == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('フィードバックを投稿')),
        body: const Center(child: Text('科目情報の読み込みに失敗しました。')),
      );
    }
    return SubjectDetailAddFeedbackScreen(lessonId: subject.syllabus.id);
  }
}
