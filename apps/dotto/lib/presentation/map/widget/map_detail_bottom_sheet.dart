import 'package:collection/collection.dart';
import 'package:dotto/domain/entity/room.dart';
import 'package:dotto/helper/date_formatter.dart';
import 'package:dotto/l10n/app_localizations.dart';
import 'package:dotto/l10n/app_localizations_ja.dart';
import 'package:dotto/presentation/map/map_tile_props.dart';
import 'package:dotto/presentation/map/room_equipment.dart';
import 'package:dotto_design_system/component/button.dart';
import 'package:dotto_design_system/style/semantic_color.dart';
import 'package:material_ui/material_ui.dart';

final class MapDetailBottomSheet extends StatelessWidget {
  const new({
    required this.props,
    required this.room,
    required this.dateTime,
    required this.isAuthenticated,
    required this.onGoToSettingButtonTapped,
    super.key,
  });

  final MapTileProps props;
  final Room room;
  final DateTime dateTime;
  final bool isAuthenticated;
  final void Function() onGoToSettingButtonTapped;

  DateTime get startOfDay =>
      DateTime(dateTime.year, dateTime.month, dateTime.day);
  DateTime get endOfDay =>
      DateTime(dateTime.year, dateTime.month, dateTime.day, 23, 59, 59, 999);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 8,
        children: [
          SelectableText(
            room.name,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          if (isAuthenticated)
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Wrap(
                      spacing: 8,
                      children: [
                        if (switch (props) {
                              ClassroomMapTileProps(:final equipment) =>
                                equipment,
                              SubRoomMapTileProps(:final equipment) =>
                                equipment,
                              _ => null,
                            }
                            case final equipment?) ...[
                          _RoomEquipmentTile(equipment: equipment.food),
                          _RoomEquipmentTile(equipment: equipment.drink),
                          _RoomEquipmentTile(equipment: equipment.outlet),
                        ],
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        if (room.schedules.isNotEmpty)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: room.schedules
                                .where(
                                  (e) =>
                                      e.beginDatetime.isAfter(startOfDay) &&
                                      e.endDatetime.isBefore(endOfDay),
                                )
                                .sorted(
                                  (a, b) => a.beginDatetime.compareTo(
                                    b.beginDatetime,
                                  ),
                                )
                                .map(
                                  (e) => _RoomScheduleTile(
                                    begin: e.beginDatetime,
                                    end: e.endDatetime,
                                    title: e.title,
                                  ),
                                )
                                .toList(),
                          )
                        else if (room.description.isNotEmpty)
                          SelectableText(room.description),
                        if (room.email.isNotEmpty)
                          SelectableText('${room.email}@fun.ac.jp'),
                      ],
                    ),
                  ],
                ),
              ),
            )
          else
            Column(
              children: [
                Text(
                  (AppLocalizations.of(context) ?? AppLocalizationsJa())
                      .mapLoginDetails,
                ),
                DottoButton(
                  onPressed: onGoToSettingButtonTapped,
                  type: DottoButtonType.text,
                  child: Text(
                    (AppLocalizations.of(context) ?? AppLocalizationsJa())
                        .mapGoToSettings,
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}

final class _RoomScheduleTile extends StatelessWidget {
  const new({required this.begin, required this.end, required this.title});
  final DateTime begin;
  final DateTime end;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: SemanticColor.light.backgroundPrimary,
        border: Border(
          left: BorderSide(width: 5, color: SemanticColor.light.accentPrimary),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SelectableText(
            title,
            style: Theme.of(context).textTheme.titleSmall
                ?.copyWith(overflow: TextOverflow.ellipsis),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                DateFormatter.dateWithoutYear(begin),
                style: Theme.of(context).textTheme.labelMedium,
              ),
              const SizedBox(width: 5),
              Text(
                '${DateFormatter.timeWithoutSecond(begin)}'
                '-'
                '${DateFormatter.timeWithoutSecond(end)}',
                style: Theme.of(context).textTheme.labelMedium,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

final class _RoomEquipmentTile extends StatelessWidget {
  const new({required this.equipment});
  final RoomEquipment equipment;
  @override
  Widget build(BuildContext context) {
    final fontColor = SemanticColor.light.labelTertiary;
    return Container(
      width: 140,
      decoration: BoxDecoration(
        color: SemanticColor.light.accentPrimary.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(5),
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(equipment.icon, color: fontColor, size: 20),
          Text(
            switch (equipment) {
              RoomEquipmentFood() =>
                (AppLocalizations.of(context) ?? AppLocalizationsJa()).mapFood,
              RoomEquipmentDrink() =>
                (AppLocalizations.of(context) ?? AppLocalizationsJa()).mapDrink,
              _ =>
                (AppLocalizations.of(context) ?? AppLocalizationsJa())
                    .mapOutlet,
            },
            style: Theme.of(context).textTheme.labelMedium
                ?.copyWith(color: fontColor),
          ),
          Icon(equipment.quality.icon, color: fontColor, size: 20),
        ],
      ),
    );
  }
}
