import 'dart:convert';
import 'dart:io';

import 'package:dotto/asset.dart';
import 'package:dotto/presentation/map/fun_map.dart';

/// ウィジェットテストではアセットの非同期読み込みが完了しないため、
/// GeoJSON をファイルから同期的に読み込む。
FUNMap loadFunMapForTest() => FUNMap.fromGeoJson(
  jsonDecode(File(Asset.funMapGeoJson).readAsStringSync())
      as Map<String, Object?>,
);
