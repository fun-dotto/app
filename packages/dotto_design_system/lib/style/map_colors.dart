import 'package:material_ui/material_ui.dart';

/// キャンパスマップの描画色。
abstract final class MapColors {
  static const Color foreground = Colors.black;
  static const Color invertedForeground = Colors.white;
  static const Color transparent = Colors.transparent;
  static const Color subRoomTile = Colors.grey;
  static const Color stairArrow = Color(0xFF616161);
  static const Color selectedPeriod = Colors.black12;
  static const Color focusedTile = Colors.red;
  static const Color roomInUseTile = Color(0xFFFF9800);
  static const Color classroomTile = Color(0xFF616161);
  static const Color facultyRoomTile = Color(0xFF757575);
  static const Color otherRoomTile = Color(0xFFBDBDBD);
  static const Color restroomMen = Color(0xFF1565C0);
  static const Color restroomWomen = Color(0xFFC62828);
  static const Color restroomTile = Color(0xFF9CCC65);
  static const Color stairTile = Color(0xFFE0E0E0);
  static const Color elevatorTile = Color(0xFF424242);
  static const Color aisleTile = Color(0xFFE0E0E0);
}
