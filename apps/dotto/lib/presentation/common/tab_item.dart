import 'package:dotto/l10n/app_localizations.dart';
import 'package:dotto_design_system/component/glass_tab_bar.dart';
import 'package:material_ui/material_ui.dart';

enum TabItem {
  course(
    key: 'course',
    icon: Icons.description_outlined,
    selectedIcon: Icons.description,
  ),
  funch(
    key: 'funch',
    icon: Icons.restaurant_outlined,
    selectedIcon: Icons.restaurant,
  ),
  map(key: 'map', icon: Icons.map_outlined, selectedIcon: Icons.map),
  bus(
    key: 'bus',
    icon: Icons.directions_bus_outlined,
    selectedIcon: Icons.directions_bus,
  ),
  setting(
    key: 'setting',
    icon: Icons.settings_outlined,
    selectedIcon: Icons.settings,
  ),
  subject(
    key: 'subject',
    icon: Icons.search_outlined,
    selectedIcon: Icons.search,
  );

  new({required this.key, required this.icon, required this.selectedIcon});

  final String key;
  final IconData selectedIcon;
  final IconData icon;

  /// 現在のロケールに合わせたタブ名。
  String label(AppLocalizations l10n) => switch (this) {
    course => l10n.tabCourse,
    funch => l10n.tabFunch,
    map => l10n.tabMap,
    bus => l10n.tabBus,
    setting => l10n.tabSetting,
    subject => l10n.tabSubject,
  };

  /// タブバーに並べる項目。
  GlassTabBarItem glassItem(AppLocalizations l10n) => GlassTabBarItem(
    label: label(l10n),
    icon: icon,
    selectedIcon: selectedIcon,
  );

  static final List<TabItem> v2 = [.course, .funch, .map, .bus, .setting];
}
