import 'package:dotto/domain/entity/geo_coordinate.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'geo_polygon.freezed.dart';

/// 外周と穴からなる多角形。
@freezed
abstract class GeoPolygon with _$GeoPolygon {
  /// [rings] の先頭が外周、以降が穴。各リングは始点と終点が一致する。
  const factory({required List<List<GeoCoordinate>> rings}) = _GeoPolygon;

  const new _();

  /// 外周。
  List<GeoCoordinate> get exterior => rings.isEmpty ? const [] : rings.first;
}
