import 'package:dotto/domain/entity/semester.dart';
import 'package:dotto/domain/entity/subject_eligible_attribute.dart';
import 'package:dotto/domain/entity/subject_faculty.dart';
import 'package:dotto/domain/entity/subject_requirement.dart';
import 'package:dotto/domain/entity/syllabus.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'subject.freezed.dart';

@freezed
abstract class Subject with _$Subject {
  const factory({
    required String id,
    required String name,
    required List<SubjectFaculty> faculties,
    required int year,
    required Semester semester,
    required int credit,
    required List<SubjectEligibleAttribute> eligibleAttributes,
    required List<SubjectRequirement> requirements,
    required Syllabus syllabus,
    required String pastExamId,
  }) = _Subject;
}
