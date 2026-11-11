import 'dart:convert';

import 'package:dotto/asset.dart';
import 'package:flutter/services.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'campus_map_data_source.g.dart';

@riverpod
CampusMapDataSource campusMapDataSource(Ref ref) =>
    const AssetCampusMapDataSource();

/// キャンパスマップの IMDF の読み取り境界。
abstract interface class CampusMapDataSource {
  /// IMDF の [featureType] (`unit` など) の FeatureCollection。
  Future<Map<String, Object?>> fetchFeatureCollection(String featureType);
}

/// アプリに同梱した IMDF を読む。
final class AssetCampusMapDataSource implements CampusMapDataSource {
  const new();

  @override
  Future<Map<String, Object?>> fetchFeatureCollection(
    String featureType,
  ) async => jsonDecode(
    await rootBundle.loadString('${Asset.imdf}/$featureType.geojson'),
  ) as Map<String, Object?>;
}
