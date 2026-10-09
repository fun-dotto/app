import 'package:dotto/l10n/app_localizations.dart';
import 'package:dotto_design_system/style/map_colors.dart';
import 'package:dotto_design_system/style/semantic_color.dart';
import 'package:material_ui/material_ui.dart';

final class MapLegend extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Container(
      width: 128,
      height: 64,
      color: SemanticColor.light.labelPrimary.withValues(alpha: 0.1),
      padding: const EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _MapLegendTile(
            color: MapColors.roomInUseTile,
            text: l10n?.mapInUse ?? '',
          ),
          _MapLegendTile(
            color: MapColors.restroomTile,
            text: l10n?.mapRestrooms ?? '',
          ),
        ],
      ),
    );
  }
}

final class _MapLegendTile extends StatelessWidget {
  const new({required this.color, required this.text});

  final Color color;
  final String text;

  @override
  Widget build(BuildContext context) => Row(
    spacing: 4,
    children: [
      Container(
        decoration: BoxDecoration(color: color, border: Border.all()),
        width: 10,
        height: 10,
      ),
      Text(text, style: Theme.of(context).textTheme.labelMedium),
    ],
  );
}
