import 'package:dotto/data/pdf_repository_impl.dart';
import 'package:dotto/domain/entity/pdf_document.dart';
import 'package:dotto/domain/repository/pdf_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'download_pdf_use_case.g.dart';

final class DownloadPdfUseCase {
  const new(this._repository);
  final PdfRepository _repository;
  Future<PdfDocument> call(
    String url, {
    String? filename,
    bool isPastExam = false,
  }) => _repository.download(url, filename: filename, isPastExam: isPastExam);
}

@riverpod
DownloadPdfUseCase downloadPdfUseCase(Ref ref) =>
    DownloadPdfUseCase(ref.watch(pdfRepositoryProvider));
