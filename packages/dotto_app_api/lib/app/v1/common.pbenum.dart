// This is a generated file - do not edit.
//
// Generated from app/v1/common.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

/// 学年。
class Grade extends $pb.ProtobufEnum {
  /// 未指定。
  static const Grade GRADE_UNSPECIFIED =
      Grade._(0, _omitEnumNames ? '' : 'GRADE_UNSPECIFIED');

  /// 学部 1 年。
  static const Grade GRADE_B1 = Grade._(1, _omitEnumNames ? '' : 'GRADE_B1');

  /// 学部 2 年。
  static const Grade GRADE_B2 = Grade._(2, _omitEnumNames ? '' : 'GRADE_B2');

  /// 学部 3 年。
  static const Grade GRADE_B3 = Grade._(3, _omitEnumNames ? '' : 'GRADE_B3');

  /// 学部 4 年。
  static const Grade GRADE_B4 = Grade._(4, _omitEnumNames ? '' : 'GRADE_B4');

  /// 修士 1 年。
  static const Grade GRADE_M1 = Grade._(5, _omitEnumNames ? '' : 'GRADE_M1');

  /// 修士 2 年。
  static const Grade GRADE_M2 = Grade._(6, _omitEnumNames ? '' : 'GRADE_M2');

  /// 博士 1 年。
  static const Grade GRADE_D1 = Grade._(7, _omitEnumNames ? '' : 'GRADE_D1');

  /// 博士 2 年。
  static const Grade GRADE_D2 = Grade._(8, _omitEnumNames ? '' : 'GRADE_D2');

  /// 博士 3 年。
  static const Grade GRADE_D3 = Grade._(9, _omitEnumNames ? '' : 'GRADE_D3');

  static const $core.List<Grade> values = <Grade>[
    GRADE_UNSPECIFIED,
    GRADE_B1,
    GRADE_B2,
    GRADE_B3,
    GRADE_B4,
    GRADE_M1,
    GRADE_M2,
    GRADE_D1,
    GRADE_D2,
    GRADE_D3,
  ];

  static final $core.List<Grade?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 9);
  static Grade? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const Grade._(super.value, super.name);
}

/// コース。大学院の場合は大学院コースに読み替える。
class Course extends $pb.ProtobufEnum {
  /// 未指定。
  static const Course COURSE_UNSPECIFIED =
      Course._(0, _omitEnumNames ? '' : 'COURSE_UNSPECIFIED');

  /// 情報システムコース。
  static const Course COURSE_INFORMATION_SYSTEM =
      Course._(1, _omitEnumNames ? '' : 'COURSE_INFORMATION_SYSTEM');

  /// 情報デザインコース。
  static const Course COURSE_INFORMATION_DESIGN =
      Course._(2, _omitEnumNames ? '' : 'COURSE_INFORMATION_DESIGN');

  /// 高度ICTコース。
  static const Course COURSE_ADVANCED_ICT =
      Course._(3, _omitEnumNames ? '' : 'COURSE_ADVANCED_ICT');

  /// 複雑系コース。
  static const Course COURSE_COMPLEX_SYSTEM =
      Course._(4, _omitEnumNames ? '' : 'COURSE_COMPLEX_SYSTEM');

  /// 知能システムコース。
  static const Course COURSE_INTELLIGENT_SYSTEM =
      Course._(5, _omitEnumNames ? '' : 'COURSE_INTELLIGENT_SYSTEM');

  static const $core.List<Course> values = <Course>[
    COURSE_UNSPECIFIED,
    COURSE_INFORMATION_SYSTEM,
    COURSE_INFORMATION_DESIGN,
    COURSE_ADVANCED_ICT,
    COURSE_COMPLEX_SYSTEM,
    COURSE_INTELLIGENT_SYSTEM,
  ];

  static final $core.List<Course?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 5);
  static Course? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const Course._(super.value, super.name);
}

/// クラス。
class Class extends $pb.ProtobufEnum {
  /// 未指定。
  static const Class CLASS_UNSPECIFIED =
      Class._(0, _omitEnumNames ? '' : 'CLASS_UNSPECIFIED');

  /// A クラス。
  static const Class CLASS_A = Class._(1, _omitEnumNames ? '' : 'CLASS_A');

  /// B クラス。
  static const Class CLASS_B = Class._(2, _omitEnumNames ? '' : 'CLASS_B');

  /// C クラス。
  static const Class CLASS_C = Class._(3, _omitEnumNames ? '' : 'CLASS_C');

  /// D クラス。
  static const Class CLASS_D = Class._(4, _omitEnumNames ? '' : 'CLASS_D');

  /// E クラス。
  static const Class CLASS_E = Class._(5, _omitEnumNames ? '' : 'CLASS_E');

  /// F クラス。
  static const Class CLASS_F = Class._(6, _omitEnumNames ? '' : 'CLASS_F');

  /// G クラス。
  static const Class CLASS_G = Class._(7, _omitEnumNames ? '' : 'CLASS_G');

  /// H クラス。
  static const Class CLASS_H = Class._(8, _omitEnumNames ? '' : 'CLASS_H');

  /// I クラス。
  static const Class CLASS_I = Class._(9, _omitEnumNames ? '' : 'CLASS_I');

  /// J クラス。
  static const Class CLASS_J = Class._(10, _omitEnumNames ? '' : 'CLASS_J');

  /// K クラス。
  static const Class CLASS_K = Class._(11, _omitEnumNames ? '' : 'CLASS_K');

  /// L クラス。
  static const Class CLASS_L = Class._(12, _omitEnumNames ? '' : 'CLASS_L');

  static const $core.List<Class> values = <Class>[
    CLASS_UNSPECIFIED,
    CLASS_A,
    CLASS_B,
    CLASS_C,
    CLASS_D,
    CLASS_E,
    CLASS_F,
    CLASS_G,
    CLASS_H,
    CLASS_I,
    CLASS_J,
    CLASS_K,
    CLASS_L,
  ];

  static final $core.List<Class?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 12);
  static Class? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const Class._(super.value, super.name);
}

/// 時限。
class Period extends $pb.ProtobufEnum {
  /// 未指定。
  static const Period PERIOD_UNSPECIFIED =
      Period._(0, _omitEnumNames ? '' : 'PERIOD_UNSPECIFIED');

  /// 1限。
  static const Period PERIOD_1 = Period._(1, _omitEnumNames ? '' : 'PERIOD_1');

  /// 2限。
  static const Period PERIOD_2 = Period._(2, _omitEnumNames ? '' : 'PERIOD_2');

  /// 3限。
  static const Period PERIOD_3 = Period._(3, _omitEnumNames ? '' : 'PERIOD_3');

  /// 4限。
  static const Period PERIOD_4 = Period._(4, _omitEnumNames ? '' : 'PERIOD_4');

  /// 5限。
  static const Period PERIOD_5 = Period._(5, _omitEnumNames ? '' : 'PERIOD_5');

  /// 6限。
  static const Period PERIOD_6 = Period._(6, _omitEnumNames ? '' : 'PERIOD_6');

  static const $core.List<Period> values = <Period>[
    PERIOD_UNSPECIFIED,
    PERIOD_1,
    PERIOD_2,
    PERIOD_3,
    PERIOD_4,
    PERIOD_5,
    PERIOD_6,
  ];

  static final $core.List<Period?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 6);
  static Period? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const Period._(super.value, super.name);
}

const $core.bool _omitEnumNames =
    $core.bool.fromEnvironment('protobuf.omit_enum_names');
