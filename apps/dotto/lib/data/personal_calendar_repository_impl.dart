import 'package:dotto/data/app_api_mapper.dart';
import 'package:dotto/data/app_api_transport.dart';
import 'package:dotto/data/domain_error_mapper.dart';
import 'package:dotto/domain/entity/day_of_week.dart';
import 'package:dotto/domain/entity/domain_error.dart';
import 'package:dotto/domain/entity/lecture_status.dart';
import 'package:dotto/domain/entity/personal_timetable_day.dart';
import 'package:dotto/domain/entity/personal_timetable_item.dart';
import 'package:dotto/domain/repository/personal_calendar_repository.dart';
import 'package:dotto_app_api/app/v1/personal_calendar_item.connect.client.dart';
import 'package:dotto_app_api/app/v1/personal_calendar_item.pb.dart' as api;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'personal_calendar_repository_impl.g.dart';

@riverpod
PersonalCalendarRepository personalCalendarRepository(Ref ref) =>
    PersonalCalendarRepositoryImpl(
      PersonalCalendarItemServiceClient(ref.watch(appApiTransportProvider)),
    );

final class PersonalCalendarRepositoryImpl
    implements PersonalCalendarRepository {
  const new(this._client);

  final PersonalCalendarItemServiceClient _client;

  @override
  Future<List<PersonalTimetableDay>> getPersonalTimetableDays({
    required List<DateTime> targetDates,
  }) async {
    try {
      final response = await _client.listPersonalCalendarItems(
        api.ListPersonalCalendarItemsRequest(dates: targetDates.map(toApiDate)),
      );

      final itemsByDate = <String, List<PersonalTimetableItem>>{};
      for (final item in response.personalCalendarItems) {
        final dateKey = '${item.date.year}-${item.date.month}-${item.date.day}';
        final timetableItem = PersonalTimetableItem(
          period: fromApiPeriod(item.period),
          subject: fromApiSubjectSummary(item.subject),
          lectureStatus: toLectureStatus(item.state),
          roomName: item.rooms.map((r) => r.name).join(', '),
        );
        itemsByDate
            .putIfAbsent(dateKey, () => <PersonalTimetableItem>[])
            .add(timetableItem);
      }

      return List.unmodifiable(
        targetDates.map((date) {
          final dateKey = '${date.year}-${date.month}-${date.day}';
          final items = itemsByDate[dateKey] ?? <PersonalTimetableItem>[]
            ..sort((a, b) => a.period.number.compareTo(b.period.number));
          return PersonalTimetableDay(
            date: date,
            items: items,
            timetableDayOfWeek: DayOfWeek.fromDateTime(date),
          );
        }),
      );
    } on DomainError {
      rethrow;
    } on Exception catch (e, stackTrace) {
      throw mapDomainError(e: e, stackTrace: stackTrace);
    }
  }

  static LectureStatus toLectureStatus(api.PersonalCalendarItem_State state) {
    return switch (state) {
      api.PersonalCalendarItem_State.STATE_NORMAL => LectureStatus.normal,
      api.PersonalCalendarItem_State.STATE_CANCELLED => LectureStatus.cancelled,
      api.PersonalCalendarItem_State.STATE_MAKEUP => LectureStatus.madeUp,
      api.PersonalCalendarItem_State.STATE_ROOM_CHANGED =>
        LectureStatus.roomChanged,
      _ => throw DomainError(
        type: DomainErrorType.invalidData,
        message: 'Unsupported PersonalCalendarItem.State: $state',
      ),
    };
  }
}
