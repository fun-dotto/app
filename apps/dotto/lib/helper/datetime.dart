final class DateTimeUtility {
  /// Returns the first day of the month for the given date.
  static DateTime firstDateOfMonth(DateTime datetime) {
    return DateTime(datetime.year, datetime.month);
  }

  /// Returns the start of the day (00:00:00) for the given date.
  static DateTime startOfDay(DateTime datetime) {
    return DateTime(datetime.year, datetime.month, datetime.day);
  }

  static DateTime parseDate(String date) {
    return DateTime.parse(date);
  }

  /// Returns the academic year (starting in April) for the given date.
  static int academicYear(DateTime datetime) {
    return datetime.month >= DateTime.april ? datetime.year : datetime.year - 1;
  }
}
