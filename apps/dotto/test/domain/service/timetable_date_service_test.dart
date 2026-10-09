import 'package:dotto/domain/service/timetable_date_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const service = TimetableDateService();

  test('平日は今週を中心に前週から4週間の平日を表示する', () {
    final weeks = service.weeks(DateTime(2026, 4, 8, 14));

    expect(weeks, hasLength(4));
    expect(weeks.expand((days) => days), hasLength(20));
    expect(weeks.first.first, DateTime(2026, 3, 30));
    expect(weeks.last.last, DateTime(2026, 4, 24));
    expect(
      weeks
          .expand((days) => days)
          .every((date) => date.weekday <= DateTime.friday),
      isTrue,
    );
  });

  test('週末は次の月曜日を初期選択する', () {
    expect(service.initialDate(DateTime(2026, 4, 11)), DateTime(2026, 4, 13));
    expect(service.initialDate(DateTime(2026, 4, 12)), DateTime(2026, 4, 13));
    expect(
      service.weeks(DateTime(2026, 4, 11))[1].first,
      DateTime(2026, 4, 13),
    );
  });
}
