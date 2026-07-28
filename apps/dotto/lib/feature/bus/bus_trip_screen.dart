import 'package:dotto/feature/bus/bus_reducer.dart';
import 'package:dotto/feature/bus/bus_timetable.dart';
import 'package:dotto/feature/bus/bus_trip_id.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// バス便の時刻表画面。
///
/// URL上の便ID（[BusTripId]）から対象の便を解決して表示する。
final class BusTripScreen extends ConsumerWidget {
  const BusTripScreen({required this.id, super.key});

  final String id;

  Widget _message(String message) {
    return Scaffold(
      appBar: AppBar(title: const Text('バス時刻表')),
      body: Center(child: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(busReducerProvider);
    final tripId = BusTripId.tryParse(id);

    return switch (state) {
      AsyncData(:final value) => () {
        final busTrip = tripId == null ? null : value.tripOf(tripId);
        if (busTrip == null) {
          return _message('この便の情報が見つかりませんでした。');
        }
        return BusTimetableScreen(busTrip);
      }(),
      AsyncError() => _message('データの取得に失敗しました。'),
      _ => const Scaffold(body: Center(child: CircularProgressIndicator())),
    };
  }
}
