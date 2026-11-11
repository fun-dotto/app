import 'package:dotto/domain/entity/floor.dart';
import 'package:dotto/presentation/map/imdf.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/fun_map_for_test.dart';

void main() {
  final imdf = loadImdfForTest();
  final funMap = imdf.funMap;

  test('すべてのタイルに対応する unit がある', () {
    for (final tile in funMap.tileProps) {
      final unit = imdf.unitOf(tile);
      expect(unit, isNotNull, reason: '${tile.floor} ${tile.x},${tile.y}');
      expect(
        (unit!['properties']! as Map)['level_id'],
        imdf.levelIdOf(tile.floor),
      );
    }
    expect(imdf.units, hasLength(funMap.tileProps.length));
  });

  test('すべての階に level の外形がある', () {
    for (final floor in Floor.values) {
      expect(imdf.levelOutline(floor), isNotEmpty, reason: '$floor');
    }
  });

  test('建物の向きに回転した範囲はグリッドの縦横比に近い', () {
    // 本部棟 3F はグリッドで 48 x 61 マス (1 マス約 2 m)。
    final extent = imdfExtent(imdf.levelOutline(Floor.third));
    expect(extent.width, closeTo(103, 3));
    expect(extent.height, closeTo(125, 3));
  });
}
