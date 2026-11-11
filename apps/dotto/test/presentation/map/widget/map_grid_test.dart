import 'package:dotto/presentation/map/fun_map.dart';
import 'package:dotto/presentation/map/map_tile_props.dart';
import 'package:dotto/presentation/map/widget/map_grid.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

/// 0..4 の 4x4 の L 字 (右上 2x2 が欠けている) と、欠けた部分の部屋。
final List<MapTileProps> _tiles = FUNMap.fromGeoJson({
  'type': 'FeatureCollection',
  'features': [
    _feature('L', [
      [0, 0],
      [2, 0],
      [2, 2],
      [4, 2],
      [4, 4],
      [0, 4],
      [0, 0],
    ]),
    _feature('notch', [
      [2, 0],
      [4, 0],
      [4, 2],
      [2, 2],
      [2, 0],
    ]),
  ],
}).tileProps;

Map<String, Object?> _feature(String id, List<List<int>> ring) => {
  'type': 'Feature',
  'geometry': {
    'type': 'Polygon',
    'coordinates': [ring],
  },
  'properties': {'floor': '3', 'kind': 'otherRoom', 'roomId': id},
};

void main() {
  testWidgets('L 字のタイルは形の内側だけタップできる', (tester) async {
    final tapped = <String?>[];
    await tester.pumpWidget(
      MaterialApp(
        home: Align(
          alignment: Alignment.topLeft,
          child: SizedBox(
            width: 400,
            child: MapGridScreen(
              tileProps: _tiles,
              rooms: const [],
              focusedMapTileProps: null,
              dateTime: DateTime(2026),
              onTapped: (props, _) => tapped.add(props.id),
            ),
          ),
        ),
      ),
    );

    // 1 マス = 100px。L の縦棒、L の横棒、欠けた部分の順にタップする。
    await tester.tapAt(const Offset(50, 50));
    await tester.tapAt(const Offset(350, 350));
    await tester.tapAt(const Offset(350, 50));

    expect(tapped, ['L', 'L', 'notch']);
  });
}
