import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'local_file_data_source.g.dart';

@riverpod
LocalFileDataSource localFileDataSource(Ref ref) => const LocalFileDataSource();

final class LocalFileDataSource {
  const new();
  Future<String> getApplicationFilePath(String path) async {
    final appDocDir = await getTemporaryDirectory();
    final fullPath = join(appDocDir.path, path);
    await Directory(dirname(fullPath)).create(recursive: true);
    return fullPath;
  }

  Future<List<dynamic>> getJSONData(String path) async {
    final filePath = await getApplicationFilePath(path);
    final file = File(filePath);
    if (!file.existsSync()) {
      throw FileSystemException('File not found', filePath);
    }
    const maxAttempts = 3;
    const retryDelay = Duration(milliseconds: 100);
    for (var attempt = 0; attempt < maxAttempts; attempt++) {
      final jsonString = await file.readAsString();
      if (jsonString.trim().isEmpty) {
        if (attempt < maxAttempts - 1) {
          await Future<void>.delayed(retryDelay);
          continue;
        } else {
          throw const FormatException('Empty JSON content');
        }
      }
      try {
        final decoded = jsonDecode(jsonString);
        if (decoded is List<dynamic>) {
          return decoded;
        } else {
          throw const FormatException('JSON content is not a List');
        }
      } on FormatException {
        if (attempt < maxAttempts - 1) {
          await Future<void>.delayed(retryDelay);
          continue;
        } else {
          rethrow;
        }
      }
    }
    throw const FormatException('Failed to read JSON data');
  }
}
