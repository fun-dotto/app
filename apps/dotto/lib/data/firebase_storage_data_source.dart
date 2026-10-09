import 'dart:io';
import 'dart:typed_data';

import 'package:dotto/data/local_file_data_source.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'firebase_storage_data_source.g.dart';

@Riverpod(keepAlive: true)
FirebaseStorage firebaseStorageClient(Ref ref) => FirebaseStorage.instance;
@riverpod
FirebaseStorageDataSource firebaseStorageDataSource(Ref ref) =>
    FirebaseStorageDataSource(
      ref.watch(firebaseStorageClientProvider),
      ref.watch(localFileDataSourceProvider),
    );

final class FirebaseStorageDataSource {
  const new(this._storage, this._files);
  final FirebaseStorage _storage;
  final LocalFileDataSource _files;
  static const String _baseUrl = 'gs://swift2023groupc.appspot.com';

  Future<void> download(String path) async {
    final ref = _storage.refFromURL('$_baseUrl/$path');
    final localPath = await _files.getApplicationFilePath(path);
    final file = File(localPath);
    if (!file.existsSync()) {
      await file.create();
    }
    await ref.writeToFile(file);
  }

  Future<Uint8List?> getData(String path) async {
    final ref = _storage.refFromURL('$_baseUrl/$path');
    return await ref.getData();
  }
}
