import 'package:dotto/l10n/app_localizations.dart';
import 'package:dotto/router/app_router.dart';
import 'package:dotto_design_system/style/theme.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';

final class MyApp extends ConsumerWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Dotto',
      theme: DottoTheme.v2,
      routerConfig: router,
      // 生成された AppLocalizations.localizationsDelegates は flutter/material の
      // ローカライズを指し、material_ui の Widget からは参照できないため組み直す。
      localizationsDelegates: const [
        AppLocalizations.delegate,
        ...GlobalMaterialLocalizations.delegates,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}
