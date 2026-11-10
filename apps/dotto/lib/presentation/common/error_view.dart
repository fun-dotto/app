import 'package:dotto/presentation/common/use_localization.dart';
import 'package:dotto_design_system/component/error_alert.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

/// データの取得に失敗したことを伝える。
final class ErrorView extends HookWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = useLocalization();
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: DottoErrorAlert(
          title: l10n.commonErrorTitle,
          message: l10n.commonErrorMessage,
        ),
      ),
    );
  }
}
