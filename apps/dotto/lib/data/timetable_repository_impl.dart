import 'package:dotto/data/app_api_mapper.dart';
import 'package:dotto/data/app_api_transport.dart';
import 'package:dotto/data/domain_error_mapper.dart';
import 'package:dotto/domain/entity/domain_error.dart';
import 'package:dotto/domain/entity/semester.dart';
import 'package:dotto/domain/entity/timetable_item.dart';
import 'package:dotto/domain/entity/timetable_slot.dart';
import 'package:dotto/domain/repository/timetable_repository.dart';
import 'package:dotto_app_api/app/v1/timetable_item.connect.client.dart';
import 'package:dotto_app_api/app/v1/timetable_item.pb.dart' as api;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'timetable_repository_impl.g.dart';

@riverpod
TimetableRepository timetableRepository(Ref ref) => TimetableRepositoryImpl(
  TimetableItemServiceClient(ref.watch(appApiTransportProvider)),
);

final class TimetableRepositoryImpl implements TimetableRepository {
  const new(this._client);

  final TimetableItemServiceClient _client;

  @override
  Future<List<TimetableItem>> getTimetableItems(
    List<Semester> semesters,
  ) async {
    try {
      final response = await _client.listTimetableItems(
        api.ListTimetableItemsRequest(semesters: semesters.map(toApiSemester)),
      );
      return List<TimetableItem>.unmodifiable(
        response.timetableItems.map(
          (e) => TimetableItem(
            id: e.id,
            subject: fromApiSubjectSummary(e.subject),
            slot: e.hasSlot()
                ? TimetableSlot(
                    dayOfWeek: fromApiDayOfWeek(e.slot.dayOfWeek),
                    period: fromApiPeriod(e.slot.period),
                  )
                : null,
          ),
        ),
      );
    } on DomainError {
      rethrow;
    } on Exception catch (e, stackTrace) {
      throw mapDomainError(e: e, stackTrace: stackTrace);
    }
  }
}
