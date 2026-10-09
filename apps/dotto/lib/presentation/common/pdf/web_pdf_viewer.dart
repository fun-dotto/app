import 'package:dotto/application/report_error_use_case.dart';
import 'package:dotto/application/share_pdf_use_case.dart';
import 'package:dotto/domain/entity/pdf_document.dart';
import 'package:dotto/l10n/app_localizations.dart';
import 'package:dotto/l10n/app_localizations_ja.dart';
import 'package:dotto/presentation/common/error_view.dart';
import 'package:dotto/presentation/common/loading_view.dart';
import 'package:dotto/presentation/common/pdf/pdf_document_state.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';

/// Web上のPDFをダウンロードして閲覧・共有する。
final class WebPdfViewer extends HookConsumerWidget {
  const new({
    required this.url,
    this.filename,
    this.isPastExam = false,
    super.key,
  });
  final String url;
  final String? filename;
  final bool isPastExam;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = pdfDocumentStateProvider(
      url,
      filename: filename,
      isPastExam: isPastExam,
    );
    final document = ref.watch(provider);
    final currentPage = useState(0);
    final error = useState<String?>(null);
    final shareKey = useMemoized(GlobalKey.new);
    return switch (document) {
      AsyncData(:final value) => _PdfContent(
        document: value,
        currentPage: currentPage.value,
        error: error.value,
        shareKey: shareKey,
        onPageChanged: (page) => currentPage.value = page,
        onError: (message) => error.value = message,
        onRetry: () {
          error.value = null;
          currentPage.value = 0;
          ref.invalidate(provider);
        },
      ),
      AsyncError() => Scaffold(
        appBar: AppBar(title: Text(filename ?? 'PDF')),
        body: const ErrorView(),
        floatingActionButton: FloatingActionButton(
          onPressed: () => ref.invalidate(provider),
          child: const Icon(Icons.refresh),
        ),
      ),
      _ => const Scaffold(body: LoadingView()),
    };
  }
}

final class _PdfContent extends HookConsumerWidget {
  const new({
    required this.document,
    required this.currentPage,
    required this.error,
    required this.shareKey,
    required this.onPageChanged,
    required this.onError,
    required this.onRetry,
  });
  final PdfDocument document;
  final int currentPage;
  final String? error;
  final GlobalKey shareKey;
  final ValueChanged<int> onPageChanged;
  final ValueChanged<String> onError;
  final VoidCallback onRetry;
  @override
  Widget build(BuildContext context, WidgetRef ref) => Scaffold(
    appBar: AppBar(
      title: Text(document.title),
      actions: [
        IconButton(
          key: shareKey,
          icon: const Icon(Icons.share),
          onPressed: () async {
            final report = ref.read(reportErrorUseCaseProvider);
            final box = shareKey.currentContext?.findRenderObject();
            final origin = switch (box) {
              final RenderBox box => (
                left: box.localToGlobal(Offset.zero).dx,
                top: box.localToGlobal(Offset.zero).dy,
                width: box.size.width,
                height: box.size.height,
              ),
              _ => null,
            };
            try {
              await ref.read(sharePdfUseCaseProvider)(document, origin: origin);
            } on Exception catch (error, stack) {
              await report(error, stack, reason: 'PDFの共有に失敗');
              if (!context.mounted) return;
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    (AppLocalizations.of(context) ?? AppLocalizationsJa())
                        .pdfShareFailed,
                  ),
                ),
              );
            }
          },
        ),
      ],
    ),
    floatingActionButton: error == null
        ? null
        : FloatingActionButton(
            onPressed: onRetry,
            child: const Icon(Icons.refresh),
          ),
    body: error == null
        ? PDFView(
            filePath: document.path,
            defaultPage: currentPage,
            autoSpacing: false,
            onError: (error) => onError(error.toString()),
            onPageError: (page, error) => onError(error.toString()),
            onPageChanged: (page, total) => onPageChanged(page ?? 0),
          )
        : const ErrorView(),
  );
}
