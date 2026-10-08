import 'package:dotto/domain/entity/academic_area.dart';
import 'package:dotto/domain/entity/subject_requirement_type.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'subject_requirement.freezed.dart';

@freezed
abstract class SubjectRequirement with _$SubjectRequirement {
  const factory({
    required AcademicArea course,
    required SubjectRequirementType requirementType,
  }) = _SubjectRequirement;
}
