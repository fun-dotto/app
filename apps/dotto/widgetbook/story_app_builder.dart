import 'package:dotto/l10n/app_localizations.dart';
import 'package:material_ui/material_ui.dart';

/// Story を、アプリ本体 (`MyApp`) と同じローカライズの中で表示する。
///
/// Widgetbook と VRT で同じ見た目になるよう、両方からこの関数を使う。
Widget storyAppBuilder(BuildContext context, Widget child) {
  // アプリ本体と同じく、material_ui から参照できるローカライズを組み直す。
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    localizationsDelegates: const [
      AppLocalizations.delegate,
      ...GlobalMaterialLocalizations.delegates,
    ],
    supportedLocales: AppLocalizations.supportedLocales,
    home: Material(child: child),
  );
}
