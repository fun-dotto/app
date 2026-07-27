import 'package:dotto_design_system/style/semantic_color.dart';
import 'package:flutter/material.dart';

/// 設定画面のタイルをまとめて表示するセクション。
final class SettingsSection extends StatelessWidget {
  const SettingsSection({required this.tiles, super.key});

  final List<Widget> tiles;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: SemanticColor.light.backgroundSecondary,
      borderRadius: BorderRadius.circular(12),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (final (index, tile) in tiles.indexed) ...[
            if (index != 0)
              Divider(
                height: 1,
                thickness: 1,
                indent: 16,
                color: SemanticColor.light.borderPrimary,
              ),
            tile,
          ],
        ],
      ),
    );
  }
}
