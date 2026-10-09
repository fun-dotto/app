import 'dart:io';

import 'package:dotto/helper/s3_repository.dart';
import 'package:http/http.dart' as http;
import 'package:material_ui/material_ui.dart' show Rect;
import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:share_plus/share_plus.dart';

part 'pdf_data_source.g.dart';

@riverpod
http.Client pdfHttpClient(Ref ref) {
  final client = http.Client();
  ref.onDispose(client.close);
  return client;
}

@riverpod
PdfDataSource pdfDataSource(Ref ref) => const PdfDataSource();

/// PDF一時ファイルとOS共有へのアクセスを提供する。
class PdfDataSource {
  const new();
  Future<Directory> createDirectory() async =>
      await (await getTemporaryDirectory()).createTemp('dotto-pdf-');
  Future<List<int>> fetchPastExam(String key) async {
    final stream = await S3Repository().getObject(url: key);
    return await stream.fold<List<int>>(
      [],
      (bytes, chunk) => bytes..addAll(chunk),
    );
  }

  Future<void> share(
    String path, {
    ({double left, double top, double width, double height})? origin,
  }) async {
    await SharePlus.instance.share(
      ShareParams(
        files: [XFile(path)],
        sharePositionOrigin: switch (origin) {
          (:final left, :final top, :final width, :final height) =>
            Rect.fromLTWH(left, top, width, height),
          null => null,
        },
      ),
    );
  }
}
