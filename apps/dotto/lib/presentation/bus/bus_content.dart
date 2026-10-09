import 'package:dotto/domain/entity/bus_landmark.dart';
import 'package:dotto/domain/entity/bus_schedule.dart';
import 'package:dotto/domain/entity/bus_schedule_stop.dart';
import 'package:dotto/domain/entity/bus_trip_id.dart';
import 'package:dotto/helper/date_formatter.dart';
import 'package:dotto/l10n/app_localizations.dart';
import 'package:dotto/l10n/app_localizations_ja.dart';
import 'package:dotto_design_system/style/semantic_color.dart';
import 'package:flutter/rendering.dart' show ScrollCacheExtent;
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:material_ui/material_ui.dart';

/// バスの時刻表画面の枠組み。
///
/// 平日・休日のタブの中身は [body] で受け取り、[BusTripTabView] などを渡す。
final class BusContent extends StatelessWidget {
  const new({
    required this.isTo,
    required this.myBusStopName,
    required this.tabController,
    required this.onDirectionSwapped,
    required this.onBusStopTap,
    required this.onWeekdayTabTap,
    required this.body,
    super.key,
  });

  /// 大学行きかどうか。
  final bool isTo;
  final String myBusStopName;

  /// 平日・休日のタブ。初期表示のタブを外から切り替えるため、Screen で持つ。
  final TabController tabController;
  final VoidCallback onDirectionSwapped;
  final VoidCallback onBusStopTap;
  final VoidCallback onWeekdayTabTap;
  final Widget body;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context) ?? AppLocalizationsJa();
    final fromCard = _BusStopCard(
      icon: isTo ? Icons.pin_drop : Icons.school,
      label: isTo ? myBusStopName : l10n.busUniversity,
      elevation: isTo ? 1 : 0,
      onTap: isTo ? onBusStopTap : null,
    );
    final toCard = _BusStopCard(
      icon: isTo ? Icons.school : Icons.pin_drop,
      label: isTo ? l10n.busUniversity : myBusStopName,
      elevation: isTo ? 0 : 1,
      onTap: isTo ? null : onBusStopTap,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(
          l10n.busTitle,
          style: Theme.of(context).textTheme.titleLarge
              ?.copyWith(color: SemanticColor.light.accentPrimary),
        ),
        centerTitle: false,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(96),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: onDirectionSwapped,
                      icon: Icon(
                        Icons.swap_vert_outlined,
                        size: 24,
                        color: SemanticColor.light.labelSecondary,
                      ),
                    ),
                    Flexible(child: Column(children: [fromCard, toCard])),
                  ],
                ),
              ),
              TabBar(
                dividerColor: SemanticColor.light.borderPrimary,
                controller: tabController,
                onTap: (_) => onWeekdayTabTap(),
                tabs: [
                  Tab(text: l10n.busWeekday),
                  Tab(text: l10n.busHoliday),
                ],
              ),
            ],
          ),
        ),
      ),
      body: body,
    );
  }
}

/// 平日・休日ごとの便の一覧。
final class BusTripTabView extends StatelessWidget {
  const new({
    required this.schedule,
    required this.stop,
    required this.isTo,
    required this.currentTime,
    required this.tabController,
    required this.onTripTap,
    super.key,
  });

  final BusSchedule schedule;
  final BusScheduleStop stop;
  final bool isTo;

  /// 次の便を判定する基準の時刻。
  final DateTime currentTime;
  final TabController tabController;
  final ValueChanged<BusTripId> onTripTap;

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      controller: tabController,
      children: [
        for (final isWeekday in [true, false])
          _BusTripList(
            key: ValueKey((isTo, stop.id, isWeekday)),
            schedule: schedule,
            stop: stop,
            isTo: isTo,
            isWeekday: isWeekday,
            currentTime: currentTime,
            onTripTap: onTripTap,
          ),
      ],
    );
  }
}

