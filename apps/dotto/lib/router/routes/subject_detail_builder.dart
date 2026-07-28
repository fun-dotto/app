import 'dart:async';

import 'package:dotto/feature/subject/subject_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// 科目詳細を、指定したタブを開いた状態で構築する。
///
/// 過去問のパスは講義タブと科目検索タブで異なるため、過去問を開くルートは
/// 呼び出し側から受け取る。
Widget buildSubjectDetail(
  BuildContext context, {
  required String id,
  required SubjectDetailTab tab,
  required GoRouteData Function(String objectKey) pastExamRoute,
}) {
  return SubjectDetailScreen(
    id: id,
    initialTab: tab,
    onPastExamSelected: (objectKey) =>
        unawaited(pastExamRoute(objectKey).push<void>(context)),
  );
}
