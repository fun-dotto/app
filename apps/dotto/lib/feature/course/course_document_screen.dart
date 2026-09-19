import 'package:dotto/foundation/config/config.dart';
import 'package:dotto/foundation/config/remote_config.dart';
import 'package:dotto/foundation/config/remote_configs.dart';
import 'package:dotto/widget/web_pdf_viewer.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// 講義タブから閲覧できるPDF資料。
enum CourseDocument {
  /// 学年暦。
  officialCalendar(
    remoteConfig: RemoteConfigs.officialCalendarPdfUrl,
    label: '学年暦',
  ),

  /// 前期の時間割。
  springTimetable(
    remoteConfig: RemoteConfigs.timetable1PdfUrl,
    label: '時間割 前期',
  ),

  /// 後期の時間割。
  fallTimetable(remoteConfig: RemoteConfigs.timetable2PdfUrl, label: '時間割 後期');

  const CourseDocument({required this.remoteConfig, required this.label});

  /// PDFのURLを配信するRemote Config。
  final RemoteConfig<String> remoteConfig;

  /// 表示名。
  final String label;
}

/// 年度付きのPDF資料を表示する画面。
///
/// PDFのURLはRemote Configが配信する最新のものを参照する。[year] はどの年度の
/// 資料としてリンクされたかを表す識別子で、表示名にのみ利用する。
final class CourseDocumentScreen extends ConsumerWidget {
  const CourseDocumentScreen({
    required this.document,
    required this.year,
    super.key,
  });

  final CourseDocument document;

  /// 年度（4月始まり）。
  final int year;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final url = ref.watch(configProvider(document.remoteConfig));
    return WebPdfViewer(url: url, filename: '$year年度 ${document.label}');
  }
}
