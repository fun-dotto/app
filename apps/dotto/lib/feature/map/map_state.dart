import 'package:dotto/domain/entity/floor.dart';
import 'package:dotto/domain/entity/map_tile_props.dart';
import 'package:dotto/domain/entity/room.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:material_ui/material_ui.dart';

part 'map_state.freezed.dart';

@freezed
abstract class MapState with _$MapState {
  const factory({
    required List<Room> rooms,
    required DateTime searchDatetime,
    required Floor selectedFloor,
    required TransformationController transformationController,
    MapTileProps? focusedMapTileProps,
  }) = _MapState;
}
