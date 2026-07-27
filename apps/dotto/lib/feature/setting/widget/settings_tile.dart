import 'package:dotto_design_system/style/semantic_color.dart';
import 'package:flutter/material.dart';

/// 設定画面のセクション内に並べる1行分のタイル。
final class SettingsTile extends StatelessWidget {
  const SettingsTile({
    required this.title,
    super.key,
    this.leading,
    this.value,
    this.description,
    this.onTap,
  });

  final Widget title;
  final Widget? leading;

  /// タイトルの右側に表示する現在値
  final Widget? value;

  /// タイルの下に表示する補足
  final Widget? description;

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: Row(
              spacing: 12,
              children: [
                if (leading != null)
                  IconTheme.merge(
                    data: IconThemeData(
                      color: SemanticColor.light.labelSecondary,
                    ),
                    child: leading!,
                  ),
                Expanded(
                  child: DefaultTextStyle.merge(
                    style: textTheme.bodyLarge?.copyWith(
                      color: SemanticColor.light.labelPrimary,
                    ),
                    child: title,
                  ),
                ),
                if (value != null)
                  DefaultTextStyle.merge(
                    style: textTheme.bodyMedium?.copyWith(
                      color: SemanticColor.light.labelSecondary,
                    ),
                    child: value!,
                  ),
                Icon(
                  Icons.chevron_right,
                  color: SemanticColor.light.labelSecondary,
                ),
              ],
            ),
          ),
        ),
        if (description != null)
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
            child: DefaultTextStyle.merge(
              style: textTheme.bodySmall?.copyWith(
                color: SemanticColor.light.labelSecondary,
              ),
              child: description!,
            ),
          ),
      ],
    );
  }
}
