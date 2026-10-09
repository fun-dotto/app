import 'package:dotto/domain/entity/floor.dart';
import 'package:dotto/domain/entity/room.dart';
import 'package:dotto/presentation/map/map_tile_props.dart';
import 'package:dotto/presentation/map/widget/map.dart';
import 'package:dotto/presentation/map/widget/map_date_picker.dart';
import 'package:dotto/presentation/map/widget/map_floor_button.dart';
import 'package:dotto/presentation/map/widget/map_legend.dart';
import 'package:material_ui/material_ui.dart';

/// 部屋を読み込めた場合の本文。フロア切り替え・マップ・凡例・日時選択を表示する。
final class MapBody extends StatelessWidget {
  const new({
    required this.rooms,
    required this.selectedFloor,
    required this.focusedTile,
    required this.now,
    required this.searchDatetime,
    required this.isAuthenticated,
    required this.transformationController,
    required this.onFloorSelected,
    required this.onTileTapped,
    required this.onPeriodButtonTapped,
    required this.onDatePickerConfirmed,
    super.key,
  });

  final List<Room> rooms;
  final Floor selectedFloor;
  final MapTileProps? focusedTile;
  final DateTime now;
  final DateTime searchDatetime;
  final bool isAuthenticated;
  final TransformationController transformationController;
  final ValueChanged<Floor> onFloorSelected;
  final ValueChanged<MapTileProps> onTileTapped;
  final ValueChanged<DateTime> onPeriodButtonTapped;
  final ValueChanged<DateTime> onDatePickerConfirmed;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 8,
      children: [
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 480),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: MapFloorButton(
              selectedFloor: selectedFloor,
              onPressed: onFloorSelected,
            ),
          ),
        ),
        Expanded(
          child: Stack(
            alignment: Alignment.bottomLeft,
            children: [
              SizedBox.expand(
                child: Map(
                  mapViewTransformationController: transformationController,
                  selectedFloor: selectedFloor,
                  rooms: rooms,
                  focusedMapTileProps: focusedTile,
                  dateTime: searchDatetime,
                  onTapped: (props, _) => onTileTapped(props),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 16),
                child: MapLegend(),
              ),
            ],
          ),
        ),
        if (isAuthenticated)
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 480),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: MapDatePicker(
                now: now,
                searchDatetime: searchDatetime,
                onPeriodButtonTapped: onPeriodButtonTapped,
                onDatePickerConfirmed: onDatePickerConfirmed,
              ),
            ),
          ),
      ],
    );
  }
}
