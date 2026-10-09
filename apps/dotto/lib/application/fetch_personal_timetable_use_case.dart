import 'package:dotto/data/clock.dart';
import 'package:dotto/data/personal_calendar_repository_impl.dart';
import 'package:dotto/domain/entity/personal_timetable_day.dart';
import 'package:dotto/domain/repository/personal_calendar_repository.dart';
import 'package:dotto/domain/service/timetable_date_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'fetch_personal_timetable_use_case.g.dart';

@riverpod
FetchPersonalTimetableUseCase fetchPersonalTimetableUseCase(Ref ref) =>
    FetchPersonalTimetableUseCase(
      ref.watch(personalCalendarRepositoryProvider),
      ref.watch(clockProvider),
    );

final class FetchPersonalTimetableUseCase {
  const new(this._repository, this._clock);
  final PersonalCalendarRepository _repository;
  final DateTime Function() _clock;

  Future<List<PersonalTimetableDay>> call() async {
    final weeks = const TimetableDateService().weeks(_clock());
    final results = await Future.wait(
      weeks.map(
        (dates) => _repository.getPersonalTimetableDays(targetDates: dates),
      ),
    );
    return List.unmodifiable(results.expand((days) => days));
  }
}
