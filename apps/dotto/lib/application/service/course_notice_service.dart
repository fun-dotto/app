import 'package:dotto/data/cancelled_class_repository_impl.dart';
import 'package:dotto/data/course_registration_repository_impl.dart';
import 'package:dotto/data/makeup_class_repository_impl.dart';
import 'package:dotto/data/room_change_repository_impl.dart';
import 'package:dotto/domain/entity/course_notice.dart';
import 'package:dotto/domain/entity/course_notice_scope.dart';
import 'package:dotto/domain/entity/semester.dart';
import 'package:dotto/domain/repository/cancelled_class_repository.dart';
import 'package:dotto/domain/repository/course_registration_repository.dart';
import 'package:dotto/domain/repository/makeup_class_repository.dart';
import 'package:dotto/domain/repository/room_change_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'course_notice_service.g.dart';

/// 履修科目の条件で三種類の授業変更通知をまとめる。
final class CourseNoticeService {
  const new(
    this._cancellations,
    this._makeups,
    this._roomChanges,
    this._registrations,
  );
  final CancelledClassRepository _cancellations;
  final MakeupClassRepository _makeups;
  final RoomChangeRepository _roomChanges;
  final CourseRegistrationRepository _registrations;
  Future<List<CourseNotice>> fetch(CourseNoticeScope scope) async {
    final subjects = switch (scope) {
      CourseNoticeScope.registered =>
        (await _registrations.getCourseRegistrations(Semester.values))
            .map((r) => r.subject.id)
            .toList(),
      CourseNoticeScope.all => null,
    };
    if (subjects?.isEmpty ?? false) return const [];
    final notices = await Future.wait([
      _cancellations.fetchAll(subjectIds: subjects),
      _makeups.fetchAll(subjectIds: subjects),
      _roomChanges.fetchAll(subjectIds: subjects),
    ]);
    return List.unmodifiable(notices.expand((items) => items));
  }
}

@riverpod
CourseNoticeService courseNoticeService(Ref ref) => CourseNoticeService(
  ref.watch(cancelledClassRepositoryProvider),
  ref.watch(makeupClassRepositoryProvider),
  ref.watch(roomChangeRepositoryProvider),
  ref.watch(courseRegistrationRepositoryProvider),
);
