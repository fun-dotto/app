import 'package:dotto/domain/entity/course_document.dart';
import 'package:dotto/l10n/app_localizations.dart';
import 'package:dotto/l10n/app_localizations_ja.dart';
import 'package:dotto/presentation/course/course_resources_state.dart';
import 'package:dotto/widget/web_pdf_viewer.dart';
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
    final resources = ref.watch(courseResourcesStateProvider);
    final (url, label) = switch (document) {
      CourseDocument.officialCalendar => (
        resources.officialCalendarUrl,
        (AppLocalizations.of(context) ?? AppLocalizationsJa())
            .courseCalendarDocument,
      ),
      CourseDocument.springTimetable => (
        resources.springTimetableUrl,
        (AppLocalizations.of(context) ?? AppLocalizationsJa())
            .courseSpringTimetable,
      ),
      CourseDocument.fallTimetable => (
        resources.fallTimetableUrl,
        (AppLocalizations.of(context) ?? AppLocalizationsJa())
            .courseFallTimetable,
      ),
    };
    return WebPdfViewer(
      url: url,
      filename: (AppLocalizations.of(context) ?? AppLocalizationsJa())
          .courseDocumentName(year, label),
    );
  }
}
