import 'package:dotto/domain/entity/academic_area.dart';
import 'package:dotto/domain/entity/academic_class.dart';
import 'package:dotto/domain/entity/grade.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'dotto_user.freezed.dart';

@freezed
abstract class DottoUser with _$DottoUser {
  const factory({
    required String id,
    required String name,
    required String email,
    required String avatarUrl,
    Grade? grade,
    AcademicArea? course,
    AcademicClass? class_,
  }) = _DottoUser;
}
