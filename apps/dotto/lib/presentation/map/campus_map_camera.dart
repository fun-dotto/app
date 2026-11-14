import 'dart:math' as math;

import 'package:dotto/domain/entity/geo_coordinate.dart';

/// 建物の軸の向き (北から時計回りの角度)。
///
/// 建物が画面に正対するように、地図をこの角度だけ回転して表示する。
const campusMapBearing = 25.3;

/// [coordinates] を [bearing] だけ回転した画面上で囲む範囲 (メートル)。
({GeoCoordinate center, double width, double height}) campusMapExtent(
  List<GeoCoordinate> coordinates, {
  double bearing = campusMapBearing,
}) {
  const earthRadius = 6378137.0;
  final origin = coordinates.first;
  final cosLat = math.cos(origin.latitude * math.pi / 180);
  final theta = bearing * math.pi / 180;
  var minX = double.infinity;
  var minY = double.infinity;
  var maxX = double.negativeInfinity;
  var maxY = double.negativeInfinity;
  for (final c in coordinates) {
    final e =
        (c.longitude - origin.longitude) * math.pi / 180 * earthRadius * cosLat;
    final n = (c.latitude - origin.latitude) * math.pi / 180 * earthRadius;
    // 画面の右 (x) と上 (y) の向きに射影する。
    final x = e * math.cos(theta) - n * math.sin(theta);
    final y = e * math.sin(theta) + n * math.cos(theta);
    minX = math.min(minX, x);
    maxX = math.max(maxX, x);
    minY = math.min(minY, y);
    maxY = math.max(maxY, y);
  }
  final cx = (minX + maxX) / 2;
  final cy = (minY + maxY) / 2;
  final e = cx * math.cos(theta) + cy * math.sin(theta);
  final n = -cx * math.sin(theta) + cy * math.cos(theta);
  return (
    center: GeoCoordinate(
      latitude: origin.latitude + n / earthRadius * 180 / math.pi,
      longitude: origin.longitude + e / (earthRadius * cosLat) * 180 / math.pi,
    ),
    width: maxX - minX,
    height: maxY - minY,
  );
}

/// [coordinates] を [width] x [height] (論理ピクセル) に収める MapLibre のズーム。
double campusMapZoomToFit(
  List<GeoCoordinate> coordinates, {
  required double width,
  required double height,
}) {
  final extent = campusMapExtent(coordinates);
  // MapLibre のズーム 0 は 512 px で地球 1 周。
  const metersPerPixelAtZoom0 = 2 * math.pi * 6378137 / 512;
  final metersPerPixel = math.max(extent.width / width, extent.height / height);
  return math.log(
        metersPerPixelAtZoom0 *
            math.cos(extent.center.latitude * math.pi / 180) /
            metersPerPixel,
      ) /
      math.ln2;
}
