import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'dart:core' as core;
import 'dart:math' as math;

import 'package:collection/collection.dart';
import 'package:dotto/domain/entity/floor.dart';
import 'package:dotto/domain/entity/room.dart';
import 'package:dotto/presentation/map/imdf.dart';
import 'package:dotto/presentation/map/map_tile_props.dart';
import 'package:dotto_design_system/style/map_colors.dart';
import 'package:maplibre_gl/maplibre_gl.dart';
import 'package:material_ui/material_ui.dart';

/// IMDF を MapLibre で描画するキャンパスマップ。
final class Map extends StatefulWidget {
  const new({
    required this.imdf,
    required this.selectedFloor,
    required this.tileProps,
    required this.rooms,
    required this.focusedMapTileProps,
    required this.dateTime,
    required this.onTapped,
    super.key,
  });

  final Imdf imdf;
  final Floor selectedFloor;
  final List<MapTileProps> tileProps;
  final List<Room> rooms;
  final MapTileProps? focusedMapTileProps;
  final DateTime dateTime;
  final void Function(MapTileProps, Room?)? onTapped;

  @override
  State<Map> createState() => _MapState();
}

const _unitSource = 'units';
const _unitFillLayer = 'unit-fill';

final class _MapState extends State<Map> {
  MapLibreMapController? _controller;
  bool _styleLoaded = false;
  Size _size = Size.zero;

  /// 表示中の階のタイル (unit の `index` プロパティで参照する)。
  List<MapTileProps> _visibleTiles = const [];

  @override
  void didUpdateWidget(Map oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedFloor != widget.selectedFloor) {
      unawaited(_moveCamera(animate: true));
    }
    unawaited(_updateUnits());
  }

  Room? _roomOf(MapTileProps props) =>
      widget.rooms.firstWhereOrNull((e) => e.id == props.id);

  Json _unitCollection() {
    final focused = widget.focusedMapTileProps;
    _visibleTiles = widget.tileProps
        .where((e) => e.floor == widget.selectedFloor)
        .toList(growable: false);
    return {
      'type': 'FeatureCollection',
      'features': [
        for (final (i, props) in _visibleTiles.indexed)
          if (widget.imdf.unitOf(props) case final unit?)
            _unitFeature(i, props, unit, isFocused: props == focused),
      ],
    };
  }

  Json _unitFeature(
    int index,
    MapTileProps props,
    Json unit, {
    required bool isFocused,
  }) {
    final room = _roomOf(props);
    final inUse = room?.isInUse(widget.dateTime) ?? false;
    final fill = isFocused
        ? MapColors.focusedTile
        : inUse
        ? MapColors.roomInUseTile
        : props.backgroundColor;
    final label = isFocused
        ? MapColors.invertedForeground
        : inUse
        ? MapColors.foreground
        : props.foregroundColor;
    final hasBorder =
        props.top > 0 ||
        props.right > 0 ||
        props.bottom > 0 ||
        props.left > 0 ||
        props.outline > 0;
    return {
      'type': 'Feature',
      'id': index,
      'geometry': unit['geometry'],
      'properties': {
        'index': index,
        'fill': _hex(fill),
        'fillOpacity': fill.a,
        'stroke': _hex(
          isFocused ? MapColors.focusedTile : MapColors.foreground,
        ),
        'strokeWidth': isFocused ? 2.0 : (hasBorder ? 1.0 : 0.3),
        'label': room?.shortName ?? props.label ?? _symbolOf(props),
        'labelColor': _hex(label),
        'sortKey': isFocused ? 1 : 0,
      },
    };
  }

  Future<void> _updateUnits() async {
    final controller = _controller;
    if (controller == null || !_styleLoaded) return;
    await controller.setGeoJsonSource(_unitSource, _unitCollection());
  }

  CameraPosition _cameraPosition() {
    final outline = widget.imdf.levelOutline(widget.selectedFloor);
    if (outline.isEmpty || _size.isEmpty) {
      return const CameraPosition(target: LatLng(41.8418, 140.7667), zoom: 17);
    }
    final extent = imdfExtent(outline);
    // MapLibre のズーム 0 は 512 px で地球 1 周。
    const metersPerPixelAtZoom0 = 2 * math.pi * 6378137 / 512;
    final metersPerPixel = math.max(
      extent.width / (_size.width - 32),
      extent.height / (_size.height - 32),
    );
    final zoom =
        math.log(
          metersPerPixelAtZoom0 *
              math.cos(extent.center.lat * math.pi / 180) /
              metersPerPixel,
        ) /
        math.ln2;
    return CameraPosition(
      target: LatLng(extent.center.lat, extent.center.lng),
      zoom: zoom,
      bearing: imdfBuildingBearing,
    );
  }

  Future<void> _moveCamera({required bool animate}) async {
    final controller = _controller;
    if (controller == null) return;
    final update = CameraUpdate.newCameraPosition(_cameraPosition());
    if (animate) {
      await controller.animateCamera(update);
    } else {
      await controller.moveCamera(update);
    }
  }

  Future<void> _onStyleLoaded() async {
    _styleLoaded = true;
    await _moveCamera(animate: false);
    await _updateUnits();
  }

  Future<void> _onMapClick(math.Point<double> point, LatLng _) async {
    final controller = _controller;
    if (controller == null) return;
    final features = await controller.queryRenderedFeatures(point, [
      _unitFillLayer,
    ], null);
    final index = features
        .cast<core.Map<Object?, Object?>>()
        .map((f) => (f['properties']! as core.Map<Object?, Object?>)['index'])
        .whereType<num>()
        .firstOrNull;
    if (index == null || !mounted) return;
    final props = _visibleTiles.elementAtOrNull(index.toInt());
    if (props == null) return;
    widget.onTapped?.call(props, _roomOf(props));
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        _size = constraints.biggest;
        return MapLibreMap(
          styleString: _style(widget.imdf),
          initialCameraPosition: _cameraPosition(),
          onMapCreated: (controller) => _controller = controller,
          onStyleLoadedCallback: () => unawaited(_onStyleLoaded()),
          onMapClick: (point, latLng) => unawaited(_onMapClick(point, latLng)),
          tiltGesturesEnabled: false,
          compassEnabled: false,
          minMaxZoomPreference: const MinMaxZoomPreference(15, 22),
          attributionButtonMargins: const math.Point(-100, -100),
        );
      },
    );
  }
}

String? _symbolOf(MapTileProps props) => switch (props) {
  ElevatorMapTileProps() => 'EV',
  RestroomMapTileProps(:final types) when types.isNotEmpty => 'WC',
  _ => null,
};

String _hex(Color color) =>
    '#${(color.toARGB32() & 0xFFFFFF).toRadixString(16).padLeft(6, '0')}';

/// 地図タイルを使わない、建物の外形と部屋だけのスタイル。
String _style(Imdf imdf) => jsonEncode({
  'version': 8,
  // 英数字のラベル用。日本語は端末のフォントで描画される。
  'glyphs': 'https://demotiles.maplibre.org/font/{fontstack}/{range}.pbf',
  'sources': {
    'footprints': {'type': 'geojson', 'data': imdf.footprints},
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
      'id': 'footprint-fill',
      'type': 'fill',
      'source': 'footprints',
      'paint': {'fill-color': '#ffffff'},
    },
    {
      'id': 'footprint-line',
      'type': 'line',
      'source': 'footprints',
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
