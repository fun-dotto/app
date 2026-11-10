import 'package:freezed_annotation/freezed_annotation.dart';

part 'occlusion_region.freezed.dart';

/// カメラなど、ハードウェアによって内容が隠れる領域。
///
/// 座標は画面左上を原点とする論理ピクセルで表す。
@freezed
abstract class OcclusionRegion with _$OcclusionRegion {
  const factory({
    required double left,
    required double top,
    required double width,
    required double height,
  }) = _OcclusionRegion;

  const new _();

  double get right => left + width;
  double get bottom => top + height;
}
