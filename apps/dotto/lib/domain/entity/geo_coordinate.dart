import 'package:freezed_annotation/freezed_annotation.dart';

part 'geo_coordinate.freezed.dart';

/// 緯度・経度 (WGS 84)。
@freezed
abstract class GeoCoordinate with _$GeoCoordinate {
  const factory({required double latitude, required double longitude}) =
      _GeoCoordinate;
}
