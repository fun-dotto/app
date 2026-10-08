import 'package:dotto/domain/entity/subject_filter.dart';
import 'package:dotto/domain/entity/subject_summary.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'search_subject_state.freezed.dart';

@freezed
abstract class SearchSubjectState with _$SearchSubjectState {
  const factory({
    @Default(<SubjectSummary>[]) List<SubjectSummary> subjects,
    @Default(SubjectFilter()) SubjectFilter filter,
  }) = _SearchSubjectState;
}
