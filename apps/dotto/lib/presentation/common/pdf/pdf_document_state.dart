import 'dart:async';

import 'package:dotto/application/download_pdf_use_case.dart';
import 'package:dotto/application/release_pdf_use_case.dart';
import 'package:dotto/application/report_error_use_case.dart';
import 'package:dotto/domain/entity/pdf_document.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'pdf_document_state.g.dart';

@riverpod
final class PdfDocumentState extends _$PdfDocumentState {
  @override
  Future<PdfDocument> build(
    String url, {
    String? filename,
    bool isPastExam = false,
  }) async {
    final release = ref.watch(releasePdfUseCaseProvider);
    final report = ref.watch(reportErrorUseCaseProvider);
    final document = await ref.watch(downloadPdfUseCaseProvider)(
      url,
      filename: filename,
      isPastExam: isPastExam,
    );
    Future<void> cleanup() async {
      try {
        await release(document);
      } on Exception catch (error, stack) {
        await report(error, stack, reason: 'PDF一時ファイルの削除に失敗');
      }
    }

    if (!ref.mounted) {
      await cleanup();
      return document;
    }
    ref.onDispose(() => unawaited(cleanup()));
    return document;
  }
}
