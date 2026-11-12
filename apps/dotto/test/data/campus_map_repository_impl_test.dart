import 'package:dotto/data/campus_map_repository_impl.dart';
import 'package:dotto/domain/entity/campus_map_unit.dart';
import 'package:dotto/domain/entity/floor.dart';
import 'package:dotto/domain/entity/geo_coordinate.dart';
import 'package:dotto/domain/entity/restroom_type.dart';
import 'package:dotto/domain/entity/room_equipment.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/fake_campus_map_data_source.dart';

void main() {
  const repository = CampusMapRepositoryImpl(FakeCampusMapDataSource());

  test('IMDF から全階の区画と外形を読み込む', () async {
    final map = await repository.getCampusMap();

    expect(map.buildings, hasLength(2));
    expect(map.units, hasLength(433));
    for (final floor in Floor.values) {
      expect(map.unitsOf(floor), isNotEmpty, reason: floor.label);
      expect(map.floors[floor]?.exterior, isNotEmpty, reason: floor.label);
    }
  });

  test('区画の属性を復元する', () async {
    final map = await repository.getCampusMap();

    final atelier = map.unitOfRoom('アトリエ')!;
    expect(atelier.kind, CampusMapUnitKind.classroom);
    expect(atelier.hasBorder, isTrue);
    expect(atelier.equipment?.food, RoomEquipmentQuality.unavailable);

    final restrooms = map.units.where(
      (e) => e.kind == CampusMapUnitKind.restroom,
    );
    expect(restrooms.every((e) => e.restroomTypes.isNotEmpty), isTrue);
    expect(restrooms.expand((e) => e.restroomTypes).toSet(), {
      RestroomType.men,
      RestroomType.women,
      RestroomType.multipurpose,
    });
  });

  test('1F〜3F には同じ位置にエレベーターがある', () async {
    final map = await repository.getCampusMap();

    final elevators = {
      for (final floor in [Floor.first, Floor.second, Floor.third])
        floor: map
            .unitsOf(floor)
            .where((e) => e.kind == CampusMapUnitKind.elevator)
            .map((e) => _center(e.polygon.exterior))
            .toList(),
    };
    final first = elevators[Floor.first]!.single;
    expect(elevators[Floor.second]!.single, first);
    expect(elevators[Floor.third], contains(first));
  });
}

/// 外周の頂点の平均 (小数点以下 6 桁に丸めた文字列)。
String _center(List<GeoCoordinate> ring) {
  final points = ring.skip(1);
  double mean(double Function(GeoCoordinate) f) =>
      points.map(f).reduce((a, b) => a + b) / points.length;
  return '${mean((c) => c.latitude).toStringAsFixed(6)},'
      '${mean((c) => c.longitude).toStringAsFixed(6)}';
}
