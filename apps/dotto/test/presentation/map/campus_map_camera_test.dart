import 'package:dotto/data/campus_map_repository_impl.dart';
import 'package:dotto/domain/entity/floor.dart';
import 'package:dotto/presentation/map/campus_map_camera.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/fake_campus_map_data_source.dart';

void main() {
  test('建物の向きに回転した範囲は建物の縦横の長さになる', () async {
    final map = await const CampusMapRepositoryImpl(FakeCampusMapDataSource())
        .getCampusMap();

    final extent = campusMapExtent(map.floors[Floor.third]!.exterior);
    expect(extent.width, closeTo(103, 3));
    expect(extent.height, closeTo(125, 3));
  });
}
