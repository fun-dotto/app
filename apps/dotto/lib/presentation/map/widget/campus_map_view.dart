import 'dart:async';
import 'dart:convert';
import 'dart:math' as math;

import 'package:collection/collection.dart';
import 'package:dotto/domain/entity/campus_map.dart';
import 'package:dotto/domain/entity/campus_map_unit.dart';
import 'package:dotto/domain/entity/floor.dart';
import 'package:dotto/domain/entity/geo_polygon.dart';
import 'package:dotto/domain/entity/room.dart';
import 'package:dotto/presentation/map/campus_map_camera.dart';
import 'package:dotto/presentation/map/campus_map_unit_style.dart';
import 'package:dotto_design_system/style/map_colors.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:maplibre_gl/maplibre_gl.dart';
import 'package:material_ui/material_ui.dart';

typedef _Json = Map<String, Object?>;

const _unitSource = 'units';
const _unitFillLayer = 'unit-fill';

/// キャンパスマップを MapLibre で描画する。
final class CampusMapView extends HookWidget {
  const new({
    required this.campusMap,
    required this.selectedFloor,
    required this.rooms,
    required this.focusedUnit,
    required this.dateTime,
    required this.onTapped,
    super.key,
  });

  final CampusMap campusMap;
  final Floor selectedFloor;
  final List<Room> rooms;
  final CampusMapUnit? focusedUnit;
  final DateTime dateTime;
  final void Function(CampusMapUnit, Room?)? onTapped;

  Room? _roomOf(CampusMapUnit unit) =>
      rooms.firstWhereOrNull((e) => e.id == unit.roomId);

  @override
  Widget build(BuildContext context) {
    final controller = useState<MapLibreMapController?>(null);
    final isStyleLoaded = useState(false);
    final size = useRef(Size.zero);
    final cameraFloor = useRef<Floor?>(null);
    final units = useMemoized(
      () => campusMap.unitsOf(selectedFloor).toList(growable: false),
      [campusMap, selectedFloor],
    );

    CameraPosition cameraPosition() {
      final outline = campusMap.floors[selectedFloor]?.exterior ?? const [];
      if (outline.isEmpty || size.value.isEmpty) {
        return const CameraPosition(
          target: LatLng(41.8418, 140.7667),
          zoom: 17,
        );
      }
      final center = campusMapExtent(outline).center;
      return CameraPosition(
        target: LatLng(center.latitude, center.longitude),
        zoom: campusMapZoomToFit(
          outline,
          width: size.value.width - 32,
          height: size.value.height - 32,
        ),
        bearing: campusMapBearing,
      );
    }

    // 階を切り替えたら、その階が収まるようにカメラを動かす。
    useEffect(() {
      final c = controller.value;
      if (c == null || !isStyleLoaded.value) return null;
      final update = CameraUpdate.newCameraPosition(cameraPosition());
      unawaited(
        cameraFloor.value == null
            ? c.moveCamera(update)
            : c.animateCamera(update),
      );
      cameraFloor.value = selectedFloor;
      return null;
    }, [controller.value, isStyleLoaded.value, selectedFloor]);

    useEffect(
      () {
        final c = controller.value;
        if (c == null || !isStyleLoaded.value) return null;
        unawaited(
          c.setGeoJsonSource(_unitSource, {
            'type': 'FeatureCollection',
            'features': [
              for (final unit in units)
                _unitFeature(
                  unit,
                  room: _roomOf(unit),
                  isFocused: unit.id == focusedUnit?.id,
                ),
            ],
          }),
        );
        return null;
      },
      [
        controller.value,
        isStyleLoaded.value,
        units,
        rooms,
        focusedUnit,
        dateTime,
      ],
    );

    Future<void> onMapClick(math.Point<double> point) async {
      final c = controller.value;
      if (c == null) return;
      final features = await c.queryRenderedFeatures(point, [
        _unitFillLayer,
      ], null);
      final id = features
          .cast<Map<Object?, Object?>>()
          .map((f) => (f['properties']! as Map<Object?, Object?>)['id'])
          .whereType<String>()
          .firstOrNull;
      final unit = units.firstWhereOrNull((e) => e.id == id);
      if (unit == null || !context.mounted) return;
      onTapped?.call(unit, _roomOf(unit));
    }

    final style = useMemoized(() => _style(campusMap), [campusMap]);
    return LayoutBuilder(
      builder: (context, constraints) {
        size.value = constraints.biggest;
        return MapLibreMap(
          styleString: style,
          initialCameraPosition: cameraPosition(),
          onMapCreated: (c) => controller.value = c,
          onStyleLoadedCallback: () => isStyleLoaded.value = true,
          onMapClick: (point, _) => unawaited(onMapClick(point)),
          tiltGesturesEnabled: false,
          compassEnabled: false,
          minMaxZoomPreference: const MinMaxZoomPreference(15, 22),
          attributionButtonMargins: const math.Point(-100, -100),
        );
      },
    );
  }

