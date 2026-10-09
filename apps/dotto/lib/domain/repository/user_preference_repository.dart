import 'package:dotto/domain/entity/dotto_user_preference.dart';
import 'package:dotto/domain/entity/timetable_period_style.dart';

abstract interface class UserPreferenceRepository {
  Future<DottoUserPreference> fetch();
  Future<void> saveTimetablePeriodStyle(TimetablePeriodStyle style);
}
