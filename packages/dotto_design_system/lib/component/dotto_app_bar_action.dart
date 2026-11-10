import 'package:material_ui/material_ui.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

/// [DottoAppBarAction] が画面の中で担う役割。
enum DottoAppBarActionRole {
  /// 画面を閉じる・キャンセルする。戻るボタンの位置に表示する。
  dismiss,

  /// 入力内容を確定する。強調して表示する。
  confirmation,
}

/// `DottoAppBar` に表示するアクション。
///
/// 縦バーではアイコンしか表示できないため、[label] は文字ではなく
/// ツールチップと読み上げに使う。
final class DottoAppBarAction extends StatelessWidget {
  const new({
    required this.icon,
    required this.label,
    required this.action,
    this.role,
    super.key,
  });

  final DottoAppBarActionRole? role;
  final Icon icon;
  final String label;

  /// タップ時の処理。`null` のときは無効状態で表示する。
  final VoidCallback? action;

  @override
  Widget build(BuildContext context) => switch (role) {
    DottoAppBarActionRole.confirmation => IconButton.filled(
      icon: icon,
      tooltip: label,
      onPressed: action,
    ),
    DottoAppBarActionRole.dismiss ||
    null => IconButton(icon: icon, tooltip: label, onPressed: action),
  };
}

@widgetbook.UseCase(name: 'Default', type: DottoAppBarAction)
Widget dottoAppBarActionDefault(BuildContext context) => Center(
  child: DottoAppBarAction(
    icon: const Icon(Icons.tune),
    label: 'カスタム',
    action: () {},
  ),
);

@widgetbook.UseCase(name: 'Dismiss', type: DottoAppBarAction)
Widget dottoAppBarActionDismiss(BuildContext context) => Center(
  child: DottoAppBarAction(
    role: DottoAppBarActionRole.dismiss,
    icon: const Icon(Icons.close),
    label: '閉じる',
    action: () {},
  ),
);

@widgetbook.UseCase(name: 'Confirmation', type: DottoAppBarAction)
Widget dottoAppBarActionConfirmation(BuildContext context) => Center(
  child: DottoAppBarAction(
    role: DottoAppBarActionRole.confirmation,
    icon: const Icon(Icons.check),
    label: '投稿する',
    action: () {},
  ),
);
