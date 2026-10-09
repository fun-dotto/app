import 'package:dotto/helper/datetime.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('4月始まりの年度を求める', () {
    expect(DateTimeUtility.academicYear(DateTime(2025, 3, 31)), 2024);
    expect(DateTimeUtility.academicYear(DateTime(2025, 4)), 2025);
  });

  test('月初と日の始まりを求める', () {
    final dateTime = DateTime(2025, 6, 15, 13, 30);

    expect(DateTimeUtility.firstDateOfMonth(dateTime), DateTime(2025, 6));
    expect(DateTimeUtility.startOfDay(dateTime), DateTime(2025, 6, 15));
  });

  test('日付文字列を解釈する', () {
    expect(DateTimeUtility.parseDate('2025-06-15'), DateTime(2025, 6, 15));
  });
}
