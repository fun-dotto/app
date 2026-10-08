import 'package:dotto/domain/entity/academic_class.dart';
import 'package:dotto/domain/entity/grade.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'subject_eligible_attribute.freezed.dart';

@freezed
abstract class SubjectEligibleAttribute with _$SubjectEligibleAttribute {
  const factory({required Grade grade, required AcademicClass? class_}) =
      _SubjectEligibleAttribute;
}
