import 'package:dotto/domain/entity/floor.dart';
import 'package:dotto/presentation/map/fun_map.dart';
import 'package:dotto/presentation/map/map_tile_props.dart';
import 'package:dotto/presentation/map/restroom_type.dart';
import 'package:dotto/presentation/map/room_equipment.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

import '../../helpers/fun_map_for_test.dart';

void main() {
  test('GeoJSON から全階のタイルを読み込む', () {
    final map = loadFunMapForTest();

    expect(map.tileProps, hasLength(614));
    for (final floor in Floor.values) {
      expect(map.tilePropsOf(floor), isNotEmpty, reason: floor.label);
    }
  });

  test('同じ階のタイルは重ならない', () {
    final map = loadFunMapForTest();

    for (final floor in Floor.values) {
      final cells = <(int, int)>{};
      for (final e in map.tilePropsOf(floor)) {
        for (var x = e.x; x < e.x + e.width; x++) {
          for (var y = e.y; y < e.y + e.height; y++) {
            if (!e.containsCell(x, y)) continue;
            expect(cells.add((x, y)), isTrue, reason: '${floor.label} $x,$y');
          }
        }
      }
    }
  });

  test('種類ごとの属性を復元する', () {
    final map = loadFunMapForTest();

    final atelier = map.tileProps.firstWhere((e) => e.id == 'アトリエ');
    expect(atelier, isA<ClassroomMapTileProps>());
    expect(
      (atelier as ClassroomMapTileProps).equipment.food.quality,
      RoomEquipmentQuality.unavailable,
    );
    expect((atelier.bottom, atelier.left), (1, 1));

    final restroom = map.tileProps.whereType<RestroomMapTileProps>().first;
    expect(restroom.types, [
      RestroomType.men,
      RestroomType.women,
      RestroomType.kitchenette,
    ]);

    final stair = map.tileProps.whereType<StairMapTileProps>().first;
    expect(stair.type.direction, Axis.vertical);
    expect((stair.type.up, stair.type.down), (true, false));
  });

  test('矩形の Polygon は shape を持たない', () {
    final map = loadFunMapForTest();

    expect(map.tileProps.where((e) => e.shape != null), isEmpty);
  });

  test('L 字の Polygon は外接矩形と輪郭を持つ', () {
    final props = FUNMap.fromGeoJson(_lShapedRoom).tileProps.single;

    expect((props.x, props.y, props.width, props.height), (2, 3, 4, 4));
    expect(props.outline, 1);
    expect(props.shape, [
      [
        Offset.zero,
        const Offset(2, 0),
        const Offset(2, 2),
        const Offset(4, 2),
        const Offset(4, 4),
        const Offset(0, 4),
        Offset.zero,
      ],
    ]);
    expect(props.containsCell(2, 3), isTrue);
    expect(props.containsCell(5, 6), isTrue);
    expect(props.containsCell(5, 3), isFalse);
    expect(props.labelAnchor, const Offset(1.5, 1.5));
  });

  test('未知の kind はエラーにする', () {
    expect(
      () => FUNMap.fromGeoJson({
        'type': 'FeatureCollection',
        'features': [
          {
            'type': 'Feature',
            'geometry': {
              'type': 'Polygon',
              'coordinates': [
                [
                  [0, 0],
                  [1, 0],
                  [1, 1],
                  [0, 1],
                  [0, 0],
                ],
              ],
            },
            'properties': {'floor': '1', 'kind': 'unknown'},
          },
        ],
      }),
      throwsFormatException,
    );
  });
}

/// (2, 3) を左上とする 4x4 の L 字の部屋 (右上 2x2 が欠けている)。
const Map<String, Object?> _lShapedRoom = {
  'type': 'FeatureCollection',
  'features': [
    {
      'type': 'Feature',
      'geometry': {
        'type': 'Polygon',
        'coordinates': [
          [
            [2, 3],
            [4, 3],
            [4, 5],
            [6, 5],
            [6, 7],
            [2, 7],
            [2, 3],
          ],
        ],
      },
      'properties': {
        'floor': '3',
        'kind': 'otherRoom',
        'roomId': 'L',
        'label': 'L字',
        'border': {'outline': 1},
      },
    },
  ],
};
