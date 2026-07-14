//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'dotto_foundation_v1_grade.g.dart';

class DottoFoundationV1Grade extends EnumClass {
  /// 学年
  @BuiltValueEnumConst(wireName: r'B1')
  static const DottoFoundationV1Grade B1 = _$B1;

  /// 学年
  @BuiltValueEnumConst(wireName: r'B2')
  static const DottoFoundationV1Grade B2 = _$B2;

  /// 学年
  @BuiltValueEnumConst(wireName: r'B3')
  static const DottoFoundationV1Grade B3 = _$B3;

  /// 学年
  @BuiltValueEnumConst(wireName: r'B4')
  static const DottoFoundationV1Grade B4 = _$B4;

  /// 学年
  @BuiltValueEnumConst(wireName: r'M1')
  static const DottoFoundationV1Grade M1 = _$M1;

  /// 学年
  @BuiltValueEnumConst(wireName: r'M2')
  static const DottoFoundationV1Grade M2 = _$M2;

  /// 学年
  @BuiltValueEnumConst(wireName: r'D1')
  static const DottoFoundationV1Grade D1 = _$D1;

  /// 学年
  @BuiltValueEnumConst(wireName: r'D2')
  static const DottoFoundationV1Grade D2 = _$D2;

  /// 学年
  @BuiltValueEnumConst(wireName: r'D3')
  static const DottoFoundationV1Grade D3 = _$D3;

  static Serializer<DottoFoundationV1Grade> get serializer =>
      _$dottoFoundationV1GradeSerializer;

  const DottoFoundationV1Grade._(String name) : super(name);

  static BuiltSet<DottoFoundationV1Grade> get values => _$values;
  static DottoFoundationV1Grade valueOf(String name) => _$valueOf(name);
}

/// Optionally, enum_class can generate a mixin to go with your enum for use
/// with Angular. It exposes your enum constants as getters. So, if you mix it
/// in to your Dart component class, the values become available to the
/// corresponding Angular template.
///
/// Trigger mixin generation by writing a line like this one next to your enum.
abstract class DottoFoundationV1GradeMixin = Object
    with _$DottoFoundationV1GradeMixin;
