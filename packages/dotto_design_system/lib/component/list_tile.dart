import 'package:dotto_design_system/style/semantic_color.dart';
import 'package:dotto_design_system/style/text_style.dart';
// chevron アイコンとトグルのためだけに material を使う。
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

/// [DottoListTile] の右端に表示する要素。
sealed class DottoListTileTrailing {
  const DottoListTileTrailing();

  /// 何も表示しない。
  const factory DottoListTileTrailing.none() = _NoneTrailing;

  /// 遷移することを示す山形を表示する。
  const factory DottoListTileTrailing.chevron() = _ChevronTrailing;

  /// オン・オフを切り替えるトグルを表示する。
  const factory DottoListTileTrailing.toggle({
    required bool value,
    required ValueChanged<bool> onChanged,
  }) = _ToggleTrailing;
}

final class _NoneTrailing extends DottoListTileTrailing {
  const _NoneTrailing();
}

final class _ChevronTrailing extends DottoListTileTrailing {
  const _ChevronTrailing();
}

final class _ToggleTrailing extends DottoListTileTrailing {
  const _ToggleTrailing({required this.value, required this.onChanged});

  final bool value;
  final ValueChanged<bool> onChanged;
}

/// リストのセクション内に並べる1行分のタイル。
///
/// 左端の [leading]、最大3行のテキスト、右端の [trailing] で構成する。
final class DottoListTile extends StatelessWidget {
  const DottoListTile({
    required this.firstLine,
    super.key,
    this.leading,
    this.secondLine,
    this.thirdLine,
    this.trailing = const DottoListTileTrailing.none(),
    this.onTap,
  });

  /// 左端に表示するアイコン
  final Widget? leading;

  final Widget firstLine;
  final Widget? secondLine;
  final Widget? thirdLine;

  final DottoListTileTrailing trailing;

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final trailingWidget = switch (trailing) {
      _NoneTrailing() => null,
      _ChevronTrailing() => Icon(
        Icons.chevron_right,
        color: SemanticColor.light.labelSecondary,
      ),
      _ToggleTrailing(:final value, :final onChanged) => _Toggle(
        value: value,
        onChanged: onChanged,
      ),
    };

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          spacing: 12,
          children: [
            if (leading != null)
              IconTheme.merge(
                data: IconThemeData(color: SemanticColor.light.labelSecondary),
                child: leading!,
              ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 4,
                children: [
                  DefaultTextStyle.merge(
                    style: DottoTextStyle.bodyLarge.copyWith(
                      color: SemanticColor.light.labelPrimary,
                    ),
                    child: firstLine,
                  ),
                  if (secondLine != null)
                    DefaultTextStyle.merge(
                      style: DottoTextStyle.bodyMedium.copyWith(
                        color: SemanticColor.light.labelSecondary,
                      ),
                      child: secondLine!,
                    ),
                  if (thirdLine != null)
                    DefaultTextStyle.merge(
                      style: DottoTextStyle.bodySmall.copyWith(
                        color: SemanticColor.light.labelSecondary,
                      ),
                      child: thirdLine!,
                    ),
                ],
              ),
            ),
            ?trailingWidget,
          ],
        ),
      ),
    );
  }
}

/// オン・オフを切り替えるトグル。
///
/// 配色をデザインシステムに合わせた material の `Switch`。
final class _Toggle extends StatelessWidget {
  const _Toggle({required this.value, required this.onChanged});

  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: value,
      onChanged: onChanged,
      activeThumbColor: SemanticColor.light.backgroundSecondary,
      activeTrackColor: SemanticColor.light.accentPrimary,
      inactiveThumbColor: SemanticColor.light.backgroundSecondary,
      inactiveTrackColor: SemanticColor.light.backgroundTertiary,
      trackOutlineColor: const WidgetStatePropertyAll(Colors.transparent),
      // タイルの高さを押し上げないよう、余分なタップ領域を持たせない。
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    );
  }
}

