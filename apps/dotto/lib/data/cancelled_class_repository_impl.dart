import 'package:built_collection/built_collection.dart';
import 'package:dotto/data/api_client.dart';
import 'package:dotto/data/course_notice_clock.dart';
import 'package:dotto/data/course_notice_mapper.dart';
import 'package:dotto/data/domain_error_mapper.dart';
import 'package:dotto/domain/entity/course_notice.dart';
import 'package:dotto/domain/entity/domain_error.dart';
import 'package:dotto/domain/repository/cancelled_class_repository.dart';
import 'package:openapi/openapi.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'cancelled_class_repository_impl.g.dart';

@riverpod
CancelledClassRepository cancelledClassRepository(Ref ref) =>
    CancelledClassRepositoryImpl(
      ref.watch(apiClientProvider),
      ref.watch(courseNoticeClockProvider),
    );

final class CancelledClassRepositoryImpl implements CancelledClassRepository {
  const new(this._apiClient, this._now);
  final Openapi _apiClient;
  final DateTime Function() _now;
  @override
  Future<List<CourseNotice>> fetchAll({List<String>? subjectIds}) async {
    try {
      final now = _now();
      final response = await _apiClient
          .getCancelledClassesApi()
          .cancelledClassesV1List(
            from: Date(now.year, now.month, now.day),
            subjectIds: subjectIds == null
                ? null
                : BuiltList<String>(subjectIds),
          );
      final data = response.data;
      if (response.statusCode != 200 || data == null) {
        throw const DomainError(
          type: DomainErrorType.invalidResponse,
          message: 'Failed to fetch course notices',
        );
      }
      return List.unmodifiable(
        data.cancelledClasses.map(
          (e) => CourseNotice.cancellation(
            id: e.id,
            subject: mapNoticeSubject(e.subject),
            date: e.date.toDateTime(),
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
