import 'package:dotto_design_system/style/semantic_color.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

/// リストのセクション内に並べる1行分のタイル。
final class DottoListTile extends StatelessWidget {
  const DottoListTile({
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

final class _Demo extends StatelessWidget {
  const _Demo({
    required this.tile,
    //
    // ignore: unused_element_parameter
    super.key,
  });

  final DottoListTile tile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SemanticColor.light.backgroundQuaternary,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: ColoredBox(
            color: SemanticColor.light.backgroundSecondary,
            child: tile,
          ),
        ),
      ),
    );
  }
}

@widgetbook.UseCase(name: 'ListTile', type: DottoListTile)
Widget listTile(BuildContext context) {
  return _Demo(
    tile: DottoListTile(title: const Text('お知らせ'), onTap: () {}),
  );
}

@widgetbook.UseCase(name: 'ListTile with Leading', type: DottoListTile)
Widget listTileWithLeading(BuildContext context) {
  return _Demo(
    tile: DottoListTile(
      title: const Text('お知らせ'),
      leading: const Icon(Icons.notifications),
      onTap: () {},
    ),
  );
}

@widgetbook.UseCase(name: 'ListTile with Value', type: DottoListTile)
Widget listTileWithValue(BuildContext context) {
  return _Demo(
    tile: DottoListTile(
      title: const Text('学年'),
      leading: const Icon(Icons.school),
      value: const Text('1年'),
      onTap: () {},
    ),
  );
}

@widgetbook.UseCase(name: 'ListTile with Description', type: DottoListTile)
Widget listTileWithDescription(BuildContext context) {
  return _Demo(
    tile: DottoListTile(
      title: const Text('ライセンス'),
      leading: const Icon(Icons.info),
      description: const Text('1.0.0 (1)'),
      onTap: () {},
    ),
  );
}
