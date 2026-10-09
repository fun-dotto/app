import 'package:dotto/data/pdf_repository_impl.dart';
import 'package:dotto/domain/entity/pdf_document.dart';
import 'package:dotto/domain/repository/pdf_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'release_pdf_use_case.g.dart';

final class ReleasePdfUseCase {
  const new(this._repository);
  final PdfRepository _repository;
  Future<void> call(PdfDocument document) => _repository.release(document);
}

@riverpod
ReleasePdfUseCase releasePdfUseCase(Ref ref) =>
    ReleasePdfUseCase(ref.watch(pdfRepositoryProvider));
