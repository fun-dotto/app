const _toFunKey = 'to_fun';
const _fromFunKey = 'from_fun';
const _weekdayKey = 'weekday';
const _holidayKey = 'holiday';

/// バス便を一意に識別するID。
///
/// `{to_fun|from_fun}-{weekday|holiday}-{便リスト内のindex}` 形式で、
/// 時刻表 内の位置を指す。URLに載せて画面間で受け渡せる。
final class BusTripId {
  const new({required this.isTo, required this.isWeekday, required this.index});

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
