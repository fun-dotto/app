import 'package:dotto_design_system/style/map_colors.dart';
import 'package:material_ui/material_ui.dart';

enum RestroomType {
  men(icon: Icons.man, color: MapColors.restroomMen),
  women(icon: Icons.woman, color: MapColors.restroomWomen),
  multipurpose(icon: Icons.accessible, color: MapColors.foreground),
  kitchenette(icon: Icons.countertops, color: MapColors.foreground);

  new({required this.icon, this.color});

  final IconData icon;
  final Color? color;
}
