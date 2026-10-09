import 'package:dotto/presentation/common/pdf/web_pdf_viewer.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';

/// 保存された過去問PDFを閲覧・共有する。
final class CloudflarePdfViewer extends HookConsumerWidget {
  const new({required this.url, this.filename, super.key});
  final String url;
  final String? filename;
  @override
  Widget build(BuildContext context, WidgetRef ref) =>
      WebPdfViewer(url: url, filename: filename, isPastExam: true);
}
