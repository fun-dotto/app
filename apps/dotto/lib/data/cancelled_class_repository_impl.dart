import 'package:dotto/data/app_api_mapper.dart';
import 'package:dotto/data/app_api_transport.dart';
import 'package:dotto/data/course_notice_clock.dart';
import 'package:dotto/data/course_notice_mapper.dart';
import 'package:dotto/data/domain_error_mapper.dart';
import 'package:dotto/domain/entity/course_notice.dart';
import 'package:dotto/domain/entity/domain_error.dart';
import 'package:dotto/domain/repository/cancelled_class_repository.dart';
import 'package:dotto_app_api/app/v1/cancelled_class.connect.client.dart';
import 'package:dotto_app_api/app/v1/cancelled_class.pb.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'cancelled_class_repository_impl.g.dart';

@riverpod
CancelledClassRepository cancelledClassRepository(Ref ref) =>
    CancelledClassRepositoryImpl(
      CancelledClassServiceClient(ref.watch(appApiTransportProvider)),
      ref.watch(courseNoticeClockProvider),
    );

final class CancelledClassRepositoryImpl implements CancelledClassRepository {
  const new(this._client, this._now);
  final CancelledClassServiceClient _client;
  final DateTime Function() _now;
  @override
  Future<List<CourseNotice>> fetchAll({List<String>? subjectIds}) async {
    try {
      final response = await _client.listCancelledClasses(
        ListCancelledClassesRequest(
          fromDate: toApiDate(_now()),
          subjectIds: subjectIds,
        ),
      );
      return List.unmodifiable(
        response.cancelledClasses.map(
          (e) => CourseNotice.cancellation(
            id: e.id,
            subject: mapNoticeSubject(e.subject),
            date: fromApiDate(e.date),
            periodNumber: mapNoticePeriod(e.period),
            comment: e.comment,
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
