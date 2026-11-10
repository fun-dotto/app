import 'package:dotto/domain/entity/course_document.dart';
import 'package:dotto/presentation/common/pdf/web_pdf_viewer.dart';
import 'package:dotto/presentation/common/use_localization.dart';
import 'package:dotto/presentation/course/course_resources_state.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';

export 'package:dotto/domain/entity/course_document.dart';

/// 年度付きのPDF資料を表示する画面。
///
/// URLは配信される最新の資料を参照し、[year] は表示名にのみ利用する。
final class CourseDocumentScreen extends HookConsumerWidget {
  const new({required this.document, required this.year, super.key});
  final CourseDocument document;
  final int year;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = useLocalization();
    final resources = ref.watch(courseResourcesStateProvider);
    final (url, label) = switch (document) {
      CourseDocument.officialCalendar => (
        resources.officialCalendarUrl,
        l10n.courseCalendarDocument,
      ),
      CourseDocument.springTimetable => (
        resources.springTimetableUrl,
        l10n.courseSpringTimetable,
      ),
      CourseDocument.fallTimetable => (
        resources.fallTimetableUrl,
        l10n.courseFallTimetable,
      ),
    };
    return WebPdfViewer(
      url: url,
      filename: l10n.courseDocumentName(year, label),
    );
  }
}
