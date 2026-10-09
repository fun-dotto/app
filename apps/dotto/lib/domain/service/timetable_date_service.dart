/// 個人時間割に表示する日付を決定する。
final class TimetableDateService {
  const new();
  static const weekdaysPerWeek = 5;
  static const daysPerWeek = 7;
  static const displayedWeeks = 4;

  DateTime initialDate(DateTime now) {
    final today = DateTime(now.year, now.month, now.day);
    return today.weekday <= DateTime.friday
        ? today
        : today.add(
            Duration(days: DateTime.monday + daysPerWeek - today.weekday),
          );
  }

  List<List<DateTime>> weeks(DateTime now) {
    final initial = initialDate(now);
    final monday = initial.subtract(
      Duration(days: initial.weekday - DateTime.monday),
    );
    return List.unmodifiable(
      List.generate(displayedWeeks, (week) {
        final start = monday.add(Duration(days: (week - 1) * daysPerWeek));
        return List<DateTime>.unmodifiable(
          List.generate(
            weekdaysPerWeek,
            (day) => start.add(Duration(days: day)),
          ),
        );
      }),
    );
  }
}
