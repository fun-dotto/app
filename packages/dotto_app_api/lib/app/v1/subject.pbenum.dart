// This is a generated file - do not edit.
//
// Generated from app/v1/subject.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

/// 科目の開講時期。
class SubjectSemester extends $pb.ProtobufEnum {
  /// 未指定。
  static const SubjectSemester SUBJECT_SEMESTER_UNSPECIFIED = SubjectSemester._(
      0, _omitEnumNames ? '' : 'SUBJECT_SEMESTER_UNSPECIFIED');

  /// 通年。
  static const SubjectSemester SUBJECT_SEMESTER_ALL_YEAR =
      SubjectSemester._(1, _omitEnumNames ? '' : 'SUBJECT_SEMESTER_ALL_YEAR');

  /// 前期。
  static const SubjectSemester SUBJECT_SEMESTER_H1 =
      SubjectSemester._(2, _omitEnumNames ? '' : 'SUBJECT_SEMESTER_H1');

  /// 後期。
  static const SubjectSemester SUBJECT_SEMESTER_H2 =
      SubjectSemester._(3, _omitEnumNames ? '' : 'SUBJECT_SEMESTER_H2');

  /// 第1クオーター。
  static const SubjectSemester SUBJECT_SEMESTER_Q1 =
      SubjectSemester._(4, _omitEnumNames ? '' : 'SUBJECT_SEMESTER_Q1');

  /// 第2クオーター。
  static const SubjectSemester SUBJECT_SEMESTER_Q2 =
      SubjectSemester._(5, _omitEnumNames ? '' : 'SUBJECT_SEMESTER_Q2');

  /// 第3クオーター。
  static const SubjectSemester SUBJECT_SEMESTER_Q3 =
      SubjectSemester._(6, _omitEnumNames ? '' : 'SUBJECT_SEMESTER_Q3');

  /// 第4クオーター。
  static const SubjectSemester SUBJECT_SEMESTER_Q4 =
      SubjectSemester._(7, _omitEnumNames ? '' : 'SUBJECT_SEMESTER_Q4');

  /// 夏期集中。
  static const SubjectSemester SUBJECT_SEMESTER_SUMMER_INTENSIVE =
      SubjectSemester._(
          8, _omitEnumNames ? '' : 'SUBJECT_SEMESTER_SUMMER_INTENSIVE');

  /// 冬期集中。
  static const SubjectSemester SUBJECT_SEMESTER_WINTER_INTENSIVE =
      SubjectSemester._(
          9, _omitEnumNames ? '' : 'SUBJECT_SEMESTER_WINTER_INTENSIVE');

  static const $core.List<SubjectSemester> values = <SubjectSemester>[
    SUBJECT_SEMESTER_UNSPECIFIED,
    SUBJECT_SEMESTER_ALL_YEAR,
    SUBJECT_SEMESTER_H1,
    SUBJECT_SEMESTER_H2,
    SUBJECT_SEMESTER_Q1,
    SUBJECT_SEMESTER_Q2,
    SUBJECT_SEMESTER_Q3,
    SUBJECT_SEMESTER_Q4,
    SUBJECT_SEMESTER_SUMMER_INTENSIVE,
    SUBJECT_SEMESTER_WINTER_INTENSIVE,
  ];

  static final $core.List<SubjectSemester?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 9);
  static SubjectSemester? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const SubjectSemester._(super.value, super.name);
}

/// 科目カテゴリ。
class SubjectClassification extends $pb.ProtobufEnum {
  /// 未指定。
  static const SubjectClassification SUBJECT_CLASSIFICATION_UNSPECIFIED =
      SubjectClassification._(
          0, _omitEnumNames ? '' : 'SUBJECT_CLASSIFICATION_UNSPECIFIED');

  /// 専門科目。
  static const SubjectClassification SUBJECT_CLASSIFICATION_SPECIALIZED =
      SubjectClassification._(
          1, _omitEnumNames ? '' : 'SUBJECT_CLASSIFICATION_SPECIALIZED');

  /// 教養科目。
  static const SubjectClassification SUBJECT_CLASSIFICATION_CULTURAL =
      SubjectClassification._(
          2, _omitEnumNames ? '' : 'SUBJECT_CLASSIFICATION_CULTURAL');

  /// 研究指導。
  static const SubjectClassification
      SUBJECT_CLASSIFICATION_RESEARCH_INSTRUCTION = SubjectClassification._(3,
          _omitEnumNames ? '' : 'SUBJECT_CLASSIFICATION_RESEARCH_INSTRUCTION');

  static const $core.List<SubjectClassification> values =
      <SubjectClassification>[
    SUBJECT_CLASSIFICATION_UNSPECIFIED,
    SUBJECT_CLASSIFICATION_SPECIALIZED,
    SUBJECT_CLASSIFICATION_CULTURAL,
    SUBJECT_CLASSIFICATION_RESEARCH_INSTRUCTION,
  ];

  static final $core.List<SubjectClassification?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 3);
  static SubjectClassification? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const SubjectClassification._(super.value, super.name);
}

