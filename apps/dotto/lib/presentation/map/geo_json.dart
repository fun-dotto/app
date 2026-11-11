import 'dart:math' as math;

/// マップの描画に必要な範囲の GeoJSON (RFC 7946) モデル。
///
/// 座標は地理座標ではなく、マップ固有の平面座標
/// (原点は左上、x 軸は右向き、y 軸は下向き) として扱う。
final class GeoJsonFeatureCollection {
  const new({required this.features, this.bbox});

  factory fromJson(Map<String, Object?> json) {
    if (json['type'] != 'FeatureCollection') {
      throw FormatException('Not a FeatureCollection: ${json['type']}');
    }
    final features = json['features'];
    if (features is! List) {
      throw const FormatException('FeatureCollection has no features');
    }
    return GeoJsonFeatureCollection(
      features: List.unmodifiable(
        features.cast<Map<String, Object?>>().map(GeoJsonFeature.fromJson),
      ),
      bbox: GeoJsonBoundingBox.tryParse(json['bbox']),
    );
  }

  final List<GeoJsonFeature> features;
  final GeoJsonBoundingBox? bbox;
}

final class GeoJsonFeature {
  const new({required this.geometry, required this.properties, this.id});

  factory fromJson(Map<String, Object?> json) {
    if (json['type'] != 'Feature') {
      throw FormatException('Not a Feature: ${json['type']}');
    }
    return GeoJsonFeature(
      id: json['id'],
      geometry: GeoJsonGeometry.fromJson(
        json['geometry']! as Map<String, Object?>,
      ),
      properties: Map.unmodifiable(
        (json['properties'] as Map<String, Object?>?) ?? const {},
      ),
    );
  }

  final Object? id;
  final GeoJsonGeometry geometry;
  final Map<String, Object?> properties;
}

sealed class GeoJsonGeometry {
  const new();

  factory fromJson(Map<String, Object?> json) {
    final coordinates = json['coordinates'];
    return switch (json['type']) {
      'Point' => GeoJsonPoint(_position(coordinates)),
      'Polygon' => GeoJsonPolygon(_rings(coordinates)),
      'MultiPolygon' => GeoJsonMultiPolygon(
        (coordinates! as List).map(_rings).toList(growable: false),
      ),
      final type => throw FormatException('Unsupported geometry: $type'),
    };
  }

  /// ジオメトリ全体を囲む矩形。
  GeoJsonBoundingBox get bounds;

  static GeoJsonPosition _position(Object? json) {
    final list = json! as List;
    return (x: (list[0]! as num).toDouble(), y: (list[1]! as num).toDouble());
  }

  static List<List<GeoJsonPosition>> _rings(Object? json) => (json! as List)
      .map((ring) => (ring! as List).map(_position).toList(growable: false))
      .toList(growable: false);
}

typedef GeoJsonPosition = ({double x, double y});

final class GeoJsonPoint extends GeoJsonGeometry {
  const new(this.position);

  final GeoJsonPosition position;

  @override
  GeoJsonBoundingBox get bounds => GeoJsonBoundingBox.fromPositions([position]);
}

final class GeoJsonPolygon extends GeoJsonGeometry {
  const new(this.rings);

  /// 先頭が外周、以降が穴。
  final List<List<GeoJsonPosition>> rings;

  @override
  GeoJsonBoundingBox get bounds =>
      GeoJsonBoundingBox.fromPositions(rings.first);
}

final class GeoJsonMultiPolygon extends GeoJsonGeometry {
  const new(this.polygons);

  final List<List<List<GeoJsonPosition>>> polygons;

  @override
  GeoJsonBoundingBox get bounds =>
      GeoJsonBoundingBox.fromPositions(polygons.expand((rings) => rings.first));
}

final class GeoJsonBoundingBox {
  const new({
    required this.minX,
    required this.minY,
    required this.maxX,
    required this.maxY,
  });

  factory fromPositions(Iterable<GeoJsonPosition> list) {
    var minX = double.infinity;
    var minY = double.infinity;
    var maxX = double.negativeInfinity;
    var maxY = double.negativeInfinity;
    for (final p in list) {
      minX = math.min(minX, p.x);
      minY = math.min(minY, p.y);
      maxX = math.max(maxX, p.x);
      maxY = math.max(maxY, p.y);
    }
    return GeoJsonBoundingBox(minX: minX, minY: minY, maxX: maxX, maxY: maxY);
  }

  static GeoJsonBoundingBox? tryParse(Object? json) {
    if (json is! List || json.length < 4) return null;
    final v = json.cast<num>();
    return GeoJsonBoundingBox(
      minX: v[0].toDouble(),
      minY: v[1].toDouble(),
      maxX: v[2].toDouble(),
      maxY: v[3].toDouble(),
    );
  }

  final double minX;
  final double minY;
  final double maxX;
  final double maxY;

  double get width => maxX - minX;
  double get height => maxY - minY;

  GeoJsonBoundingBox union(GeoJsonBoundingBox other) => GeoJsonBoundingBox(
    minX: math.min(minX, other.minX),
    minY: math.min(minY, other.minY),
    maxX: math.max(maxX, other.maxX),
    maxY: math.max(maxY, other.maxY),
  );
}
