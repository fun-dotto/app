import 'package:dotto/domain/entity/occlusion_region.dart';
import 'package:dotto/domain/entity/vertical_bar_edge.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'screen_layout.freezed.dart';

/// 端末の画面形状から決まる、タブバーの配置に関する情報。
@freezed
abstract class ScreenLayout with _$ScreenLayout {
  const factory({
    /// 縦型バーを置く端。`null` のときは縦型バーを使わず下部に置く。
    required VerticalBarEdge? verticalBarEdge,
    required List<OcclusionRegion> occlusions,
  }) = _ScreenLayout;

  const new _();

  /// 縦型バーを使わない通常の端末。
  static const standard = ScreenLayout(verticalBarEdge: null, occlusions: []);
}