/// 教養科目カテゴリ。
class SubjectCulturalSubjectCategory extends $pb.ProtobufEnum {
  /// 未指定。
  static const SubjectCulturalSubjectCategory
      SUBJECT_CULTURAL_SUBJECT_CATEGORY_UNSPECIFIED =
      SubjectCulturalSubjectCategory._(
          0,
          _omitEnumNames
              ? ''
              : 'SUBJECT_CULTURAL_SUBJECT_CATEGORY_UNSPECIFIED');

  /// 社会。
  static const SubjectCulturalSubjectCategory
      SUBJECT_CULTURAL_SUBJECT_CATEGORY_SOCIETY =
      SubjectCulturalSubjectCategory._(
          1, _omitEnumNames ? '' : 'SUBJECT_CULTURAL_SUBJECT_CATEGORY_SOCIETY');

  /// 人間。
  static const SubjectCulturalSubjectCategory
      SUBJECT_CULTURAL_SUBJECT_CATEGORY_HUMAN =
      SubjectCulturalSubjectCategory._(
          2, _omitEnumNames ? '' : 'SUBJECT_CULTURAL_SUBJECT_CATEGORY_HUMAN');

  /// 科学。
  static const SubjectCulturalSubjectCategory
      SUBJECT_CULTURAL_SUBJECT_CATEGORY_SCIENCE =
      SubjectCulturalSubjectCategory._(
          3, _omitEnumNames ? '' : 'SUBJECT_CULTURAL_SUBJECT_CATEGORY_SCIENCE');

  /// 健康。
  static const SubjectCulturalSubjectCategory
      SUBJECT_CULTURAL_SUBJECT_CATEGORY_HEALTH =
      SubjectCulturalSubjectCategory._(
          4, _omitEnumNames ? '' : 'SUBJECT_CULTURAL_SUBJECT_CATEGORY_HEALTH');

  /// コミュニケーション。
  static const SubjectCulturalSubjectCategory
      SUBJECT_CULTURAL_SUBJECT_CATEGORY_COMMUNICATION =
      SubjectCulturalSubjectCategory._(
          5,
          _omitEnumNames
              ? ''
              : 'SUBJECT_CULTURAL_SUBJECT_CATEGORY_COMMUNICATION');

  static const $core.List<SubjectCulturalSubjectCategory> values =
      <SubjectCulturalSubjectCategory>[
    SUBJECT_CULTURAL_SUBJECT_CATEGORY_UNSPECIFIED,
    SUBJECT_CULTURAL_SUBJECT_CATEGORY_SOCIETY,
    SUBJECT_CULTURAL_SUBJECT_CATEGORY_HUMAN,
    SUBJECT_CULTURAL_SUBJECT_CATEGORY_SCIENCE,
    SUBJECT_CULTURAL_SUBJECT_CATEGORY_HEALTH,
    SUBJECT_CULTURAL_SUBJECT_CATEGORY_COMMUNICATION,
  ];

  static final $core.List<SubjectCulturalSubjectCategory?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 5);
  static SubjectCulturalSubjectCategory? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const SubjectCulturalSubjectCategory._(super.value, super.name);
}

/// 必修・選択。
class SubjectRequirementType extends $pb.ProtobufEnum {
  /// 未指定。
  static const SubjectRequirementType SUBJECT_REQUIREMENT_TYPE_UNSPECIFIED =
      SubjectRequirementType._(
          0, _omitEnumNames ? '' : 'SUBJECT_REQUIREMENT_TYPE_UNSPECIFIED');

  /// 必修。
  static const SubjectRequirementType SUBJECT_REQUIREMENT_TYPE_REQUIRED =
      SubjectRequirementType._(
          1, _omitEnumNames ? '' : 'SUBJECT_REQUIREMENT_TYPE_REQUIRED');

  /// 選択。
  static const SubjectRequirementType SUBJECT_REQUIREMENT_TYPE_OPTIONAL =
      SubjectRequirementType._(
          2, _omitEnumNames ? '' : 'SUBJECT_REQUIREMENT_TYPE_OPTIONAL');

  /// 選択必修。
  static const SubjectRequirementType
      SUBJECT_REQUIREMENT_TYPE_OPTIONAL_REQUIRED = SubjectRequirementType._(3,
          _omitEnumNames ? '' : 'SUBJECT_REQUIREMENT_TYPE_OPTIONAL_REQUIRED');

  static const $core.List<SubjectRequirementType> values =
      <SubjectRequirementType>[
    SUBJECT_REQUIREMENT_TYPE_UNSPECIFIED,
    SUBJECT_REQUIREMENT_TYPE_REQUIRED,
    SUBJECT_REQUIREMENT_TYPE_OPTIONAL,
    SUBJECT_REQUIREMENT_TYPE_OPTIONAL_REQUIRED,
  ];

  static final $core.List<SubjectRequirementType?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 3);
  static SubjectRequirementType? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const SubjectRequirementType._(super.value, super.name);
}

const $core.bool _omitEnumNames =
    $core.bool.fromEnvironment('protobuf.omit_enum_names');
