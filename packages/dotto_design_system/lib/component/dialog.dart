import 'package:dotto_design_system/component/button.dart';
import 'package:dotto_design_system/style/semantic_color.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

enum DottoDialogType { alert, confirmation, plain }

final class DottoDialog extends StatelessWidget {
  const DottoDialog({
    required this.type,
    required this.title,
    required this.message,
    required this.actionButtons,
    super.key,
  });

  final DottoDialogType type;
  final String title;
  final String message;
  final List<DottoButton> actionButtons;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      insetPadding: const EdgeInsets.all(16),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: SemanticColor.light.backgroundSecondary,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: 32,
            children: [
              Column(
                spacing: 24,
                children: [
                  Column(
                    spacing: 16,
                    children: [
                      Text(
                        title,
                        style: theme.textTheme.titleLarge?.copyWith(
                          color: SemanticColor.light.labelPrimary,
                        ),
                      ),
                      Text(
                        message,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: SemanticColor.light.labelSecondary,
                        ),
                      ),
                    ],
                  ),
                  switch (type) {
                    DottoDialogType.alert => Icon(
                      Icons.error_outline,
                      color: SemanticColor.light.accentError,
                      size: 64,
                    ),
                    DottoDialogType.confirmation => Icon(
                      Icons.error_outline,
                      color: SemanticColor.light.accentWarning,
                      size: 64,
                    ),
                    _ => const SizedBox.shrink(),
                  },
                ],
              ),
              Column(
                spacing: 16,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: actionButtons,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

final class _Demo extends StatelessWidget {
  const _Demo({
    required this.type,
    required this.title,
    required this.message,
    required this.actionButtons,
  });

  final DottoDialogType type;
  final String title;
  final String message;
  final List<DottoButton> actionButtons;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SemanticColor.light.backgroundQuaternary,
      body: DottoDialog(
        type: type,
        title: title,
        message: message,
        actionButtons: actionButtons,
      ),
    );
  }
}

@widgetbook.UseCase(name: 'AlertDialog', type: DottoDialog)
Widget alertDialog(BuildContext context) {
  return _Demo(
    type: .alert,
    title: 'エラーが発生しました。',
    message: '不明なエラーが発生しました。時間を空けて再度お試しいただくか、サポートまでご連絡ください。',
    actionButtons: [
      DottoButton(onPressed: () {}, child: const Text('閉じる')),
    ],
  );
}

@widgetbook.UseCase(name: 'ConfirmationDialog', type: DottoDialog)
Widget confirmationDialog(BuildContext context) {
  return _Demo(
    type: .confirmation,
    title: '本当に削除しますか？',
    message: 'この操作は元に戻せません。',
    actionButtons: [
      DottoButton(
        onPressed: () {},
        type: .outlined,
        child: const Text('キャンセル'),
      ),
      DottoButton(onPressed: () {}, child: const Text('削除する')),
    ],
  );
}

@widgetbook.UseCase(name: 'PlainDialog', type: DottoDialog)
Widget plainDialog(BuildContext context) {
  return _Demo(
    type: .plain,
    title: 'ログアウトしますか？',
    message: '',
    actionButtons: [
      DottoButton(
        onPressed: () {},
        type: .outlined,
        child: const Text('キャンセル'),
      ),
      DottoButton(onPressed: () {}, child: const Text('ログアウト')),
    ],
  );
}
