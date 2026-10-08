import 'package:dotto_design_system/main.directories.g.dart';
import 'package:dotto_design_system/style/theme.dart';
import 'package:material_ui/material_ui.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

void main() {
  runApp(const WidgetbookApp());
}

@widgetbook.App()
class WidgetbookApp extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    // Widgetbook 標準の MaterialApp・MaterialThemeAddon は flutter/material の型を使い、
    // material_ui のコンポーネントにテーマが届かないため、material_ui で組み立てる。
    return Widgetbook(
      directories: directories,
      appBuilder: _materialAppBuilder,
      addons: [
        ThemeAddon<ThemeData>(
          themes: [WidgetbookTheme(name: 'Light', data: DottoTheme.v2)],
          themeBuilder: (context, theme, child) =>
              Theme(data: theme, child: child),
        ),
      ],
    );
  }
}

Widget _materialAppBuilder(BuildContext context, Widget child) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Material(child: child),
  );
}
