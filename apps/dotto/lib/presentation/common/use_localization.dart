import 'package:dotto/l10n/app_localizations.dart';
import 'package:dotto/l10n/app_localizations_ja.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

/// 現在のロケールの [AppLocalizations] を返すHook。
///
/// [AppLocalizations] が未解決の場合(プレビューなど)は日本語にフォールバックする。
/// ロケール変更時には再ビルドされる。
AppLocalizations useLocalization() {
  final context = useContext();
  return AppLocalizations.of(context) ?? AppLocalizationsJa();
}
