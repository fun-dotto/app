import 'package:dotto/l10n/app_localizations.dart';
import 'package:dotto/router/app_router.dart';
import 'package:dotto_design_system/style/theme.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);
    ref.watch(appDeepLinkSubscriptionProvider);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Dotto',
      theme: DottoTheme.v2,
      routerConfig: router,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}
