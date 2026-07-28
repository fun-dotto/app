import 'package:dotto_design_system/component/list_tile.dart';
import 'package:dotto_design_system/style/semantic_color.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

/// [DottoListTile] をまとめて表示するセクション。
final class DottoListSection extends StatelessWidget {
  const DottoListSection({required this.tiles, super.key});

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

final class _Demo extends StatelessWidget {
  const _Demo({
    required this.tiles,
    //
    // ignore: unused_element_parameter
    super.key,
  });

  final List<Widget> tiles;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SemanticColor.light.backgroundQuaternary,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: DottoListSection(tiles: tiles),
        ),
      ),
    );
  }
}

@widgetbook.UseCase(name: 'ListSection', type: DottoListSection)
Widget listSection(BuildContext context) {
  return _Demo(
    tiles: [
      DottoListTile(
        title: const Text('お知らせ'),
        leading: const Icon(Icons.notifications),
        onTap: () {},
      ),
      DottoListTile(
        title: const Text('通知'),
        leading: const Icon(Icons.notifications_active),
        value: const Text('オン'),
        onTap: () {},
      ),
      DottoListTile(
        title: const Text('ライセンス'),
        leading: const Icon(Icons.info),
        description: const Text('1.0.0 (1)'),
        onTap: () {},
      ),
    ],
  );
}

@widgetbook.UseCase(
  name: 'ListSection with Single Tile',
  type: DottoListSection,
)
Widget listSectionWithSingleTile(BuildContext context) {
  return _Demo(
    tiles: [
      DottoListTile(
        title: const Text('お知らせ'),
        leading: const Icon(Icons.notifications),
        onTap: () {},
      ),
    ],
  );
}
