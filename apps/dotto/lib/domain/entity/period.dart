import 'package:dotto/domain/entity/clock_time.dart';

enum Period {
  first(
    startTime: ClockTime(hour: 9, minute: 0),
    endTime: ClockTime(hour: 10, minute: 30),
  ),
  second(
    startTime: ClockTime(hour: 10, minute: 40),
    endTime: ClockTime(hour: 12, minute: 10),
  ),
  third(
    startTime: ClockTime(hour: 13, minute: 10),
    endTime: ClockTime(hour: 14, minute: 40),
  ),
  fourth(
    startTime: ClockTime(hour: 14, minute: 50),
    endTime: ClockTime(hour: 16, minute: 20),
  ),
  fifth(
    startTime: ClockTime(hour: 16, minute: 30),
    endTime: ClockTime(hour: 18, minute: 0),
  ),
  sixth(
    startTime: ClockTime(hour: 18, minute: 10),
    endTime: ClockTime(hour: 19, minute: 40),
  );

  new({required this.startTime, required this.endTime});

  final ClockTime startTime;
  final ClockTime endTime;

  int get number => index + 1;

  static Period fromNumber(int number) {
    return Period.values[number - 1];
  }
}
