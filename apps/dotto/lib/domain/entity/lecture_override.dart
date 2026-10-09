import 'package:dotto/domain/entity/period.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'lecture_override.freezed.dart';

@freezed
abstract class LectureOverride with _$LectureOverride {
  const factory({required String lessonName, required Period period}) =
      _LectureOverride;
}
