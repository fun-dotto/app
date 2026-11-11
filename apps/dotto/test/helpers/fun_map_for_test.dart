import 'dart:convert';
import 'dart:io';

import 'package:dotto/asset.dart';
import 'package:dotto/presentation/map/fun_map.dart';
import 'package:dotto/presentation/map/imdf.dart';

/// ウィジェットテストではアセットの非同期読み込みが完了しないため、
/// GeoJSON をファイルから同期的に読み込む。
FUNMap loadFunMapForTest() => FUNMap.fromGeoJson(
  jsonDecode(File(Asset.funMapGeoJson).readAsStringSync())
      as Map<String, Object?>,
);

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
