import 'package:intl/intl.dart';
import 'package:material_ui/material_ui.dart';

abstract class DateFormatter {
  static String busTime(Duration duration) {
    final sign = duration.isNegative ? '-' : '';
    final hours = duration.inHours.abs().toString().padLeft(2, '0');
    final minutes = duration.inMinutes
        .remainder(60)
        .abs()
        .toString()
        .padLeft(2, '0');
    return '$sign$hours:$minutes';
  }

  // 2024-01-02T12:00+09:00 → 2024年1月2日 12:00
  static String full(DateTime dateTime) {
    final locale = WidgetsBinding.instance.platformDispatcher.locale;
    return DateFormat.yMMMd(locale.toString())
        .add_jm()
        .format(dateTime.toLocal());
  }

  // 2024-01-02T12:00+09:00 → 2024/1/2 火
  static String dateWithDayOfWeek(DateTime dateTime) {
    final locale = WidgetsBinding.instance.platformDispatcher.locale;
    return DateFormat.yMd(locale.toString()).add_E().format(dateTime);
  }

  // 2024-01-02T12:00+09:00 → 12:00
  static String timeWithoutSecond(DateTime dateTime) {
    final locale = WidgetsBinding.instance.platformDispatcher.locale;
    return DateFormat.jm(locale.toString()).format(dateTime.toLocal());
  }

  // 2024-01-02T12:00+09:00 → 1月2日
  static String dateWithoutYear(DateTime dateTime) {
    final locale = WidgetsBinding.instance.platformDispatcher.locale;
    return DateFormat.Md(locale.toString()).format(dateTime);
  }

  // 2024-01-02T12:00+09:00 → 2
  static String dayOfMonth(DateTime dateTime) {
    // d(locale.toString())で日本環境になるとd日という表記になるため、localeを指定しない
    return DateFormat.d().format(dateTime.toLocal());
  }

  // 2024-01-02T12:00+09:00 → 火
  static String dayOfWeek(DateTime dateTime) {
    final locale = WidgetsBinding.instance.platformDispatcher.locale;
    return DateFormat.E(locale.toString()).format(dateTime.toLocal());
  }

  // 2024-01-02T12:00+09:00 → 2024-01-02
  static String date(DateTime dateTime) {
    return DateFormat('yyyy-MM-dd').format(dateTime);
  }

  /// 時限の開始・終了時刻を、日付やタイムゾーンの変換なしで整形する。
  static String clockTime({required int hour, required int minute}) =>
      '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';
}
