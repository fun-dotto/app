enum DayOfWeek {
  monday,
  tuesday,
  wednesday,
  thursday,
  friday,
  saturday,
  sunday;

  String get label => switch (this) {
    DayOfWeek.monday => '月',
    DayOfWeek.tuesday => '火',
    DayOfWeek.wednesday => '水',
    DayOfWeek.thursday => '木',
    DayOfWeek.friday => '金',
    DayOfWeek.saturday => '土',
    DayOfWeek.sunday => '日',
  };

  int get number => index + 1;

  static List<DayOfWeek> get weekdays => [
    DayOfWeek.monday,
    DayOfWeek.tuesday,
    DayOfWeek.wednesday,
    DayOfWeek.thursday,
    DayOfWeek.friday,
  ];

  static DayOfWeek fromNumber(int number) {
    return DayOfWeek.values[number - 1];
  }

  static DayOfWeek fromDateTime(DateTime dateTime) {
    return DayOfWeek.values[dateTime.weekday - 1];
  }
}
