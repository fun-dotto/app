import 'package:dotto/domain/entity/academic_area.dart';
import 'package:dotto/domain/entity/academic_class.dart';
import 'package:dotto/domain/entity/cultural_subject_category.dart';
import 'package:dotto/domain/entity/grade.dart';
import 'package:dotto/domain/entity/semester.dart';
import 'package:dotto/domain/entity/subject_classification.dart';
import 'package:dotto/domain/entity/subject_requirement_type.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'subject_filter.freezed.dart';

@Freezed(makeCollectionsUnmodifiable: true)
abstract class SubjectFilter with _$SubjectFilter {
  const factory({
    @Default([]) List<Grade> grades,
    @Default([]) List<AcademicArea> courses,
    @Default([]) List<AcademicClass> classes,
    @Default([]) List<SubjectClassification> classifications,
    @Default([]) List<Semester> semesters,
    @Default([]) List<SubjectRequirementType> requirements,
    @Default([]) List<CulturalSubjectCategory> culturalSubjectCategories,
  }) = _SubjectFilter;

  const new _();

  bool get hasActiveFilters =>
      grades.isNotEmpty ||
      courses.isNotEmpty ||
      classes.isNotEmpty ||
      classifications.isNotEmpty ||
      semesters.isNotEmpty ||
      requirements.isNotEmpty ||
      culturalSubjectCategories.isNotEmpty;
}
