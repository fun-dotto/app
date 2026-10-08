import 'package:dotto/domain/entity/semester.dart';
import 'package:dotto/domain/entity/timetable_item.dart';

abstract interface class TimetableRepository {
  Future<List<TimetableItem>> getTimetableItems(List<Semester> semesters);
}
