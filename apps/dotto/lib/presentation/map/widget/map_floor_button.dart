import 'package:dotto/domain/entity/floor.dart';
import 'package:dotto_design_system/style/semantic_color.dart';
import 'package:material_ui/material_ui.dart';

final class MapFloorButton extends StatelessWidget {
  const new({required this.selectedFloor, required this.onPressed, super.key});

  final Floor selectedFloor;
  final void Function(Floor) onPressed;

  @override
  Widget build(BuildContext context) => GridView.count(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    crossAxisCount: Floor.values.length,
    children: [
      for (final floor in Floor.values)
        _FloorButton(
          floor: floor,
          isSelected: selectedFloor == floor,
          onPressed: onPressed,
        ),
    ],
  );
}

final class _FloorButton extends StatelessWidget {
  const new({
    required this.floor,
    required this.isSelected,
    required this.onPressed,
  });

  final Floor floor;
  final bool isSelected;
  final void Function(Floor) onPressed;

  @override
  Widget build(BuildContext context) => TextButton(
    style: TextButton.styleFrom(
      backgroundColor: isSelected
          ? SemanticColor.light.backgroundTertiary
          : null,
    ),
    onPressed: () => onPressed(floor),
    child: Text(
      floor.label,
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
        color: isSelected
            ? SemanticColor.light.accentPrimary
            : SemanticColor.light.labelSecondary,
      ),
    ),
  );
}
