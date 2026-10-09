import 'dart:io';

import 'package:dotto/asset.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common/sqflite_logger.dart';

part 'syllabus_database_data_source.g.dart';

@riverpod
SyllabusDatabaseDataSource syllabusDatabaseDataSource(Ref ref) =>
    const SyllabusDatabaseDataSource();

final class SyllabusDatabaseDataSource {
  const new();
  Future<Database> getDatabase() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'syllabus.db');
    final exists = await databaseExists(path);
    if (!exists) {
      debugPrint('Creating new copy from asset');
      await Directory(dirname(path)).create(recursive: true);
      final data = await rootBundle.load(Asset.syllabus);
      final bytes = data.buffer.asUint8List(
        data.offsetInBytes,
        data.lengthInBytes,
      );
      await File(path).writeAsBytes(bytes, flush: true);
    } else {
      debugPrint('Database already exists');
    }
    debugPrint('Opening database: $path');
    if (kDebugMode) {
      // TODO(kantacky): なんとかする
      // ignore: experimental_member_use
      final dbFactory = SqfliteDatabaseFactoryLogger(
        databaseFactory,
        options: SqfliteLoggerOptions(
          type: SqfliteDatabaseFactoryLoggerType.all,
        ),
      );
      return await dbFactory.openDatabase(path);
    }
    return await openDatabase(path, readOnly: true);
  }
}
