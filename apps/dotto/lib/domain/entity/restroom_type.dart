import 'package:dotto/domain/entity/map_colors.dart';
import 'package:material_ui/material_ui.dart';

enum RestroomType {
  men(icon: Icons.man, color: MapColors.restroomMen),
  women(icon: Icons.woman, color: MapColors.restroomWomen),
  multipurpose(icon: Icons.accessible, color: Colors.black),
  kitchenette(icon: Icons.countertops, color: Colors.black);

  new({required this.icon, this.color});

  final IconData icon;
  final Color? color;
}
