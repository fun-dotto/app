import 'package:dotto_design_system/component/list_tile.dart';
import 'package:dotto_design_system/style/semantic_color.dart';
import 'package:dotto_design_system/style/text_style.dart';
// セクション自体は widgets のみで組んでおり、material は Widgetbook の
// デモでアイコンを表示するためだけに使う。
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

/// [DottoListTile] をまとめて表示するセクション。
///
/// [header] と [footer] はカードの外側、上下に表示する。
final class DottoListSection extends StatelessWidget {
  const DottoListSection({
    required this.children,
    super.key,
    this.header,
    this.footer,
  });

  final List<Widget> children;

  /// カードの上に表示する見出し
  final Widget? header;

  /// カードの下に表示する補足
  final Widget? footer;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: 8,
      children: [
        if (header != null)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: DefaultTextStyle.merge(
              style: DottoTextStyle.titleSmall.copyWith(
                color: SemanticColor.light.labelSecondary,
              ),
              child: header!,
            ),
          ),
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: ColoredBox(
            color: SemanticColor.light.backgroundSecondary,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                for (final (index, tile) in children.indexed) ...[
                  if (index != 0) const _Divider(),
                  tile,
                ],
              ],
            ),
          ),
        ),
        if (footer != null)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: DefaultTextStyle.merge(
              style: DottoTextStyle.bodySmall.copyWith(
                color: SemanticColor.light.labelSecondary,
              ),
              child: footer!,
            ),
          ),
      ],
    );
  }
}

/// タイルの間に引く区切り線。
final class _Divider extends StatelessWidget {
  const _Divider();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(start: 16),
      child: SizedBox(
        height: 1,
        child: ColoredBox(color: SemanticColor.light.borderPrimary),
      ),
    );
  }
}

/// セクションを、実際の画面と同じく上寄せで表示するデモ。
final class _Demo extends StatelessWidget {
  const _Demo({
    required this.children,
    //
    // ignore: unused_element_parameter
    super.key,
    this.header,
    this.footer,
  });

  final List<Widget> children;
  final Widget? header;
  final Widget? footer;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: SemanticColor.light.backgroundPrimary,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: DottoListSection(
          header: header,
          footer: footer,
          children: children,
        ),
      ),
    );
  }
}

List<Widget> _demoTiles() {
  return [
    DottoListTile(
      firstLine: const Text('利用規約'),
      leading: const Icon(Icons.verified_user),
      trailing: const DottoListTileTrailing.chevron(),
      onTap: () {},
    ),
    DottoListTile(
      firstLine: const Text('プライバシーポリシー'),
      leading: const Icon(Icons.admin_panel_settings),
      trailing: const DottoListTileTrailing.chevron(),
      onTap: () {},
    ),
    DottoListTile(
      firstLine: const Text('ライセンス'),
      leading: const Icon(Icons.info),
      trailing: const DottoListTileTrailing.chevron(),
      onTap: () {},
    ),
  ];
}

@widgetbook.UseCase(name: 'Tiles Only', type: DottoListSection)
Widget listSection(BuildContext context) {
  return _Demo(children: _demoTiles());
}

@widgetbook.UseCase(name: 'Single Tile', type: DottoListSection)
Widget listSectionWithSingleTile(BuildContext context) {
  return _Demo(children: _demoTiles().take(1).toList());
}

@widgetbook.UseCase(name: 'With Header', type: DottoListSection)
Widget listSectionWithHeader(BuildContext context) {
  return _Demo(header: const Text('アプリについて'), children: _demoTiles());
}

@widgetbook.UseCase(name: 'With Footer', type: DottoListSection)
Widget listSectionWithFooter(BuildContext context) {
  return _Demo(footer: const Text('1.0.0 (1)'), children: _demoTiles());
}

@widgetbook.UseCase(name: 'With Header and Footer', type: DottoListSection)
Widget listSectionWithHeaderAndFooter(BuildContext context) {
  return _Demo(
    header: const Text('アプリについて'),
    footer: const Text('1.0.0 (1)'),
    children: _demoTiles(),
  );
}

@widgetbook.UseCase(name: 'Mixed Trailings', type: DottoListSection)
Widget listSectionWithMixedTrailings(BuildContext context) {
  return const _MixedTrailingsDemo();
}

/// トグルを含む、trailing が混在するセクションのデモ。
final class _MixedTrailingsDemo extends HookWidget {
  const _MixedTrailingsDemo();

  @override
  Widget build(BuildContext context) {
    final isEnabled = useState(true);

    return _Demo(
      header: const Text('通知'),
      footer: const Text('通知はいつでも変更できます。'),
      children: [
        DottoListTile(
          firstLine: const Text('通知を受け取る'),
          leading: const Icon(Icons.notifications_active),
          trailing: DottoListTileTrailing.toggle(
            value: isEnabled.value,
            onChanged: (value) => isEnabled.value = value,
          ),
        ),
        DottoListTile(
          firstLine: const Text('お知らせ'),
          leading: const Icon(Icons.notifications),
          secondLine: const Text('3件の未読'),
          trailing: const DottoListTileTrailing.chevron(),
          onTap: () {},
        ),
        const DottoListTile(
          firstLine: Text('バージョン'),
          leading: Icon(Icons.info),
          secondLine: Text('1.0.0 (1)'),
        ),
      ],
    );
  }
}
