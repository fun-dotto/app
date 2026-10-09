import 'package:dotto/domain/entity/lecture_override.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'lecture_cancellation_data.freezed.dart';

@freezed
abstract class LectureCancellationData with _$LectureCancellationData {
  const factory({
    required Map<String, List<LectureOverride>> cancelledByDate,
    required Map<String, List<LectureOverride>> madeUpByDate,
  }) = _LectureCancellationData;
}
