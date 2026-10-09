import 'package:dotto/domain/entity/pdf_document.dart';

abstract interface class PdfRepository {
  Future<PdfDocument> download(
    String url, {
    String? filename,
    bool isPastExam = false,
  });
  Future<void> release(PdfDocument document);
  Future<void> share(
    PdfDocument document, {
    ({double left, double top, double width, double height})? origin,
  });
}
