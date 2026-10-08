import 'package:dotto/domain/entity/floor.dart';
import 'package:dotto/domain/entity/map_tile_props.dart';
import 'package:dotto/domain/entity/room.dart';
import 'package:dotto/feature/map/widget/map_grid.dart';
import 'package:material_ui/material_ui.dart';

final class Map extends StatelessWidget {
  const new({
    required this.mapViewTransformationController,
    required this.selectedFloor,
    required this.rooms,
    required this.focusedMapTileProps,
    required this.dateTime,
    required this.onTapped,
    super.key,
  });

  final TransformationController mapViewTransformationController;
  final Floor selectedFloor;
  final List<Room> rooms;
  final MapTileProps? focusedMapTileProps;
  final DateTime dateTime;
  final void Function(MapTileProps, Room?)? onTapped;

  @override
  Widget build(BuildContext context) {
    return InteractiveViewer(
      transformationController: mapViewTransformationController,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: MapGridScreen(
          selectedFloor: selectedFloor,
          rooms: rooms,
          focusedMapTileProps: focusedMapTileProps,
          dateTime: dateTime,
          onTapped: onTapped,
        ),
      ),
    );
  }
}
