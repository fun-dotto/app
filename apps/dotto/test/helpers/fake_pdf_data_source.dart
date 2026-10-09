import 'dart:io';

import 'package:dotto/data/pdf_data_source.dart';

/// 一時ディレクトリと共有結果をテスト内で管理する。
final class FakePdfDataSource implements PdfDataSource {
  new(this.directory);
  final Directory directory;
  String? sharedPath;
  @override
  Future<List<int>> fetchPastExam(String key) async =>
      '%PDF-past-exam'.codeUnits;
  @override
  Future<Directory> createDirectory() => directory.createTemp('dotto-pdf-');
  @override
  Future<void> share(
    String path, {
    ({double left, double top, double width, double height})? origin,
  }) async {
    sharedPath = path;
  }
}
