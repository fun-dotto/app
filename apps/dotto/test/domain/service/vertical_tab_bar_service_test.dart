import 'package:dotto/domain/entity/occlusion_region.dart';
import 'package:dotto/domain/service/vertical_tab_bar_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const service = VerticalTabBarService();

  VerticalTabBarSpan? place(List<OcclusionRegion> occlusions) => service.place(
    barLeft: 0,
    barWidth: 80,
    minTop: 50,
    maxBottom: 800,
    occlusions: occlusions,
    margin: 10,
  );

  test('隠れる領域がなければ使える範囲全体に置く', () {
    expect(place([]), (top: 50.0, bottom: 800.0));
  });

  test('バーの列と重ならない領域は無視する', () {
    final span = place([
      const OcclusionRegion(left: 200, top: 300, width: 50, height: 50),
    ]);

    expect(span, (top: 50.0, bottom: 800.0));
  });

  test('隠れる領域を避けて最も高い範囲を選ぶ', () {
    final span = place([
      const OcclusionRegion(left: 0, top: 100, width: 40, height: 40),
    ]);

    expect(span, (top: 150.0, bottom: 800.0));
  });

  test('領域が列全体を塞ぐときは置ける範囲がない', () {
    final span = place([
      const OcclusionRegion(left: 0, top: 0, width: 80, height: 900),
    ]);

    expect(span, isNull);
  });
}
