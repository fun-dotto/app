import 'package:material_ui/material_ui.dart';

/// [EdgeInsets] への拡張。
extension EdgeInsetsExtension on EdgeInsets {
  /// 下部のタブバーの背後まで本文が広がる分を、下の余白に加えた値を返す。
  ///
  /// [ListView] は画面端の余白を自動で加えるが、[SingleChildScrollView] などは
  /// 加えないため、末尾の項目がタブバーに隠れないよう各画面で指定する。
  EdgeInsets withBottomBarInset(BuildContext context) =>
      copyWith(bottom: bottom + MediaQuery.paddingOf(context).bottom);
}
