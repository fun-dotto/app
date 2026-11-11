import 'dart:async';

import 'package:collection/collection.dart';
import 'package:dotto/domain/entity/campus_map_unit.dart';
import 'package:dotto/domain/entity/floor.dart';
import 'package:dotto/domain/entity/room.dart';
import 'package:dotto/extension/edge_insets_extension.dart';
import 'package:dotto/l10n/app_localizations.dart';
import 'package:dotto/l10n/app_localizations_ja.dart';
import 'package:dotto/presentation/common/is_authenticated.dart';
import 'package:dotto/presentation/map/campus_map_state.dart';
import 'package:dotto/presentation/map/map_state.dart';
import 'package:dotto/presentation/map/widget/campus_map_view.dart';
import 'package:dotto/presentation/map/widget/map_date_picker.dart';
import 'package:dotto/presentation/map/widget/map_detail_bottom_sheet.dart';
import 'package:dotto/presentation/map/widget/map_floor_button.dart';
import 'package:dotto/presentation/map/widget/map_legend.dart';
import 'package:dotto_design_system/component/dotto_app_bar.dart';
import 'package:dotto_design_system/style/layout.dart';
import 'package:dotto_design_system/style/semantic_color.dart';
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
    final asyncCampusMap = ref.watch(campusMapStateProvider);
    final campusMap = asyncCampusMap.value;
    final searchDate = useState(DateTime.now());
    final selectedFloor = useState(Floor.third);
    final focusedUnit = useState<CampusMapUnit?>(null);

    void focusRoom(Room room) {
      selectedFloor.value = room.floor;
      focusedUnit.value = campusMap?.unitOfRoom(room.id);
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
    }, [focusedRoomId, rooms, campusMap]);

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!context.mounted) return;
        sheetController.value?.close();
        sheetController.value = null;
        searchFocusNode.unfocus();

        final unit = focusedUnit.value;
        if (unit == null || rooms == null) {
          return;
        }
        final room = rooms.firstWhereOrNull((e) => e.id == unit.roomId);
        if (room == null) {
          return;
        }

        // シートは下部のタブバーの背面まで広がるため、その分を高さに加える。
        final sheetHeight =
            (unit.kind == CampusMapUnitKind.facultyRoom ? 120.0 : 240.0) +
            MediaQuery.paddingOf(context).bottom;
        final newController = scaffoldKey.currentState?.showBottomSheet(
          (_) => SizedBox(
            height: sheetHeight,
            child: MapDetailBottomSheet(
              equipment: unit.equipment,
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
        final shownUnitId = unit.id;
        unawaited(
          newController?.closed.then((_) {
                if (!context.mounted) return;
                // 張り替え等で既に別 controller になっている場合は、
                // 現在表示中のシートではないのでユーザー操作由来とは扱わない。
                if (sheetController.value != newController) return;
                sheetController.value = null;
                if (focusedUnit.value?.id == shownUnitId) {
                  focusedUnit.value = null;
                }
              }) ??
              Future<void>.value(),
        );
      });
      return null;
    }, [focusedUnit.value?.id, searchDatetime, isAuthenticated, rooms]);

    return Scaffold(
      key: scaffoldKey,
      resizeToAvoidBottomInset: false,
      appBar: DottoAppBar(
        title: Text(
          (AppLocalizations.of(context) ?? AppLocalizationsJa()).mapTitle,
          style: Theme.of(context).textTheme.titleLarge
              ?.copyWith(color: SemanticColor.light.accentPrimary),
        ),
        centerTitle: false,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SearchAnchor(
              searchController: searchController,
              textCapitalization: TextCapitalization.none,
              builder: (context, controller) {
                return SearchBar(
                  controller: controller,
                  focusNode: searchFocusNode,
                  padding: const WidgetStatePropertyAll<EdgeInsets>(
                    EdgeInsets.symmetric(horizontal: 16),
                  ),
                  textCapitalization: TextCapitalization.none,
                  onTap: () {
                    controller.openView();
                  },
                  onChanged: (value) {
                    controller.openView();
                  },
                  leading: const Icon(Icons.search),
                  hintText:
                      (AppLocalizations.of(context) ?? AppLocalizationsJa())
                          .mapSearchHint,
                );
              },
              suggestionsBuilder: (context, controller) {
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
                      return [
                        ListTile(
                          title: Text(
                            (AppLocalizations.of(context) ??
                                    AppLocalizationsJa())
                                .mapNoResults,
                          ),
                        ),
                      ];
                    }
                    return [
                      for (final item in results)
                        ListTile(
                          title: Text(item.name),
                          onTap: () {
                            controller.closeView(controller.text);
                            searchFocusNode.unfocus();
                            focusRoom(item);
                          },
                        ),
                      // 末尾の候補がタブバーに隠れないよう底上げする。
                      SizedBox(height: MediaQuery.paddingOf(context).bottom),
                    ];
                  case AsyncError(:final error, :final stackTrace):
                    debugPrint(
                      'Failed to build map search suggestions: '
                      '$error\n$stackTrace',
                    );
                    return [
                      ListTile(
                        title: Text(
                          (AppLocalizations.of(context) ?? AppLocalizationsJa())
                              .mapSearchError,
                        ),
                      ),
                    ];
                  case AsyncLoading():
                    return [
                      ListTile(
                        title: Text(
                          (AppLocalizations.of(context) ?? AppLocalizationsJa())
                              .mapLoading,
                        ),
                      ),
                    ];
                }
              },
            ),
          ),
        ),
      ),
      body: Padding(
        // 地図は固定レイアウトのため、下部のタブバーの上に収める。
        padding: const EdgeInsets.only(top: 8).withBottomBarInset(context),
        child: switch ((asyncState, asyncCampusMap)) {
          (AsyncData(value: final state), AsyncData(value: final map)) =>
            Column(
              spacing: 8,
              children: [
                Expanded(
                  child: Stack(
                    children: [
                      Column(
                        spacing: 8,
                        children: [
                          ConstrainedBox(
                            constraints: const BoxConstraints(
                              maxWidth:
                                  DottoLayout.narrowMaxWidth +
                                  DottoLayout.horizontalMargin * 2,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: DottoLayout.horizontalMargin,
                              ),
                              child: MapFloorButton(
                                selectedFloor: selectedFloor.value,
                                onPressed: (floor) {
                                  selectedFloor.value = floor;
                                  focusedUnit.value = null;
                                },
                              ),
                            ),
                          ),
                          Expanded(
                            child: Stack(
                              alignment: Alignment.bottomLeft,
                              children: [
                                SizedBox.expand(
                                  child: CampusMapView(
                                    campusMap: map,
                                    selectedFloor: selectedFloor.value,
                                    rooms: state,
                                    focusedUnit: focusedUnit.value,
                                    dateTime: searchDatetime,
                                    onTapped: (unit, _) {
                                      focusedUnit.value =
                                          focusedUnit.value?.id == unit.id
                                          ? null
                                          : unit;
                                    },
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(left: 16),
                                  child: MapLegend(),
                                ),
                              ],
                            ),
                          ),
                          _MapDatePickerSection(
                            isAuthenticated: isAuthenticated,
                            searchDatetime: searchDatetime,
                            onPeriodButtonTapped: (dateTime) async {
                              var setDate = dateTime;
                              if (setDate.hour == 0) {
                                setDate = DateTime.now();
                              }
                              searchDate.value = setDate;
                            },
                            onDatePickerConfirmed: (dateTime) async {
                              searchDate.value = dateTime;
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          (AsyncError(), _) || (_, AsyncError()) => Center(
            child: Text(
              (AppLocalizations.of(context) ?? AppLocalizationsJa()).mapError,
            ),
          ),
          _ => const Center(child: CircularProgressIndicator()),
        },
      ),
    );
  }
}

final class _MapDatePickerSection extends StatelessWidget {
  const new({
    required this.isAuthenticated,
    required this.searchDatetime,
    required this.onPeriodButtonTapped,
    required this.onDatePickerConfirmed,
  });

  final bool isAuthenticated;
  final DateTime searchDatetime;
  final void Function(DateTime) onPeriodButtonTapped;
  final void Function(DateTime) onDatePickerConfirmed;

  @override
  Widget build(BuildContext context) => isAuthenticated
      ? ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth:
                DottoLayout.narrowMaxWidth + DottoLayout.horizontalMargin * 2,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: DottoLayout.horizontalMargin,
            ),
            child: MapDatePicker(
              searchDatetime: searchDatetime,
              onPeriodButtonTapped: onPeriodButtonTapped,
              onDatePickerConfirmed: onDatePickerConfirmed,
            ),
          ),
        )
      : const SizedBox.shrink();
}
