import 'package:dotto/l10n/app_localizations.dart';
import 'package:dotto/l10n/app_localizations_ja.dart';
import 'package:material_ui/material_ui.dart';

/// 移行中のプレビューでも科目の翻訳を参照できるようにする。
extension SubjectLocalizations on BuildContext {
  AppLocalizations get subjectL10n =>
      AppLocalizations.of(this) ?? AppLocalizationsJa();
}
