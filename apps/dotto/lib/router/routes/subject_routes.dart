import 'dart:async';

import 'package:dotto/feature/subject/search_subject_screen.dart';
import 'package:dotto/feature/subject/subject_detail_past_exam_screen.dart';
import 'package:dotto/feature/subject/subject_detail_screen.dart';
import 'package:dotto/feature/subject/subject_review_new_screen.dart';
import 'package:dotto/router/routes/app_routes.dart';
import 'package:dotto/router/routes/subject_detail_builder.dart';
import 'package:dotto/widget/cloudflare_pdf_viewer.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final class SubjectsRouteData extends GoRouteData with $SubjectsRouteData {
  const SubjectsRouteData();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return SearchSubjectScreen(
      onSubjectSelected: (subjectId) => unawaited(
        SubjectSyllabusRouteData(id: subjectId).push<void>(context),
      ),
    );
  }
}

/// 科目詳細のパスは常にタブ付きのパスへ寄せる。
final class SubjectDetailRouteData extends GoRouteData
    with $SubjectDetailRouteData {
  const SubjectDetailRouteData({required this.id});

  final String id;

  @override
  FutureOr<String?> redirect(BuildContext context, GoRouterState state) {
    return SubjectSyllabusRouteData(id: id).location;
  }
}

final class SubjectSyllabusRouteData extends GoRouteData
    with $SubjectSyllabusRouteData {
  const SubjectSyllabusRouteData({required this.id});

  final String id;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return _subjectDetail(context, id: id, tab: SubjectDetailTab.syllabus);
  }
}

final class SubjectReviewsRouteData extends GoRouteData
    with $SubjectReviewsRouteData {
  const SubjectReviewsRouteData({required this.id});

  final String id;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return _subjectDetail(context, id: id, tab: SubjectDetailTab.reviews);
  }
}

final class SubjectReviewNewRouteData extends GoRouteData
    with $SubjectReviewNewRouteData {
  const SubjectReviewNewRouteData({required this.id});

  final String id;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return SubjectReviewNewScreen(id: id);
  }
}

final class SubjectPastExamsRouteData extends GoRouteData
    with $SubjectPastExamsRouteData {
  const SubjectPastExamsRouteData({required this.id});

  final String id;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return _subjectDetail(context, id: id, tab: SubjectDetailTab.pastExams);
  }
}

final class SubjectPastExamRouteData extends GoRouteData
    with $SubjectPastExamRouteData {
  const SubjectPastExamRouteData({required this.id, required this.pastExamId});

  final String id;

  /// 過去問PDFのオブジェクトキー。
  final String pastExamId;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return CloudflarePdfViewer(
      url: pastExamId,
      filename: pastExamFileName(pastExamId),
    );
  }
}

/// 科目検索タブの科目詳細を、指定したタブを開いた状態で構築する。
Widget _subjectDetail(
  BuildContext context, {
  required String id,
  required SubjectDetailTab tab,
}) {
  return buildSubjectDetail(
    context,
    id: id,
    tab: tab,
    pastExamRoute: (objectKey) =>
        SubjectPastExamRouteData(id: id, pastExamId: objectKey),
  );
}
