import 'dart:io';

import 'package:dotto/data/pdf_data_source.dart';
import 'package:dotto/domain/entity/domain_error.dart';
import 'package:dotto/domain/entity/pdf_document.dart';
import 'package:dotto/domain/repository/pdf_repository.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'pdf_repository_impl.g.dart';

@riverpod
PdfRepository pdfRepository(Ref ref) => PdfRepositoryImpl(
  ref.watch(pdfHttpClientProvider),
  ref.watch(pdfDataSourceProvider),
);

final class PdfRepositoryImpl implements PdfRepository {
  const new(this._client, this._files);
  final http.Client _client;
  final PdfDataSource _files;
  @override
  Future<PdfDocument> download(
    String url, {
    String? filename,
    bool isPastExam = false,
  }) async {
    Directory? directory;
    try {
      final uri = Uri.parse(url);
      final bytes = isPastExam
          ? await _files.fetchPastExam(url)
          : await _downloadWeb(uri);
      directory = await _files.createDirectory();
      final basename = path.basename(uri.path);
      final title = filename ?? (basename.isEmpty ? 'document.pdf' : basename);
      final file = File(path.join(directory.path, path.basename(title)));
      await file.writeAsBytes(bytes);
      return PdfDocument(path: file.path, title: title);
    } on Exception catch (error, stack) {
      if (directory != null) await directory.delete(recursive: true);
      if (error is DomainError) rethrow;
      throw DomainError.fromException(e: error, stackTrace: stack);
    }
  }

  Future<List<int>> _downloadWeb(Uri uri) async {
    final response = await _client.get(uri);
    if (response.statusCode != HttpStatus.ok) {
      throw const DomainError(
        type: DomainErrorType.network,
        message: 'PDFをダウンロードできませんでした',
      );
    }
    return response.bodyBytes;
  }

  @override
  Future<void> release(PdfDocument document) async {
    try {
      final directory = File(document.path).parent;
      if (directory.existsSync()) await directory.delete(recursive: true);
    } on Exception catch (error, stack) {
      throw DomainError.fromException(e: error, stackTrace: stack);
    }
  }

  @override
  Future<void> share(
    PdfDocument document, {
    ({double left, double top, double width, double height})? origin,
  }) async {
    try {
      await _files.share(document.path, origin: origin);
    } on Exception catch (error, stack) {
      throw DomainError.fromException(e: error, stackTrace: stack);
    }
  }
}