/// タイル単体を、中身の高さに合わせて表示するデモ。
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
    return ColoredBox(
      color: SemanticColor.light.backgroundPrimary,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          // 画面いっぱいに広げず、タイルの高さに合わせる。
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: ColoredBox(
                color: SemanticColor.light.backgroundSecondary,
                child: tile,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

@widgetbook.UseCase(name: '1 Line', type: DottoListTile)
Widget listTileSingleLine(BuildContext context) {
  return _Demo(
    tile: DottoListTile(firstLine: const Text('お知らせ'), onTap: () {}),
  );
}

@widgetbook.UseCase(name: '2 Lines', type: DottoListTile)
Widget listTileTwoLines(BuildContext context) {
  return _Demo(
    tile: DottoListTile(
      firstLine: const Text('学年'),
      secondLine: const Text('1年'),
      onTap: () {},
    ),
  );
}

@widgetbook.UseCase(name: '3 Lines', type: DottoListTile)
Widget listTileThreeLines(BuildContext context) {
  return _Demo(
    tile: DottoListTile(
      firstLine: const Text('ライセンス'),
      secondLine: const Text('オープンソースライセンス'),
      thirdLine: const Text('1.0.0 (1)'),
      onTap: () {},
    ),
  );
}

@widgetbook.UseCase(name: '1 Line + 3rd Line', type: DottoListTile)
Widget listTileSkippedSecondLine(BuildContext context) {
  return _Demo(
    tile: DottoListTile(
      firstLine: const Text('ライセンス'),
      thirdLine: const Text('1.0.0 (1)'),
      onTap: () {},
    ),
  );
}

@widgetbook.UseCase(name: 'Leading', type: DottoListTile)
Widget listTileWithLeading(BuildContext context) {
  return _Demo(
    tile: DottoListTile(
      firstLine: const Text('お知らせ'),
      leading: const Icon(Icons.notifications),
      onTap: () {},
    ),
  );
}

@widgetbook.UseCase(name: 'Trailing: None', type: DottoListTile)
Widget listTileTrailingNone(BuildContext context) {
  return const _Demo(
    tile: DottoListTile(
      firstLine: Text('バージョン'),
      leading: Icon(Icons.info),
      secondLine: Text('1.0.0 (1)'),
    ),
  );
}

@widgetbook.UseCase(name: 'Trailing: Chevron', type: DottoListTile)
Widget listTileTrailingChevron(BuildContext context) {
  return _Demo(
    tile: DottoListTile(
      firstLine: const Text('学年'),
      leading: const Icon(Icons.school),
      secondLine: const Text('1年'),
      trailing: const DottoListTileTrailing.chevron(),
      onTap: () {},
    ),
  );
}

@widgetbook.UseCase(name: 'Trailing: Toggle', type: DottoListTile)
Widget listTileTrailingToggle(BuildContext context) {
  return const _ToggleDemo();
}

@widgetbook.UseCase(name: 'All Elements', type: DottoListTile)
Widget listTileAllElements(BuildContext context) {
  return _Demo(
    tile: DottoListTile(
      firstLine: const Text('ライセンス'),
      leading: const Icon(Icons.info),
      secondLine: const Text('オープンソースライセンス'),
      thirdLine: const Text('1.0.0 (1)'),
      trailing: const DottoListTileTrailing.chevron(),
      onTap: () {},
    ),
  );
}

@widgetbook.UseCase(name: 'Long Text', type: DottoListTile)
Widget listTileLongText(BuildContext context) {
  return _Demo(
    tile: DottoListTile(
      firstLine: const Text('とても長いタイトルが折り返して表示されることを確認するためのタイル'),
      leading: const Icon(Icons.info),
      secondLine: const Text('2行目も同様に、幅に収まらない場合は折り返して表示される。'),
      thirdLine: const Text('3行目も同様に、幅に収まらない場合は折り返して表示される。'),
      trailing: const DottoListTileTrailing.chevron(),
      onTap: () {},
    ),
  );
}

/// トグルの切り替えを確認するためのデモ。
final class _ToggleDemo extends HookWidget {
  const _ToggleDemo();

  @override
  Widget build(BuildContext context) {
    final isEnabled = useState(true);

    return _Demo(
      tile: DottoListTile(
        firstLine: const Text('通知'),
        leading: const Icon(Icons.notifications),
        secondLine: Text(isEnabled.value ? 'オン' : 'オフ'),
        trailing: DottoListTileTrailing.toggle(
          value: isEnabled.value,
          onChanged: (value) => isEnabled.value = value,
        ),
      ),
    );
  }
}
