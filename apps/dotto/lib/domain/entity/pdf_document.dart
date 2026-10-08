import 'package:freezed_annotation/freezed_annotation.dart';
part 'pdf_document.freezed.dart';

@freezed
abstract class PdfDocument with _$PdfDocument {
  const factory({required String path, required String title}) = _PdfDocument;
}
