// This is a generated file - do not edit.
//
// Generated from app/v1/subject.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'common.pbenum.dart' as $1;
import 'faculty.pb.dart' as $0;
import 'subject.pbenum.dart';

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

export 'subject.pbenum.dart';

/// 科目の担当教員。
class SubjectFaculty extends $pb.GeneratedMessage {
  factory SubjectFaculty({
    $0.Faculty? faculty,
    $core.bool? isPrimary,
  }) {
    final result = SubjectFaculty._();
    if (faculty != null) result.faculty = faculty;
    if (isPrimary != null) result.isPrimary = isPrimary;
    return result;
  }

  SubjectFaculty._();

  factory SubjectFaculty.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      SubjectFaculty()..mergeFromBuffer(data, registry);
  factory SubjectFaculty.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      SubjectFaculty()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SubjectFaculty',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'app.v1'),
      createEmptyInstance: SubjectFaculty.$_createMessage)
    ..aOM<$0.Faculty>(1, _omitFieldNames ? '' : 'faculty',
        subBuilder: $0.Faculty.$_createMessage)
    ..aOB(2, _omitFieldNames ? '' : 'isPrimary')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SubjectFaculty clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SubjectFaculty copyWith(void Function(SubjectFaculty) updates) =>
      super.copyWith((message) => updates(message as SubjectFaculty))
          as SubjectFaculty;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use SubjectFaculty() / SubjectFaculty.new instead')
  static SubjectFaculty create() => SubjectFaculty._();
  static $pb.GeneratedMessage $_createMessage() => SubjectFaculty._();
  @$core.override
  SubjectFaculty createEmptyInstance() => SubjectFaculty._();
  @$core.pragma('dart2js:noInline')
  static SubjectFaculty getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SubjectFaculty>(
          SubjectFaculty.$_createMessage);
  static SubjectFaculty? _defaultInstance;

  /// 教員。
  @$pb.TagNumber(1)
  $0.Faculty get faculty => $_getN(0);
  @$pb.TagNumber(1)
  set faculty($0.Faculty value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasFaculty() => $_has(0);
  @$pb.TagNumber(1)
  void clearFaculty() => $_clearField(1);
  @$pb.TagNumber(1)
  $0.Faculty ensureFaculty() => $_ensure(0);

  /// 主担当かどうか。
  @$pb.TagNumber(2)
  $core.bool get isPrimary => $_getBF(1);
  @$pb.TagNumber(2)
  set isPrimary($core.bool value) => $_setBool(1, value);
  @$pb.TagNumber(2)
  $core.bool hasIsPrimary() => $_has(1);
  @$pb.TagNumber(2)
  void clearIsPrimary() => $_clearField(2);
}

/// 対象学年・クラス。
class SubjectEligibleAttribute extends $pb.GeneratedMessage {
  factory SubjectEligibleAttribute({
    $1.Grade? grade,
    $1.Class? class_2,
  }) {
    final result = SubjectEligibleAttribute._();
    if (grade != null) result.grade = grade;
    if (class_2 != null) result.class_2 = class_2;
    return result;
  }

  SubjectEligibleAttribute._();

