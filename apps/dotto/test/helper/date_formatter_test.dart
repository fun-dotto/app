import 'package:dotto/helper/date_formatter.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() {
  setUpAll(() => initializeDateFormatting('ja'));

  final dateTime = DateTime(2024, 1, 2, 12, 5);

  test('バスの残り時間を時:分で表す', () {
    expect(
      DateFormatter.busTime(const Duration(hours: 1, minutes: 5)),
      '01:05',
    );
    expect(DateFormatter.busTime(const Duration(minutes: -3)), '-00:03');
  });

  test('日付を各形式で整形する', () {
    expect(DateFormatter.date(dateTime), '2024-01-02');
    expect(DateFormatter.dateWithDayOfWeek(dateTime), '2024/1/2 火');
    expect(DateFormatter.dateWithoutYear(dateTime), '1/2');
    expect(DateFormatter.dayOfMonth(dateTime), '2');
    expect(DateFormatter.dayOfWeek(dateTime), '火');
  });

  test('時刻を秒なしで整形する', () {
    expect(DateFormatter.timeWithoutSecond(dateTime), '12:05');
    expect(DateFormatter.full(dateTime), '2024年1月2日 12:05');
  });

  test('時限の時刻をゼロ埋めして整形する', () {
    expect(DateFormatter.clockTime(hour: 9, minute: 0), '09:00');
  });
}
