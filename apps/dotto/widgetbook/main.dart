import 'package:dotto_design_system/style/theme.dart';
import 'package:material_ui/material_ui.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import 'main.directories.g.dart';
import 'story_app_builder.dart';

void main() {
  runApp(const WidgetbookApp());
}

@widgetbook.App()
final class WidgetbookApp extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    // Widgetbook 標準の MaterialApp・MaterialThemeAddon は flutter/material の型を使い、
    // material_ui のコンポーネントにテーマが届かないため、material_ui で組み立てる。
    return Widgetbook(
      directories: directories,
      appBuilder: storyAppBuilder,
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