  factory SubjectEligibleAttribute.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      SubjectEligibleAttribute()..mergeFromBuffer(data, registry);
  factory SubjectEligibleAttribute.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      SubjectEligibleAttribute()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SubjectEligibleAttribute',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'app.v1'),
      createEmptyInstance: SubjectEligibleAttribute.$_createMessage)
    ..aE<$1.Grade>(1, _omitFieldNames ? '' : 'grade',
        enumValues: $1.Grade.values)
    ..aE<$1.Class>(2, _omitFieldNames ? '' : 'class',
        enumValues: $1.Class.values)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SubjectEligibleAttribute clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SubjectEligibleAttribute copyWith(
          void Function(SubjectEligibleAttribute) updates) =>
      super.copyWith((message) => updates(message as SubjectEligibleAttribute))
          as SubjectEligibleAttribute;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use SubjectEligibleAttribute() / SubjectEligibleAttribute.new instead')
  static SubjectEligibleAttribute create() => SubjectEligibleAttribute._();
  static $pb.GeneratedMessage $_createMessage() => SubjectEligibleAttribute._();
  @$core.override
  SubjectEligibleAttribute createEmptyInstance() =>
      SubjectEligibleAttribute._();
  @$core.pragma('dart2js:noInline')
  static SubjectEligibleAttribute getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SubjectEligibleAttribute>(
          SubjectEligibleAttribute.$_createMessage);
  static SubjectEligibleAttribute? _defaultInstance;

  /// 学年。
  @$pb.TagNumber(1)
  $1.Grade get grade => $_getN(0);
  @$pb.TagNumber(1)
  set grade($1.Grade value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasGrade() => $_has(0);
  @$pb.TagNumber(1)
  void clearGrade() => $_clearField(1);

  /// クラス。修士課程・博士課程対象の場合は未設定。
  @$pb.TagNumber(2)
  $1.Class get class_2 => $_getN(1);
  @$pb.TagNumber(2)
  set class_2($1.Class value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasClass_2() => $_has(1);
  @$pb.TagNumber(2)
  void clearClass_2() => $_clearField(2);
}

/// コースごとの必修・選択。
class SubjectRequirement extends $pb.GeneratedMessage {
  factory SubjectRequirement({
    $1.Course? course,
    SubjectRequirementType? requirementType,
  }) {
    final result = SubjectRequirement._();
    if (course != null) result.course = course;
    if (requirementType != null) result.requirementType = requirementType;
    return result;
  }

  SubjectRequirement._();

  factory SubjectRequirement.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      SubjectRequirement()..mergeFromBuffer(data, registry);
  factory SubjectRequirement.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      SubjectRequirement()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SubjectRequirement',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'app.v1'),
      createEmptyInstance: SubjectRequirement.$_createMessage)
    ..aE<$1.Course>(1, _omitFieldNames ? '' : 'course',
        enumValues: $1.Course.values)
    ..aE<SubjectRequirementType>(2, _omitFieldNames ? '' : 'requirementType',
        enumValues: SubjectRequirementType.values)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SubjectRequirement clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SubjectRequirement copyWith(void Function(SubjectRequirement) updates) =>
      super.copyWith((message) => updates(message as SubjectRequirement))
          as SubjectRequirement;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use SubjectRequirement() / SubjectRequirement.new instead')
  static SubjectRequirement create() => SubjectRequirement._();
  static $pb.GeneratedMessage $_createMessage() => SubjectRequirement._();
  @$core.override
  SubjectRequirement createEmptyInstance() => SubjectRequirement._();
  @$core.pragma('dart2js:noInline')
  static SubjectRequirement getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SubjectRequirement>(
          SubjectRequirement.$_createMessage);
  static SubjectRequirement? _defaultInstance;

  /// コース。
  @$pb.TagNumber(1)
  $1.Course get course => $_getN(0);
  @$pb.TagNumber(1)
  set course($1.Course value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasCourse() => $_has(0);
  @$pb.TagNumber(1)
  void clearCourse() => $_clearField(1);

  /// 必修・選択・選択必修。
  @$pb.TagNumber(2)
  SubjectRequirementType get requirementType => $_getN(1);
  @$pb.TagNumber(2)
  set requirementType(SubjectRequirementType value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasRequirementType() => $_has(1);
  @$pb.TagNumber(2)
  void clearRequirementType() => $_clearField(2);
}

/// 科目のシラバス。
class SubjectSyllabus extends $pb.GeneratedMessage {
  factory SubjectSyllabus({
    $core.String? id,
    $core.String? name,
    $core.String? enName,
    $core.String? grades,
    $core.int? credit,
    $core.String? facultyNames,
    $core.String? practicalHomeFacultyCategory,
    $core.String? multiplePersonTeachingForm,
    $core.String? teachingForm,
    $core.String? summary,
    $core.String? learningOutcomes,
    $core.String? assignments,
    $core.String? evaluationMethod,
    $core.String? textbooks,
    $core.String? referenceBooks,
    $core.String? prerequisites,
    $core.String? preLearning,
    $core.String? postLearning,
    $core.String? notes,
    $core.String? keywords,
    $core.String? targetCourses,
    $core.String? targetAreas,
    $core.String? classifications,
    $core.String? teachingLanguage,
    $core.String? contentsAndSchedule,
    $core.String? teachingAndExamForm,
    $core.String? dsopSubject,
  }) {
    final result = SubjectSyllabus._();
    if (id != null) result.id = id;
    if (name != null) result.name = name;
    if (enName != null) result.enName = enName;
    if (grades != null) result.grades = grades;
    if (credit != null) result.credit = credit;
    if (facultyNames != null) result.facultyNames = facultyNames;
    if (practicalHomeFacultyCategory != null)
      result.practicalHomeFacultyCategory = practicalHomeFacultyCategory;
    if (multiplePersonTeachingForm != null)
      result.multiplePersonTeachingForm = multiplePersonTeachingForm;
    if (teachingForm != null) result.teachingForm = teachingForm;
    if (summary != null) result.summary = summary;
    if (learningOutcomes != null) result.learningOutcomes = learningOutcomes;
    if (assignments != null) result.assignments = assignments;
    if (evaluationMethod != null) result.evaluationMethod = evaluationMethod;
    if (textbooks != null) result.textbooks = textbooks;
    if (referenceBooks != null) result.referenceBooks = referenceBooks;
    if (prerequisites != null) result.prerequisites = prerequisites;
    if (preLearning != null) result.preLearning = preLearning;
    if (postLearning != null) result.postLearning = postLearning;
    if (notes != null) result.notes = notes;
    if (keywords != null) result.keywords = keywords;
    if (targetCourses != null) result.targetCourses = targetCourses;
    if (targetAreas != null) result.targetAreas = targetAreas;
    if (classifications != null) result.classifications = classifications;
    if (teachingLanguage != null) result.teachingLanguage = teachingLanguage;
    if (contentsAndSchedule != null)
      result.contentsAndSchedule = contentsAndSchedule;
    if (teachingAndExamForm != null)
      result.teachingAndExamForm = teachingAndExamForm;
    if (dsopSubject != null) result.dsopSubject = dsopSubject;
    return result;
  }

  SubjectSyllabus._();

  factory SubjectSyllabus.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      SubjectSyllabus()..mergeFromBuffer(data, registry);
  factory SubjectSyllabus.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      SubjectSyllabus()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SubjectSyllabus',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'app.v1'),
      createEmptyInstance: SubjectSyllabus.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..aOS(3, _omitFieldNames ? '' : 'enName')
    ..aOS(4, _omitFieldNames ? '' : 'grades')
    ..aI(5, _omitFieldNames ? '' : 'credit')
    ..aOS(6, _omitFieldNames ? '' : 'facultyNames')
    ..aOS(7, _omitFieldNames ? '' : 'practicalHomeFacultyCategory')
    ..aOS(8, _omitFieldNames ? '' : 'multiplePersonTeachingForm')
    ..aOS(9, _omitFieldNames ? '' : 'teachingForm')
    ..aOS(10, _omitFieldNames ? '' : 'summary')
    ..aOS(11, _omitFieldNames ? '' : 'learningOutcomes')
    ..aOS(12, _omitFieldNames ? '' : 'assignments')
    ..aOS(13, _omitFieldNames ? '' : 'evaluationMethod')
    ..aOS(14, _omitFieldNames ? '' : 'textbooks')
    ..aOS(15, _omitFieldNames ? '' : 'referenceBooks')
    ..aOS(16, _omitFieldNames ? '' : 'prerequisites')
    ..aOS(17, _omitFieldNames ? '' : 'preLearning')
    ..aOS(18, _omitFieldNames ? '' : 'postLearning')
    ..aOS(19, _omitFieldNames ? '' : 'notes')
    ..aOS(20, _omitFieldNames ? '' : 'keywords')
    ..aOS(21, _omitFieldNames ? '' : 'targetCourses')
    ..aOS(22, _omitFieldNames ? '' : 'targetAreas')
    ..aOS(23, _omitFieldNames ? '' : 'classifications')
    ..aOS(24, _omitFieldNames ? '' : 'teachingLanguage')
    ..aOS(25, _omitFieldNames ? '' : 'contentsAndSchedule')
    ..aOS(26, _omitFieldNames ? '' : 'teachingAndExamForm')
    ..aOS(27, _omitFieldNames ? '' : 'dsopSubject')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SubjectSyllabus clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SubjectSyllabus copyWith(void Function(SubjectSyllabus) updates) =>
      super.copyWith((message) => updates(message as SubjectSyllabus))
          as SubjectSyllabus;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use SubjectSyllabus() / SubjectSyllabus.new instead')
  static SubjectSyllabus create() => SubjectSyllabus._();
  static $pb.GeneratedMessage $_createMessage() => SubjectSyllabus._();
  @$core.override
  SubjectSyllabus createEmptyInstance() => SubjectSyllabus._();
  @$core.pragma('dart2js:noInline')
  static SubjectSyllabus getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SubjectSyllabus>(
          SubjectSyllabus.$_createMessage);
  static SubjectSyllabus? _defaultInstance;

  /// 教務システムのシラバスID。
  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  /// 授業名。
  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => $_clearField(2);

  /// 授業名（英語）。
  @$pb.TagNumber(3)
  $core.String get enName => $_getSZ(2);
  @$pb.TagNumber(3)
  set enName($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasEnName() => $_has(2);
  @$pb.TagNumber(3)
  void clearEnName() => $_clearField(3);

  /// 配当年次。
  @$pb.TagNumber(4)
  $core.String get grades => $_getSZ(3);
  @$pb.TagNumber(4)
  set grades($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasGrades() => $_has(3);
  @$pb.TagNumber(4)
  void clearGrades() => $_clearField(4);

  /// 単位数。
  @$pb.TagNumber(5)
  $core.int get credit => $_getIZ(4);
  @$pb.TagNumber(5)
  set credit($core.int value) => $_setSignedInt32(4, value);
  @$pb.TagNumber(5)
  $core.bool hasCredit() => $_has(4);
  @$pb.TagNumber(5)
  void clearCredit() => $_clearField(5);

  /// 担当教員名。
  @$pb.TagNumber(6)
  $core.String get facultyNames => $_getSZ(5);
  @$pb.TagNumber(6)
  set facultyNames($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasFacultyNames() => $_has(5);
  @$pb.TagNumber(6)
  void clearFacultyNames() => $_clearField(6);

  /// 実務家教員区分。
  @$pb.TagNumber(7)
  $core.String get practicalHomeFacultyCategory => $_getSZ(6);
  @$pb.TagNumber(7)
  set practicalHomeFacultyCategory($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasPracticalHomeFacultyCategory() => $_has(6);
  @$pb.TagNumber(7)
  void clearPracticalHomeFacultyCategory() => $_clearField(7);

  /// 複数人担当形式。
  @$pb.TagNumber(8)
  $core.String get multiplePersonTeachingForm => $_getSZ(7);
  @$pb.TagNumber(8)
  set multiplePersonTeachingForm($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasMultiplePersonTeachingForm() => $_has(7);
  @$pb.TagNumber(8)
  void clearMultiplePersonTeachingForm() => $_clearField(8);

  /// 授業形態。
  @$pb.TagNumber(9)
  $core.String get teachingForm => $_getSZ(8);
  @$pb.TagNumber(9)
  set teachingForm($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasTeachingForm() => $_has(8);
  @$pb.TagNumber(9)
  void clearTeachingForm() => $_clearField(9);

  /// 授業の概要。
  @$pb.TagNumber(10)
  $core.String get summary => $_getSZ(9);
  @$pb.TagNumber(10)
  set summary($core.String value) => $_setString(9, value);
  @$pb.TagNumber(10)
  $core.bool hasSummary() => $_has(9);
  @$pb.TagNumber(10)
  void clearSummary() => $_clearField(10);

  /// 授業の到達目標。
  @$pb.TagNumber(11)
  $core.String get learningOutcomes => $_getSZ(10);
  @$pb.TagNumber(11)
  set learningOutcomes($core.String value) => $_setString(10, value);
  @$pb.TagNumber(11)
  $core.bool hasLearningOutcomes() => $_has(10);
  @$pb.TagNumber(11)
  void clearLearningOutcomes() => $_clearField(11);

  /// 提出課題等。
  @$pb.TagNumber(12)
  $core.String get assignments => $_getSZ(11);
  @$pb.TagNumber(12)
  set assignments($core.String value) => $_setString(11, value);
  @$pb.TagNumber(12)
  $core.bool hasAssignments() => $_has(11);
  @$pb.TagNumber(12)
  void clearAssignments() => $_clearField(12);

  /// 成績の評価方法・基準。
  @$pb.TagNumber(13)
  $core.String get evaluationMethod => $_getSZ(12);
  @$pb.TagNumber(13)
  set evaluationMethod($core.String value) => $_setString(12, value);
  @$pb.TagNumber(13)
  $core.bool hasEvaluationMethod() => $_has(12);
  @$pb.TagNumber(13)
  void clearEvaluationMethod() => $_clearField(13);

  /// テキスト。
  @$pb.TagNumber(14)
  $core.String get textbooks => $_getSZ(13);
  @$pb.TagNumber(14)
  set textbooks($core.String value) => $_setString(13, value);
  @$pb.TagNumber(14)
  $core.bool hasTextbooks() => $_has(13);
  @$pb.TagNumber(14)
  void clearTextbooks() => $_clearField(14);

  /// 参考書。
  @$pb.TagNumber(15)
  $core.String get referenceBooks => $_getSZ(14);
  @$pb.TagNumber(15)
  set referenceBooks($core.String value) => $_setString(14, value);
  @$pb.TagNumber(15)
  $core.bool hasReferenceBooks() => $_has(14);
  @$pb.TagNumber(15)
  void clearReferenceBooks() => $_clearField(15);

  /// 履修条件。
  @$pb.TagNumber(16)
  $core.String get prerequisites => $_getSZ(15);
  @$pb.TagNumber(16)
  set prerequisites($core.String value) => $_setString(15, value);
  @$pb.TagNumber(16)
  $core.bool hasPrerequisites() => $_has(15);
  @$pb.TagNumber(16)
  void clearPrerequisites() => $_clearField(16);

  /// 事前学習。
  @$pb.TagNumber(17)
  $core.String get preLearning => $_getSZ(16);
  @$pb.TagNumber(17)
  set preLearning($core.String value) => $_setString(16, value);
  @$pb.TagNumber(17)
  $core.bool hasPreLearning() => $_has(16);
  @$pb.TagNumber(17)
  void clearPreLearning() => $_clearField(17);

  /// 事後学習。
  @$pb.TagNumber(18)
  $core.String get postLearning => $_getSZ(17);
  @$pb.TagNumber(18)
  set postLearning($core.String value) => $_setString(17, value);
  @$pb.TagNumber(18)
  $core.bool hasPostLearning() => $_has(17);
  @$pb.TagNumber(18)
  void clearPostLearning() => $_clearField(18);

  /// 履修上の留意点。
  @$pb.TagNumber(19)
  $core.String get notes => $_getSZ(18);
  @$pb.TagNumber(19)
  set notes($core.String value) => $_setString(18, value);
  @$pb.TagNumber(19)
  $core.bool hasNotes() => $_has(18);
  @$pb.TagNumber(19)
  void clearNotes() => $_clearField(19);

  /// キーワード。
  @$pb.TagNumber(20)
  $core.String get keywords => $_getSZ(19);
  @$pb.TagNumber(20)
  set keywords($core.String value) => $_setString(19, value);
  @$pb.TagNumber(20)
  $core.bool hasKeywords() => $_has(19);
  @$pb.TagNumber(20)
  void clearKeywords() => $_clearField(20);

  /// 対象コース・領域。
  @$pb.TagNumber(21)
  $core.String get targetCourses => $_getSZ(20);
  @$pb.TagNumber(21)
  set targetCourses($core.String value) => $_setString(20, value);
  @$pb.TagNumber(21)
  $core.bool hasTargetCourses() => $_has(20);
  @$pb.TagNumber(21)
  void clearTargetCourses() => $_clearField(21);

  /// 対象領域。
  @$pb.TagNumber(22)
  $core.String get targetAreas => $_getSZ(21);
  @$pb.TagNumber(22)
  set targetAreas($core.String value) => $_setString(21, value);
  @$pb.TagNumber(22)
  $core.bool hasTargetAreas() => $_has(21);
  @$pb.TagNumber(22)
  void clearTargetAreas() => $_clearField(22);

  /// 科目群・科目区分。
  @$pb.TagNumber(23)
  $core.String get classifications => $_getSZ(22);
  @$pb.TagNumber(23)
  set classifications($core.String value) => $_setString(22, value);
  @$pb.TagNumber(23)
  $core.bool hasClassifications() => $_has(22);
  @$pb.TagNumber(23)
  void clearClassifications() => $_clearField(23);

  /// 教授言語。
  @$pb.TagNumber(24)
  $core.String get teachingLanguage => $_getSZ(23);
  @$pb.TagNumber(24)
  set teachingLanguage($core.String value) => $_setString(23, value);
  @$pb.TagNumber(24)
  $core.bool hasTeachingLanguage() => $_has(23);
  @$pb.TagNumber(24)
  void clearTeachingLanguage() => $_clearField(24);

  /// 授業内容とスケジュール。
  @$pb.TagNumber(25)
  $core.String get contentsAndSchedule => $_getSZ(24);
  @$pb.TagNumber(25)
  set contentsAndSchedule($core.String value) => $_setString(24, value);
  @$pb.TagNumber(25)
  $core.bool hasContentsAndSchedule() => $_has(24);
  @$pb.TagNumber(25)
  void clearContentsAndSchedule() => $_clearField(25);

  /// 授業・試験の形式。
  @$pb.TagNumber(26)
  $core.String get teachingAndExamForm => $_getSZ(25);
  @$pb.TagNumber(26)
  set teachingAndExamForm($core.String value) => $_setString(25, value);
  @$pb.TagNumber(26)
  $core.bool hasTeachingAndExamForm() => $_has(25);
  @$pb.TagNumber(26)
  void clearTeachingAndExamForm() => $_clearField(26);

  /// DSOP 対象科目。
  @$pb.TagNumber(27)
  $core.String get dsopSubject => $_getSZ(26);
  @$pb.TagNumber(27)
  set dsopSubject($core.String value) => $_setString(26, value);
  @$pb.TagNumber(27)
  $core.bool hasDsopSubject() => $_has(26);
  @$pb.TagNumber(27)
  void clearDsopSubject() => $_clearField(27);
}

/// 科目。
/// eligible_attributes / requirements / syllabus は GetSubject でのみ設定し、それ以外の RPC では未設定とする。
class Subject extends $pb.GeneratedMessage {
  factory Subject({
    $core.String? id,
    $core.String? name,
    $core.Iterable<SubjectFaculty>? faculties,
    $core.int? year,
    SubjectSemester? semester,
    $core.int? credit,
    $core.Iterable<SubjectEligibleAttribute>? eligibleAttributes,
    $core.Iterable<SubjectRequirement>? requirements,
    SubjectSyllabus? syllabus,
  }) {
    final result = Subject._();
    if (id != null) result.id = id;
    if (name != null) result.name = name;
    if (faculties != null) result.faculties.addAll(faculties);
    if (year != null) result.year = year;
    if (semester != null) result.semester = semester;
    if (credit != null) result.credit = credit;
    if (eligibleAttributes != null)
      result.eligibleAttributes.addAll(eligibleAttributes);
    if (requirements != null) result.requirements.addAll(requirements);
    if (syllabus != null) result.syllabus = syllabus;
    return result;
  }

  Subject._();

  factory Subject.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      Subject()..mergeFromBuffer(data, registry);
  factory Subject.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      Subject()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Subject',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'app.v1'),
      createEmptyInstance: Subject.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..pPM<SubjectFaculty>(3, _omitFieldNames ? '' : 'faculties',
        subBuilder: SubjectFaculty.$_createMessage)
    ..aI(4, _omitFieldNames ? '' : 'year')
    ..aE<SubjectSemester>(5, _omitFieldNames ? '' : 'semester',
        enumValues: SubjectSemester.values)
    ..aI(6, _omitFieldNames ? '' : 'credit')
    ..pPM<SubjectEligibleAttribute>(
        7, _omitFieldNames ? '' : 'eligibleAttributes',
        subBuilder: SubjectEligibleAttribute.$_createMessage)
    ..pPM<SubjectRequirement>(8, _omitFieldNames ? '' : 'requirements',
        subBuilder: SubjectRequirement.$_createMessage)
    ..aOM<SubjectSyllabus>(9, _omitFieldNames ? '' : 'syllabus',
        subBuilder: SubjectSyllabus.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Subject clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Subject copyWith(void Function(Subject) updates) =>
      super.copyWith((message) => updates(message as Subject)) as Subject;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use Subject() / Subject.new instead')
  static Subject create() => Subject._();
  static $pb.GeneratedMessage $_createMessage() => Subject._();
  @$core.override
  Subject createEmptyInstance() => Subject._();
  @$core.pragma('dart2js:noInline')
  static Subject getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<Subject>(Subject.$_createMessage);
  static Subject? _defaultInstance;

  /// ID。
  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  /// 科目名。
  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => $_clearField(2);

  /// 担当教員。
  @$pb.TagNumber(3)
  $pb.PbList<SubjectFaculty> get faculties => $_getList(2);

  /// 開講年度。
  @$pb.TagNumber(4)
  $core.int get year => $_getIZ(3);
  @$pb.TagNumber(4)
  set year($core.int value) => $_setSignedInt32(3, value);
  @$pb.TagNumber(4)
  $core.bool hasYear() => $_has(3);
  @$pb.TagNumber(4)
  void clearYear() => $_clearField(4);

  /// 開講時期。
  @$pb.TagNumber(5)
  SubjectSemester get semester => $_getN(4);
  @$pb.TagNumber(5)
  set semester(SubjectSemester value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasSemester() => $_has(4);
  @$pb.TagNumber(5)
  void clearSemester() => $_clearField(5);

  /// 単位数。
  @$pb.TagNumber(6)
  $core.int get credit => $_getIZ(5);
  @$pb.TagNumber(6)
  set credit($core.int value) => $_setSignedInt32(5, value);
  @$pb.TagNumber(6)
  $core.bool hasCredit() => $_has(5);
  @$pb.TagNumber(6)
  void clearCredit() => $_clearField(6);

  /// 対象学年・クラス。授業名末尾の `学年-クラス` をもとに決定する。GetSubject でのみ設定する。
  @$pb.TagNumber(7)
  $pb.PbList<SubjectEligibleAttribute> get eligibleAttributes => $_getList(6);

  /// コースごとの必修・選択。科目群・科目区分をもとに決定する。GetSubject でのみ設定する。
  @$pb.TagNumber(8)
  $pb.PbList<SubjectRequirement> get requirements => $_getList(7);

  /// シラバス。GetSubject でのみ設定する。
  @$pb.TagNumber(9)
  SubjectSyllabus get syllabus => $_getN(8);
  @$pb.TagNumber(9)
  set syllabus(SubjectSyllabus value) => $_setField(9, value);
  @$pb.TagNumber(9)
  $core.bool hasSyllabus() => $_has(8);
  @$pb.TagNumber(9)
  void clearSyllabus() => $_clearField(9);
  @$pb.TagNumber(9)
  SubjectSyllabus ensureSyllabus() => $_ensure(8);
}

/// ListSubjects の Request。
class ListSubjectsRequest extends $pb.GeneratedMessage {
  factory ListSubjectsRequest({
    $core.String? query,
    $core.Iterable<$1.Grade>? grades,
    $core.Iterable<$1.Course>? courses,
    $core.Iterable<$1.Class>? classes,
    $core.Iterable<SubjectClassification>? classifications,
    $core.Iterable<SubjectSemester>? semesters,
    $core.Iterable<SubjectRequirementType>? requirementTypes,
    $core.Iterable<SubjectCulturalSubjectCategory>? culturalSubjectCategories,
  }) {
    final result = ListSubjectsRequest._();
    if (query != null) result.query = query;
    if (grades != null) result.grades.addAll(grades);
    if (courses != null) result.courses.addAll(courses);
    if (classes != null) result.classes.addAll(classes);
    if (classifications != null) result.classifications.addAll(classifications);
    if (semesters != null) result.semesters.addAll(semesters);
    if (requirementTypes != null)
      result.requirementTypes.addAll(requirementTypes);
    if (culturalSubjectCategories != null)
      result.culturalSubjectCategories.addAll(culturalSubjectCategories);
    return result;
  }

  ListSubjectsRequest._();

  factory ListSubjectsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ListSubjectsRequest()..mergeFromBuffer(data, registry);
  factory ListSubjectsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ListSubjectsRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListSubjectsRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'app.v1'),
      createEmptyInstance: ListSubjectsRequest.$_createMessage)
    ..aOS(3, _omitFieldNames ? '' : 'query')
    ..pc<$1.Grade>(4, _omitFieldNames ? '' : 'grades', $pb.PbFieldType.KE,
        valueOf: $1.Grade.valueOf,
        enumValues: $1.Grade.values,
        defaultEnumValue: $1.Grade.GRADE_UNSPECIFIED)
    ..pc<$1.Course>(5, _omitFieldNames ? '' : 'courses', $pb.PbFieldType.KE,
        valueOf: $1.Course.valueOf,
        enumValues: $1.Course.values,
        defaultEnumValue: $1.Course.COURSE_UNSPECIFIED)
    ..pc<$1.Class>(6, _omitFieldNames ? '' : 'classes', $pb.PbFieldType.KE,
        valueOf: $1.Class.valueOf,
        enumValues: $1.Class.values,
        defaultEnumValue: $1.Class.CLASS_UNSPECIFIED)
    ..pc<SubjectClassification>(
        7, _omitFieldNames ? '' : 'classifications', $pb.PbFieldType.KE,
        valueOf: SubjectClassification.valueOf,
        enumValues: SubjectClassification.values,
        defaultEnumValue:
            SubjectClassification.SUBJECT_CLASSIFICATION_UNSPECIFIED)
    ..pc<SubjectSemester>(
        8, _omitFieldNames ? '' : 'semesters', $pb.PbFieldType.KE,
        valueOf: SubjectSemester.valueOf,
        enumValues: SubjectSemester.values,
        defaultEnumValue: SubjectSemester.SUBJECT_SEMESTER_UNSPECIFIED)
    ..pc<SubjectRequirementType>(
        9, _omitFieldNames ? '' : 'requirementTypes', $pb.PbFieldType.KE,
        valueOf: SubjectRequirementType.valueOf,
        enumValues: SubjectRequirementType.values,
        defaultEnumValue:
            SubjectRequirementType.SUBJECT_REQUIREMENT_TYPE_UNSPECIFIED)
    ..pc<SubjectCulturalSubjectCategory>(10,
        _omitFieldNames ? '' : 'culturalSubjectCategories', $pb.PbFieldType.KE,
        valueOf: SubjectCulturalSubjectCategory.valueOf,
        enumValues: SubjectCulturalSubjectCategory.values,
        defaultEnumValue: SubjectCulturalSubjectCategory
            .SUBJECT_CULTURAL_SUBJECT_CATEGORY_UNSPECIFIED)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListSubjectsRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListSubjectsRequest copyWith(void Function(ListSubjectsRequest) updates) =>
      super.copyWith((message) => updates(message as ListSubjectsRequest))
          as ListSubjectsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core
      .Deprecated('Use ListSubjectsRequest() / ListSubjectsRequest.new instead')
  static ListSubjectsRequest create() => ListSubjectsRequest._();
  static $pb.GeneratedMessage $_createMessage() => ListSubjectsRequest._();
  @$core.override
  ListSubjectsRequest createEmptyInstance() => ListSubjectsRequest._();
  @$core.pragma('dart2js:noInline')
  static ListSubjectsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListSubjectsRequest>(
          ListSubjectsRequest.$_createMessage);
  static ListSubjectsRequest? _defaultInstance;

  /// 検索ワード。空文字の場合は絞り込まない。
  @$pb.TagNumber(3)
  $core.String get query => $_getSZ(0);
  @$pb.TagNumber(3)
  set query($core.String value) => $_setString(0, value);
  @$pb.TagNumber(3)
  $core.bool hasQuery() => $_has(0);
  @$pb.TagNumber(3)
  void clearQuery() => $_clearField(3);

  /// 学年。空の場合は絞り込まない。
  @$pb.TagNumber(4)
  $pb.PbList<$1.Grade> get grades => $_getList(1);

  /// コース。大学院の場合は大学院コースに読み替える。空の場合は絞り込まない。
  @$pb.TagNumber(5)
  $pb.PbList<$1.Course> get courses => $_getList(2);

  /// クラス。大学院の学年を指定した場合は指定できない。空の場合は絞り込まない。
  @$pb.TagNumber(6)
  $pb.PbList<$1.Class> get classes => $_getList(3);

  /// 科目カテゴリ（学部: 専門・教養、大学院: 専門・研究指導）。空の場合は絞り込まない。
  @$pb.TagNumber(7)
  $pb.PbList<SubjectClassification> get classifications => $_getList(4);

  /// 開講時期。空の場合は絞り込まない。
  @$pb.TagNumber(8)
  $pb.PbList<SubjectSemester> get semesters => $_getList(5);

  /// 必修・選択・選択必修。空の場合は絞り込まない。
  @$pb.TagNumber(9)
  $pb.PbList<SubjectRequirementType> get requirementTypes => $_getList(6);

  /// 教養科目カテゴリ。空の場合は絞り込まない。
  @$pb.TagNumber(10)
  $pb.PbList<SubjectCulturalSubjectCategory> get culturalSubjectCategories =>
      $_getList(7);
}

/// ListSubjects の Response。
class ListSubjectsResponse extends $pb.GeneratedMessage {
  factory ListSubjectsResponse({
    $core.Iterable<Subject>? subjects,
  }) {
    final result = ListSubjectsResponse._();
    if (subjects != null) result.subjects.addAll(subjects);
    return result;
  }

  ListSubjectsResponse._();

  factory ListSubjectsResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ListSubjectsResponse()..mergeFromBuffer(data, registry);
  factory ListSubjectsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ListSubjectsResponse()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListSubjectsResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'app.v1'),
      createEmptyInstance: ListSubjectsResponse.$_createMessage)
    ..pPM<Subject>(1, _omitFieldNames ? '' : 'subjects',
        subBuilder: Subject.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListSubjectsResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListSubjectsResponse copyWith(void Function(ListSubjectsResponse) updates) =>
      super.copyWith((message) => updates(message as ListSubjectsResponse))
          as ListSubjectsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use ListSubjectsResponse() / ListSubjectsResponse.new instead')
  static ListSubjectsResponse create() => ListSubjectsResponse._();
  static $pb.GeneratedMessage $_createMessage() => ListSubjectsResponse._();
  @$core.override
  ListSubjectsResponse createEmptyInstance() => ListSubjectsResponse._();
  @$core.pragma('dart2js:noInline')
  static ListSubjectsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListSubjectsResponse>(
          ListSubjectsResponse.$_createMessage);
  static ListSubjectsResponse? _defaultInstance;

  /// 科目の一覧。
  @$pb.TagNumber(1)
  $pb.PbList<Subject> get subjects => $_getList(0);
}

/// GetSubject の Request。
class GetSubjectRequest extends $pb.GeneratedMessage {
  factory GetSubjectRequest({
    $core.String? id,
  }) {
    final result = GetSubjectRequest._();
    if (id != null) result.id = id;
    return result;
  }

  GetSubjectRequest._();

  factory GetSubjectRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GetSubjectRequest()..mergeFromBuffer(data, registry);
  factory GetSubjectRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GetSubjectRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetSubjectRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'app.v1'),
      createEmptyInstance: GetSubjectRequest.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetSubjectRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetSubjectRequest copyWith(void Function(GetSubjectRequest) updates) =>
      super.copyWith((message) => updates(message as GetSubjectRequest))
          as GetSubjectRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use GetSubjectRequest() / GetSubjectRequest.new instead')
  static GetSubjectRequest create() => GetSubjectRequest._();
  static $pb.GeneratedMessage $_createMessage() => GetSubjectRequest._();
  @$core.override
  GetSubjectRequest createEmptyInstance() => GetSubjectRequest._();
  @$core.pragma('dart2js:noInline')
  static GetSubjectRequest getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetSubjectRequest>(
          GetSubjectRequest.$_createMessage);
  static GetSubjectRequest? _defaultInstance;

  /// 取得する科目ID。
  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);
}

/// GetSubject の Response。
class GetSubjectResponse extends $pb.GeneratedMessage {
  factory GetSubjectResponse({
    Subject? subject,
  }) {
    final result = GetSubjectResponse._();
    if (subject != null) result.subject = subject;
    return result;
  }

  GetSubjectResponse._();

  factory GetSubjectResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GetSubjectResponse()..mergeFromBuffer(data, registry);
  factory GetSubjectResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GetSubjectResponse()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetSubjectResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'app.v1'),
      createEmptyInstance: GetSubjectResponse.$_createMessage)
    ..aOM<Subject>(1, _omitFieldNames ? '' : 'subject',
        subBuilder: Subject.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetSubjectResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetSubjectResponse copyWith(void Function(GetSubjectResponse) updates) =>
      super.copyWith((message) => updates(message as GetSubjectResponse))
          as GetSubjectResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use GetSubjectResponse() / GetSubjectResponse.new instead')
  static GetSubjectResponse create() => GetSubjectResponse._();
  static $pb.GeneratedMessage $_createMessage() => GetSubjectResponse._();
  @$core.override
  GetSubjectResponse createEmptyInstance() => GetSubjectResponse._();
  @$core.pragma('dart2js:noInline')
  static GetSubjectResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetSubjectResponse>(
          GetSubjectResponse.$_createMessage);
  static GetSubjectResponse? _defaultInstance;

  /// 取得した科目。
  @$pb.TagNumber(1)
  Subject get subject => $_getN(0);
  @$pb.TagNumber(1)
  set subject(Subject value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasSubject() => $_has(0);
  @$pb.TagNumber(1)
  void clearSubject() => $_clearField(1);
  @$pb.TagNumber(1)
  Subject ensureSubject() => $_ensure(0);
}

/// 科目を提供する。
class SubjectServiceApi {
  final $pb.RpcClient _client;

  SubjectServiceApi(this._client);

  /// 科目を検索する。同一項目同士は OR、異なる項目同士は AND で絞り込む。
  $async.Future<ListSubjectsResponse> listSubjects(
          $pb.ClientContext? ctx, ListSubjectsRequest request) =>
      _client.invoke<ListSubjectsResponse>(ctx, 'SubjectService',
          'ListSubjects', request, ListSubjectsResponse());

  /// 科目の詳細を取得する。
  $async.Future<GetSubjectResponse> getSubject(
          $pb.ClientContext? ctx, GetSubjectRequest request) =>
      _client.invoke<GetSubjectResponse>(
          ctx, 'SubjectService', 'GetSubject', request, GetSubjectResponse());
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
