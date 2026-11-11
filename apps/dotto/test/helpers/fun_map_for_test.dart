import 'dart:convert';
import 'dart:io';

import 'package:dotto/presentation/map/fun_map.dart';
import 'package:dotto/presentation/map/imdf.dart';

/// ウィジェットテストではアセットの非同期読み込みが完了しないため、
/// IMDF から復元したタイルを同期的に読み込む。
FUNMap loadFunMapForTest() => loadImdfForTest().funMap;

/// IMDF をファイルから同期的に読み込む。
Imdf loadImdfForTest() {
  Map<String, Object?> load(String name) =>
      jsonDecode(File('assets/map/imdf/$name.geojson').readAsStringSync())
          as Map<String, Object?>;
  return Imdf.fromJson(
    footprint: load('footprint'),
    level: load('level'),
    unit: load('unit'),
  );
}