final class _BusTripList extends HookWidget {
  const new({
    required this.schedule,
    required this.stop,
    required this.isTo,
    required this.isWeekday,
    required this.currentTime,
    required this.onTripTap,
    super.key,
  });
  final BusSchedule schedule;
  final BusScheduleStop stop;
  final bool isTo;
  final bool isWeekday;
  final DateTime currentTime;
  final ValueChanged<BusTripId> onTripTap;
  @override
  Widget build(BuildContext context) {
    // 次の便までのスクロールは見た目のためだけの状態なので、この Widget 内で持つ。
    // 方向やバス停が変わったときは、key を変えて作り直す。
    useAutomaticKeepAlive();
    final scrollController = useScrollController();
    final scrollKey = useMemoized(GlobalKey.new);
    final hasScrolled = useRef(false);
    final entries = schedule
        .tripsOf(isTo: isTo, isWeekday: isWeekday)
        .indexed
        .map(
          (entry) => (
            index: entry.$1,
            trip: entry.$2,
            leg: entry.$2.leg(selectedStopId: stop.id, isTo: isTo),
          ),
        )
        .where((entry) => entry.leg != null)
        .toList();
    final now = Duration(hours: currentTime.hour, minutes: currentTime.minute);
    final upcoming = entries
        .where((entry) => (entry.leg?.from.time ?? Duration.zero) > now)
        .firstOrNull
        ?.index;
    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        if (!context.mounted || hasScrolled.value) return;
        final target = scrollKey.currentContext;
        if (target == null) return;
        hasScrolled.value = true;
        await Scrollable.ensureVisible(
          target,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      });
      return null;
    }, [upcoming]);
    return ListView.separated(
      scrollCacheExtent: const ScrollCacheExtent.pixels(10000),
      controller: scrollController,
      itemCount: entries.length,
      separatorBuilder: (_, _) => const Divider(height: 1),
      itemBuilder: (context, index) {
        final entry = entries[index];
        if (entry.leg case final leg?) {
          return _BusTripTile(
            key: entry.index == upcoming ? scrollKey : null,
            route: entry.trip.route,
            beginTime: leg.from.time,
            endTime: leg.to.time,
            isTo: isTo,
            isKameda: leg.isFallback,
            myBusStopName: stop.name,
            onTap: entry.trip.route == '0'
                ? null
                : () => onTripTap(
                    BusTripId(
                      isTo: isTo,
                      isWeekday: isWeekday,
                      index: entry.index,
                    ),
                  ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}

final class _BusStopCard extends StatelessWidget {
  const new({
    required this.icon,
    required this.label,
    required this.elevation,
    this.onTap,
  });

  final IconData icon;
  final String label;
  final double elevation;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final card = Card(
      elevation: elevation,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Row(
          spacing: 8,
          children: [
            Icon(icon, size: 16, color: SemanticColor.light.labelSecondary),
            Expanded(
              child: Text(
                label,
                style: Theme.of(context).textTheme.bodyMedium,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
    if (onTap == null) return card;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(4),
      splashColor: SemanticColor.light.borderPrimary,
      child: card,
    );
  }
}

final class _BusTripTile extends StatelessWidget {
  const new({
    required this.route,
    required this.beginTime,
    required this.endTime,
    required this.isTo,
    required this.isKameda,
    required this.myBusStopName,
    this.onTap,
    super.key,
  });

  final String route;
  final Duration beginTime;
  final Duration endTime;
  final bool isTo;
  final bool isKameda;
  final String myBusStopName;
  final VoidCallback? onTap;

  BusLandmark _busType() {
    if (['55', '55A', '55B', '55C', '55E', '55F'].contains(route)) {
      return BusLandmark.goryokaku;
    }
    if (route == '55G') return BusLandmark.syowa;
    if (route == '55H') return BusLandmark.kameda;
    return BusLandmark.other;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context) ?? AppLocalizationsJa();
    if (route == '0') {
      return ListTile(title: Text(l10n.busServiceEnded));
    }
    final boardStop = isTo
        ? (isKameda ? l10n.busKameda : myBusStopName)
        : l10n.busUniversity;
    final alightStop = isTo
        ? l10n.busUniversity
        : (isKameda ? l10n.busKameda : myBusStopName);
    final tripType = _busType();
    final landmark = switch (tripType) {
      BusLandmark.kameda => l10n.busLandmarkKameda,
      BusLandmark.goryokaku => l10n.busLandmarkGoryokaku,
      BusLandmark.syowa => l10n.busLandmarkShowa,
      BusLandmark.other => '',
    };
    final directionText = tripType != BusLandmark.other
        ? (isTo ? l10n.busFromLandmark(landmark) : l10n.busToLandmark(landmark))
        : '';

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 4,
              children: [
                Text(
                  '${DateFormatter.busTime(beginTime)} → '
                  '${DateFormatter.busTime(endTime)}',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                Text(
                  directionText.isEmpty ? route : '$route $directionText',
                  style: Theme.of(context).textTheme.bodySmall
                      ?.copyWith(color: SemanticColor.light.labelSecondary),
                ),
                Row(
                  spacing: 4,
                  children: [
                    Icon(
                      Icons.directions_bus,
                      size: 20,
                      color: SemanticColor.light.accentPrimary,
                    ),
                    Text(boardStop),
                    const Text('-'),
                    Text(alightStop),
                  ],
                ),
              ],
            ),
            Icon(
              Icons.chevron_right,
              color: SemanticColor.light.labelSecondary,
            ),
          ],
        ),
      ),
    );
  }
}
