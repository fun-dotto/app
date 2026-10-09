import 'dart:async';

import 'package:collection/collection.dart';
import 'package:dotto/domain/entity/floor.dart';
import 'package:dotto/domain/entity/room.dart';
import 'package:dotto/l10n/app_localizations.dart';
import 'package:dotto/l10n/app_localizations_ja.dart';
import 'package:dotto/presentation/common/is_authenticated.dart';
import 'package:dotto/presentation/map/fun_map.dart';
import 'package:dotto/presentation/map/map_body.dart';
import 'package:dotto/presentation/map/map_content.dart';
import 'package:dotto/presentation/map/map_state.dart';
import 'package:dotto/presentation/map/map_tile_props.dart';
import 'package:dotto/presentation/map/widget/map_detail_bottom_sheet.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';

final class MapScreen extends HookConsumerWidget {
  const new({
    required this.onGoToSettingButtonTapped,
    this.focusedRoomId,
    super.key,
  });

  final void Function() onGoToSettingButtonTapped;

  /// 表示直後に選択状態にする部屋のID。
  final String? focusedRoomId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncState = ref.watch(mapStateProvider);
    final searchDate = useState(DateTime.now());
    final selectedFloor = useState(Floor.third);
    final focusedTile = useState<MapTileProps?>(null);
    final transformationController = useMemoized(TransformationController.new);
    useEffect(() => transformationController.dispose, [
      transformationController,
    ]);

    void focusRoom(Room room) {
      selectedFloor.value = room.floor;
      focusedTile.value = FUNMap.tileProps.firstWhereOrNull(
        (e) => e.id == room.id,
      );
    }

    final isAuthenticated = ref.watch(isAuthenticatedProvider);
    final scaffoldKey = useMemoized(GlobalKey<ScaffoldState>.new);
    final sheetController = useRef<PersistentBottomSheetController?>(null);
    final searchController = useMemoized(SearchController.new);
    useEffect(() {
      return () {
        sheetController.value?.close();
        searchController.dispose();
      };
    }, [searchController]);
    final searchFocusNode = useFocusNode();

    final searchDatetime = searchDate.value;
    final rooms = asyncState.asData?.value;
    final focusedMapTileProps = focusedTile.value;

    // 部屋を指定して開かれた場合は、部屋の読み込み完了後に選択状態にする。
    useEffect(() {
      final roomId = focusedRoomId;
      if (roomId == null || rooms == null) {
        return null;
      }
      final room = rooms.firstWhereOrNull((e) => e.id == roomId);
      if (room != null) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (context.mounted) focusRoom(room);
        });
      }
      return null;
    }, [focusedRoomId, rooms]);

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!context.mounted) return;
        sheetController.value?.close();
        sheetController.value = null;
        searchFocusNode.unfocus();

        final props = focusedMapTileProps;
        if (props == null || rooms == null) {
          return;
        }
        final room = rooms.firstWhereOrNull((e) => e.id == props.id);
        if (room == null) {
          return;
        }

        final sheetHeight = props is FacultyRoomMapTileProps ? 120.0 : 240.0;
        final newController = scaffoldKey.currentState?.showBottomSheet(
          (_) => SizedBox(
            height: sheetHeight,
            child: MapDetailBottomSheet(
              props: props,
              room: room,
              dateTime: searchDatetime,
              isAuthenticated: isAuthenticated,
              onGoToSettingButtonTapped: onGoToSettingButtonTapped,
            ),
          ),
          showDragHandle: true,
        );
        sheetController.value = newController;
        searchFocusNode.unfocus();
        final shownPropsId = props.id;
        unawaited(
          newController?.closed.then((_) {
                if (!context.mounted) return;
                // 張り替え等で既に別 controller になっている場合は、
                // 現在表示中のシートではないのでユーザー操作由来とは扱わない。
                if (sheetController.value != newController) return;
                sheetController.value = null;
                if (focusedTile.value?.id == shownPropsId) {
                  focusedTile.value = null;
                }
              }) ??
              Future<void>.value(),
        );
      });
      return null;
    }, [focusedMapTileProps?.id, searchDatetime, isAuthenticated, rooms]);

    return MapContent(
      scaffoldKey: scaffoldKey,
      searchBar: MapSearchBar(
        searchController: searchController,
        focusNode: searchFocusNode,
        suggestionsBuilder: (context, controller) {
          final l10n = AppLocalizations.of(context) ?? AppLocalizationsJa();
          switch (asyncState) {
            case AsyncData(:final value):
              final query = controller.text.trim().toLowerCase();
              if (query.isEmpty) {
                return const <Widget>[];
              }
              final results = value
                  .where((room) => room.matchesQuery(query))
                  .toList();
              if (results.isEmpty) {
                return [ListTile(title: Text(l10n.mapNoResults))];
              }
              return results.map((item) {
                return ListTile(
                  title: Text(item.name),
                  onTap: () {
                    controller.closeView(controller.text);
                    searchFocusNode.unfocus();
                    focusRoom(item);
                  },
                );
              }).toList();
            case AsyncError(:final error, :final stackTrace):
              debugPrint(
                'Failed to build map search suggestions: '
                '$error\n$stackTrace',
              );
              return [ListTile(title: Text(l10n.mapSearchError))];
            case AsyncLoading():
              return [ListTile(title: Text(l10n.mapLoading))];
          }
        },
      ),
      body: switch (asyncState) {
        AsyncData(value: final state) => MapBody(
          rooms: state,
          selectedFloor: selectedFloor.value,
          focusedTile: focusedTile.value,
          now: DateTime.now(),
          searchDatetime: searchDatetime,
          isAuthenticated: isAuthenticated,
          transformationController: transformationController,
          onFloorSelected: (floor) {
            selectedFloor.value = floor;
            focusedTile.value = null;
            transformationController.value = Matrix4.identity();
          },
          onTileTapped: (props) {
            focusedTile.value = focusedTile.value == props ? null : props;
          },
          onPeriodButtonTapped: (dateTime) {
            // 「現在」ボタンは 0 時を指すため、押した時点の日時に置き換える。
            searchDate.value = dateTime.hour == 0 ? DateTime.now() : dateTime;
          },
          onDatePickerConfirmed: (dateTime) => searchDate.value = dateTime,
        ),
        AsyncError() => const MapErrorBody(),
        _ => const Center(child: CircularProgressIndicator()),
      },
    );
  }
}
