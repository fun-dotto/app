import 'package:dotto_design_system/style/primitive_color.dart';
import 'package:material_ui/material_ui.dart';

/// 環境 (flavor) ごとのアクセントカラー。
///
/// 開発・ステージングの端末を、本番と見分けられるようにする。
Color flavorAccentColor(String? flavor) => switch (flavor) {
  'dev' => PrimitiveColor.blue600,
  'stg' => PrimitiveColor.orange600,
  _ => PrimitiveColor.accent,
};
