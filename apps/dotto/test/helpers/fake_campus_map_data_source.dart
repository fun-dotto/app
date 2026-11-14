import 'dart:convert';
import 'dart:io';

import 'package:dotto/data/campus_map_data_source.dart';

/// 同梱の IMDF をファイルから読む。
///
/// ウィジェットテストではアセットの非同期読み込みが完了しないため、
/// ファイルを同期的に読む。
final class FakeCampusMapDataSource implements CampusMapDataSource {
  const new();

  @override
  Future<Map<String, Object?>> fetchFeatureCollection(String featureType) {
    final json = jsonDecode(
      File('assets/map/imdf/$featureType.geojson').readAsStringSync(),
    ) as Map<String, Object?>;
    return Future.value(json);
  }
}
