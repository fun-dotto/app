import 'package:dotto_design_system/style/semantic_color.dart';
import 'package:material_ui/material_ui.dart';

extension DottoColorExtension on ThemeData {
  SemanticColor get semanticColors => extension<SemanticColor>()!;
}
