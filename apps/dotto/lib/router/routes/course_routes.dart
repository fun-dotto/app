import 'dart:async';

import 'package:dotto/feature/course/course_cancellation_screen.dart';
import 'package:dotto/feature/course/course_customize_screen.dart';
import 'package:dotto/feature/course/course_document_screen.dart';
import 'package:dotto/feature/course/course_registration_screen.dart';
import 'package:dotto/feature/course/course_screen.dart';
import 'package:dotto/feature/subject/search_subject_screen.dart';
import 'package:dotto/feature/subject/subject_detail_past_exam_screen.dart';
import 'package:dotto/feature/subject/subject_detail_screen.dart';
import 'package:dotto/feature/subject/subject_review_new_screen.dart';
import 'package:dotto/router/routes/app_routes.dart';
import 'package:dotto/router/routes/subject_detail_builder.dart';
import 'package:dotto/widget/cloudflare_pdf_viewer.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

final class CourseRouteData extends GoRouteData with $CourseRouteData {
  const new();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const CourseScreen();
  }
}

final class CourseCustomizeRouteData extends GoRouteData
    with $CourseCustomizeRouteData {
  const new();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const CourseCustomizeScreen();
  }
}

final class CourseRegistrationRouteData extends GoRouteData
    with $CourseRegistrationRouteData {
  const new();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const CourseRegistrationScreen();
  }
}

/// 休講・補講・教室変更のパスは休講のタブへ寄せる。
final class CourseNoticeRouteData extends GoRouteData
    with $CourseNoticeRouteData {
  const new();

  @override
  FutureOr<String?> redirect(BuildContext context, GoRouterState state) {
    return const CourseNoticeCancellationsRouteData().location;
  }
}

final class CourseNoticeCancellationsRouteData extends GoRouteData
    with $CourseNoticeCancellationsRouteData {
  const new();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const CourseCancellationScreen(
      initialTab: CourseNoticeTab.cancellations,
    );
  }
}

final class CourseNoticeMakeupsRouteData extends GoRouteData
    with $CourseNoticeMakeupsRouteData {
  const new();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const CourseCancellationScreen(initialTab: CourseNoticeTab.makeups);
  }
}

final class CourseNoticeRoomChangesRouteData extends GoRouteData
    with $CourseNoticeRoomChangesRouteData {
  const new();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const CourseCancellationScreen(
      initialTab: CourseNoticeTab.roomChanges,
    );
  }
}

final class CourseSubjectsRouteData extends GoRouteData
    with $CourseSubjectsRouteData {
  const new();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return SearchSubjectScreen(
      onSubjectSelected: (subjectId) => unawaited(
        CourseSubjectSyllabusRouteData(id: subjectId).push<void>(context),
      ),
    );
  }
}

/// 科目詳細のパスは常にタブ付きのパスへ寄せる。
final class CourseSubjectDetailRouteData extends GoRouteData
    with $CourseSubjectDetailRouteData {
  const new({required this.id});

  final String id;

  @override
  FutureOr<String?> redirect(BuildContext context, GoRouterState state) {
    return CourseSubjectSyllabusRouteData(id: id).location;
  }
}

final class CourseSubjectSyllabusRouteData extends GoRouteData
    with $CourseSubjectSyllabusRouteData {
  const new({required this.id});

  final String id;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return _courseSubjectDetail(
      context,
      id: id,
      tab: SubjectDetailTab.syllabus,
    );
  }
}

final class CourseSubjectReviewsRouteData extends GoRouteData
    with $CourseSubjectReviewsRouteData {
  const new({required this.id});

  final String id;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return _courseSubjectDetail(context, id: id, tab: SubjectDetailTab.reviews);
  }
}

final class CourseSubjectReviewNewRouteData extends GoRouteData
    with $CourseSubjectReviewNewRouteData {
  const new({required this.id});

  final String id;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return SubjectReviewNewScreen(id: id);
  }
}

final class CourseSubjectPastExamsRouteData extends GoRouteData
    with $CourseSubjectPastExamsRouteData {
  const new({required this.id});

  final String id;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return _courseSubjectDetail(
      context,
      id: id,
      tab: SubjectDetailTab.pastExams,
    );
  }
}

final class CourseSubjectPastExamRouteData extends GoRouteData
    with $CourseSubjectPastExamRouteData {
  const new({required this.id, required this.pastExamId});

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

final class CourseCalendarRouteData extends GoRouteData
    with $CourseCalendarRouteData {
  const new({required this.year});

  final int year;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return CourseDocumentScreen(
      document: CourseDocument.officialCalendar,
      year: year,
    );
  }
}

final class CourseSpringTimetableRouteData extends GoRouteData
    with $CourseSpringTimetableRouteData {
  const new({required this.year});

  final int year;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return CourseDocumentScreen(
      document: CourseDocument.springTimetable,
      year: year,
    );
  }
}

final class CourseFallTimetableRouteData extends GoRouteData
    with $CourseFallTimetableRouteData {
  const new({required this.year});

  final int year;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return CourseDocumentScreen(
      document: CourseDocument.fallTimetable,
      year: year,
    );
  }
}

/// 講義タブの科目詳細を、指定したタブを開いた状態で構築する。
Widget _courseSubjectDetail(
  BuildContext context, {
  required String id,
  required SubjectDetailTab tab,
}) {
  return buildSubjectDetail(
    context,
    id: id,
    tab: tab,
    pastExamRoute: (objectKey) =>
        CourseSubjectPastExamRouteData(id: id, pastExamId: objectKey),
  );
}