  _Json _unitFeature(
    CampusMapUnit unit, {
    required Room? room,
    required bool isFocused,
  }) {
    final inUse = room?.isInUse(dateTime) ?? false;
    final fill = isFocused
        ? MapColors.focusedTile
        : inUse
        ? MapColors.roomInUseTile
        : unit.kind.backgroundColor;
    final label = isFocused
        ? MapColors.invertedForeground
        : inUse
        ? MapColors.foreground
        : unit.kind.foregroundColor;
    return {
      'type': 'Feature',
      'geometry': _geometry(unit.polygon),
      'properties': {
        'id': unit.id,
        'fill': _hex(fill),
        'fillOpacity': fill.a,
        'stroke': _hex(
          isFocused ? MapColors.focusedTile : MapColors.foreground,
        ),
        'strokeWidth': isFocused ? 2.0 : (unit.hasBorder ? 1.0 : 0.3),
        'label': room?.shortName ?? unit.label ?? unit.symbol,
        'labelColor': _hex(label),
        'sortKey': isFocused ? 1 : 0,
      },
    };
  }
}

_Json _geometry(GeoPolygon polygon) => {
  'type': 'Polygon',
  'coordinates': [
    for (final ring in polygon.rings)
      [
        for (final c in ring) [c.longitude, c.latitude],
      ],
  ],
};

String _hex(Color color) =>
    '#${(color.toARGB32() & 0xFFFFFF).toRadixString(16).padLeft(6, '0')}';

/// 地図タイルを使わない、建物の外形と区画だけのスタイル。
String _style(CampusMap campusMap) => jsonEncode({
  'version': 8,
  // 英数字のラベル用。日本語は端末のフォントで描画される。
  'glyphs': 'https://demotiles.maplibre.org/font/{fontstack}/{range}.pbf',
  'sources': {
    'buildings': {
      'type': 'geojson',
      'data': {
        'type': 'FeatureCollection',
        'features': [
          for (final building in campusMap.buildings)
            {'type': 'Feature', 'geometry': _geometry(building)},
        ],
      },
    },
    _unitSource: {
      'type': 'geojson',
      'data': {'type': 'FeatureCollection', 'features': <Object>[]},
    },
  },
  'layers': [
    {
      'id': 'background',
      'type': 'background',
      'paint': {'background-color': '#f5f5f5'},
    },
    {
      'id': 'building-fill',
      'type': 'fill',
      'source': 'buildings',
      'paint': {'fill-color': '#ffffff'},
    },
    {
      'id': 'building-line',
      'type': 'line',
      'source': 'buildings',
      'paint': {'line-color': '#9e9e9e', 'line-width': 1},
    },
    {
      'id': _unitFillLayer,
      'type': 'fill',
      'source': _unitSource,
      'paint': {
        'fill-color': ['get', 'fill'],
        'fill-opacity': ['get', 'fillOpacity'],
      },
    },
    {
      'id': 'unit-line',
      'type': 'line',
      'source': _unitSource,
      'layout': {
        'line-sort-key': ['get', 'sortKey'],
      },
      'paint': {
        'line-color': ['get', 'stroke'],
        'line-width': ['get', 'strokeWidth'],
      },
    },
    {
      'id': 'unit-label',
      'type': 'symbol',
      'source': _unitSource,
      'layout': {
        'text-field': ['get', 'label'],
        'text-font': ['Open Sans Semibold'],
        'text-size': [
          'interpolate',
          ['linear'],
          ['zoom'],
          17,
          8,
          20,
          16,
        ],
        'text-max-width': 5,
      },
      'paint': {
        'text-color': ['get', 'labelColor'],
      },
    },
  ],
});
