import 'package:dotto/feature/bus/bus_state.dart';
import 'package:dotto/repository/model/bus_trip.dart';

const _toFunKey = 'to_fun';
const _fromFunKey = 'from_fun';
const _weekdayKey = 'weekday';
const _holidayKey = 'holiday';

/// バス便を一意に識別するID。
///
/// `{to_fun|from_fun}-{weekday|holiday}-{便リスト内のindex}` 形式で、
/// [BusState.trips] 内の位置を指す。URLに載せて画面間で受け渡せる。
final class BusTripId {
  const BusTripId({
    required this.isTo,
    required this.isWeekday,
    required this.index,
  });

  /// [value] 形式の文字列を解釈する。解釈できない場合は null を返す。
  static BusTripId? tryParse(String value) {
    final parts = value.split('-');
    if (parts.length != 3) {
      return null;
    }
    final isTo = switch (parts[0]) {
      _toFunKey => true,
      _fromFunKey => false,
      _ => null,
    };
    final isWeekday = switch (parts[1]) {
      _weekdayKey => true,
      _holidayKey => false,
      _ => null,
    };
    final index = int.tryParse(parts[2]);
    if (isTo == null || isWeekday == null || index == null || index < 0) {
      return null;
    }
    return BusTripId(isTo: isTo, isWeekday: isWeekday, index: index);
  }

  /// 大学行きかどうか。
  final bool isTo;

  /// 平日ダイヤかどうか。
  final bool isWeekday;

  /// 便リスト内の位置。
  final int index;

  String get value =>
      '${isTo ? _toFunKey : _fromFunKey}'
      '-${isWeekday ? _weekdayKey : _holidayKey}'
      '-$index';
}

extension BusStateTrips on BusState {
  /// 指定した方向・ダイヤの便リストを返す。
  List<BusTrip> tripsOf({required bool isTo, required bool isWeekday}) {
    final key = isTo ? _toFunKey : _fromFunKey;
    final dayKey = isWeekday ? _weekdayKey : _holidayKey;
    return trips[key]?[dayKey] ?? const [];
  }

  /// [id] が指す便を返す。見つからない場合は null を返す。
  BusTrip? tripOf(BusTripId id) {
    final trips = tripsOf(isTo: id.isTo, isWeekday: id.isWeekday);
    if (id.index >= trips.length) {
      return null;
    }
    return trips[id.index];
  }
}
