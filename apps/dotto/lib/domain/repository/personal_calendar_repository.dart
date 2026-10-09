import 'package:dotto/domain/entity/personal_timetable_day.dart';

abstract interface class PersonalCalendarRepository {
  Future<List<PersonalTimetableDay>> getPersonalTimetableDays({
    required List<DateTime> targetDates,
  });
}
