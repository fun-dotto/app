import 'package:dotto/data/pdf_repository_impl.dart';
import 'package:dotto/domain/entity/pdf_document.dart';
import 'package:dotto/domain/repository/pdf_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'share_pdf_use_case.g.dart';

final class SharePdfUseCase {
  const new(this._repository);
  final PdfRepository _repository;
  Future<void> call(
    PdfDocument document, {
    ({double left, double top, double width, double height})? origin,
  }) => _repository.share(document, origin: origin);
}

@riverpod
SharePdfUseCase sharePdfUseCase(Ref ref) =>
    SharePdfUseCase(ref.watch(pdfRepositoryProvider));
