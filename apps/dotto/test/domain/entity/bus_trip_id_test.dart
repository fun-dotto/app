import 'package:dotto/domain/entity/bus_trip_id.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('文字列表現から元のバス便IDを復元できる', () {
    const id = BusTripId(isTo: false, isWeekday: false, index: 12);

    final parsed = BusTripId.tryParse(id.value);

    expect(parsed?.value, 'from_fun-holiday-12');
    expect(parsed?.isTo, isFalse);
    expect(parsed?.isWeekday, isFalse);
    expect(parsed?.index, 12);
  });

  test('大学行き平日便のIDを解釈できる', () {
    final parsed = BusTripId.tryParse('to_fun-weekday-0');

    expect(parsed?.isTo, isTrue);
    expect(parsed?.isWeekday, isTrue);
    expect(parsed?.index, 0);
  });

  test('形式に合わない文字列は解釈しない', () {
    for (final value in [
      '',
      'to_fun-weekday',
      'to_fun-weekday-1-2',
      'unknown-weekday-1',
      'to_fun-unknown-1',
      'to_fun-weekday-x',
      'to_fun-weekday--1',
    ]) {
      expect(BusTripId.tryParse(value), isNull, reason: value);
    }
  });
}
