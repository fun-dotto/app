import 'package:dotto/domain/entity/period.dart';

final class LectureOverride {
  new({required this.lessonName, required this.period});

  final String lessonName;
  final Period period;
}

final class LectureCancellationData {
  new({required this.cancelledByDate, required this.madeUpByDate});

  final Map<String, List<LectureOverride>> cancelledByDate;
  final Map<String, List<LectureOverride>> madeUpByDate;
}
