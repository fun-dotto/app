import 'package:collection/collection.dart';
import 'package:dotto/domain/entity/floor.dart';
import 'package:dotto/domain/entity/room.dart';
import 'package:dotto/domain/entity/room_schedule.dart';
import 'package:dotto/presentation/map/fun_map.dart';
import 'package:dotto/presentation/map/map_body.dart';
import 'package:dotto/presentation/map/map_content.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:material_ui/material_ui.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

final _now = DateTime(2026, 4, 13, 10, 40);

final _rooms = [
  Room(
    id: '365',
    name: '講堂',
    shortName: '講堂',
    description: '',
    floor: Floor.third,
    email: '',
    keywords: const [],
    schedules: [
      RoomSchedule(
        beginDatetime: DateTime(2026, 4, 13, 10, 40),
        endDatetime: DateTime(2026, 4, 13, 12, 10),
        title: '情報表現入門',
      ),
    ],
  ),
  const Room(
    id: '364',
    name: '364',
    shortName: '364',
    description: '',
    floor: Floor.third,
    email: '',
    keywords: [],
    schedules: [],
  ),
];

// コントローラを Story の中で破棄するため、HookWidget とする。
final class _MapStory extends HookWidget {
  const new({
    this.body,
    this.selectedFloor = Floor.third,
    this.focusedRoomId,
    this.isAuthenticated = false,
  });

  final Widget? body;
  final Floor selectedFloor;
  final String? focusedRoomId;
  final bool isAuthenticated;

  @override
  Widget build(BuildContext context) {
    final searchController = useMemoized(SearchController.new);
    useEffect(() => searchController.dispose, [searchController]);
    final focusNode = useFocusNode();
    final transformationController = useMemoized(TransformationController.new);
    useEffect(() => transformationController.dispose, [
      transformationController,
    ]);

    return MapContent(
      searchBar: MapSearchBar(
        searchController: searchController,
        focusNode: focusNode,
        suggestionsBuilder: (_, _) => const <Widget>[],
      ),
      body:
          body ??
          MapBody(
            rooms: _rooms,
            selectedFloor: selectedFloor,
            focusedTile: FUNMap.tileProps.firstWhereOrNull(
              (e) => focusedRoomId != null && e.id == focusedRoomId,
            ),
            now: _now,
            searchDatetime: _now,
            isAuthenticated: isAuthenticated,
            transformationController: transformationController,
            onFloorSelected: (_) {},
            onTileTapped: (_) {},
            onPeriodButtonTapped: (_) {},
            onDatePickerConfirmed: (_) {},
          ),
    );
  }
}

@widgetbook.UseCase(name: '未ログイン', type: MapContent)
Widget mapContentUnauthenticated(BuildContext context) => const _MapStory();

@widgetbook.UseCase(name: 'ログイン済み', type: MapContent)
Widget mapContentAuthenticated(BuildContext context) =>
    const _MapStory(isAuthenticated: true);

@widgetbook.UseCase(name: '部屋を選択中', type: MapContent)
Widget mapContentFocused(BuildContext context) =>
    const _MapStory(focusedRoomId: '365', isAuthenticated: true);

@widgetbook.UseCase(name: '1階', type: MapContent)
Widget mapContentFirstFloor(BuildContext context) =>
    const _MapStory(selectedFloor: Floor.first);

@widgetbook.UseCase(name: '読み込み失敗', type: MapContent)
Widget mapContentError(BuildContext context) =>
    const _MapStory(body: MapErrorBody());
