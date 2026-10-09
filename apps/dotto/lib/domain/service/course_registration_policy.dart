import 'package:dotto/domain/entity/timetable_item.dart';

/// 一つのコマに登録できる科目数を判定する。
final class CourseRegistrationPolicy {
  const new();
  static const maximumCoursesPerSlot = 2;

  bool canRegister({
    required String subjectId,
    required List<TimetableItem> timetableItems,
    required Set<String> registeredSubjectIds,
  }) {
    final targetSlots = timetableItems
        .where((item) => item.subject.id == subjectId)
        .map((item) => item.slot)
        .whereType<Object>()
        .toSet();
    return targetSlots.every((slot) {
      final selected = timetableItems
          .where(
            (item) =>
                item.slot == slot &&
                registeredSubjectIds.contains(item.subject.id),
          )
          .map((item) => item.subject.id)
          .toSet();
      return selected.length < maximumCoursesPerSlot;
    });
  }
}
