import 'package:dotto_design_system/component/glass_surface.dart';
import 'package:dotto_design_system/story/glass_backdrop.dart';
import 'package:material_ui/material_ui.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

/// 縦バーに表示する、画面のツールバーアイテム。登録がなければ何も表示しない。
final class VerticalBarActions extends StatelessWidget {
  const new({required this.actions, super.key});

  final ValueNotifier<List<Widget>> actions;

  @override
  Widget build(BuildContext context) => ValueListenableBuilder(
    valueListenable: actions,
    builder: (context, items, _) {
      if (items.isEmpty) return const SizedBox.shrink();
      return GlassSurface(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (final item in items)
              SizedBox.square(
                dimension: glassIconOnlyItemExtent,
                child: Center(child: item),
              ),
          ],
        ),
      );
    },
  );
}

@widgetbook.UseCase(name: 'Default', type: VerticalBarActions)
Widget verticalBarActionsDefault(BuildContext context) => GlassBackdrop(
  alignment: Alignment.centerRight,
  child: Padding(
    padding: const EdgeInsets.all(16),
    child: VerticalBarActions(
      actions: ValueNotifier<List<Widget>>([
        IconButton(icon: const Icon(Icons.arrow_back), onPressed: () {}),
        IconButton(icon: const Icon(Icons.tune), onPressed: () {}),
        IconButton(icon: const Icon(Icons.add), onPressed: () {}),
      ]),
    ),
  ),
);
