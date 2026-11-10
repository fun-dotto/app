import 'package:dotto/presentation/root/glass_surface.dart';
import 'package:material_ui/material_ui.dart';

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
