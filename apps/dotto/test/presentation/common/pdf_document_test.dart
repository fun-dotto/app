import 'dart:io';

import 'package:dotto/application/download_pdf_use_case.dart';
import 'package:dotto/application/release_pdf_use_case.dart';
import 'package:dotto/application/share_pdf_use_case.dart';
import 'package:dotto/data/pdf_repository_impl.dart';
import 'package:dotto/domain/entity/domain_error.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

import '../../helpers/fake_pdf_data_source.dart';

void main() {
  late Directory directory;
  late FakePdfDataSource files;
  setUp(() {
    directory = Directory.systemTemp.createTempSync('dotto-pdf-test-');
    files = FakePdfDataSource(directory);
  });
  tearDown(() => directory.deleteSync(recursive: true));

  test('指定された名前でPDFを保存し閲覧用ファイルを返す', () async {
    final repository = PdfRepositoryImpl(
      MockClient((_) async => http.Response('%PDF-content', 200)),
      files,
    );

    final document = await DownloadPdfUseCase(repository)(
      'https://example.com/document.pdf',
      filename: '時間割.pdf',
    );

    expect(document.title, '時間割.pdf');
    expect(File(document.path).readAsStringSync(), '%PDF-content');
  });

  test('過去問は保存先から取得して同じPDF閲覧用ファイルに変換する', () async {
    final repository = PdfRepositoryImpl(
      MockClient((_) async => http.Response('HTTPを使わない', 500)),
      files,
    );

    final document = await DownloadPdfUseCase(repository)(
      'past-exams/math.pdf',
      isPastExam: true,
    );

    expect(document.title, 'math.pdf');
    expect(File(document.path).readAsStringSync(), '%PDF-past-exam');
  });

  test('取得したPDFを共有してから専用一時ファイルを削除できる', () async {
    final repository = PdfRepositoryImpl(
      MockClient((_) async => http.Response('%PDF-content', 200)),
      files,
    );
    final document = await DownloadPdfUseCase(repository)(
      'https://example.com/document.pdf',
    );

    await SharePdfUseCase(repository)(document);
    expect(files.sharedPath, document.path);
    await ReleasePdfUseCase(repository)(document);

    expect(File(document.path).existsSync(), isFalse);
    expect(directory.existsSync(), isTrue);
  });

  test('ダウンロード失敗はドメインエラーとして通知する', () async {
    final repository = PdfRepositoryImpl(
      MockClient((_) async => http.Response('error', 503)),
      files,
    );

    await expectLater(
      DownloadPdfUseCase(repository)('https://example.com/document.pdf'),
      throwsA(isA<DomainError>()),
    );

    expect(directory.listSync(), isEmpty);
  });
}
