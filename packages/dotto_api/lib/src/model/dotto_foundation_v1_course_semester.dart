//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'dotto_foundation_v1_course_semester.g.dart';

class DottoFoundationV1CourseSemester extends EnumClass {
  /// 開講時期
  @BuiltValueEnumConst(wireName: r'AllYear')
  static const DottoFoundationV1CourseSemester allYear = _$allYear;

  /// 開講時期
  @BuiltValueEnumConst(wireName: r'H1')
  static const DottoFoundationV1CourseSemester H1 = _$H1;

  /// 開講時期
  @BuiltValueEnumConst(wireName: r'H2')
  static const DottoFoundationV1CourseSemester H2 = _$H2;

  /// 開講時期
  @BuiltValueEnumConst(wireName: r'Q1')
  static const DottoFoundationV1CourseSemester Q1 = _$Q1;

  /// 開講時期
  @BuiltValueEnumConst(wireName: r'Q2')
  static const DottoFoundationV1CourseSemester Q2 = _$Q2;

  /// 開講時期
  @BuiltValueEnumConst(wireName: r'Q3')
  static const DottoFoundationV1CourseSemester Q3 = _$Q3;

  /// 開講時期
  @BuiltValueEnumConst(wireName: r'Q4')
  static const DottoFoundationV1CourseSemester Q4 = _$Q4;

  /// 開講時期
  @BuiltValueEnumConst(wireName: r'SummerIntensive')
  static const DottoFoundationV1CourseSemester summerIntensive =
      _$summerIntensive;

  /// 開講時期
  @BuiltValueEnumConst(wireName: r'WinterIntensive')
  static const DottoFoundationV1CourseSemester winterIntensive =
      _$winterIntensive;

  static Serializer<DottoFoundationV1CourseSemester> get serializer =>
      _$dottoFoundationV1CourseSemesterSerializer;

  const DottoFoundationV1CourseSemester._(String name) : super(name);

  static BuiltSet<DottoFoundationV1CourseSemester> get values => _$values;
  static DottoFoundationV1CourseSemester valueOf(String name) =>
      _$valueOf(name);
}

/// Optionally, enum_class can generate a mixin to go with your enum for use
/// with Angular. It exposes your enum constants as getters. So, if you mix it
/// in to your Dart component class, the values become available to the
/// corresponding Angular template.
///
/// Trigger mixin generation by writing a line like this one next to your enum.
abstract class DottoFoundationV1CourseSemesterMixin = Object
    with _$DottoFoundationV1CourseSemesterMixin;
