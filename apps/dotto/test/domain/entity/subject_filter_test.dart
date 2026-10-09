import 'package:dotto/domain/entity/grade.dart';
import 'package:dotto/domain/entity/semester.dart';
import 'package:dotto/domain/entity/subject_filter.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('条件を指定しないフィルタは有効な条件を持たない', () {
    expect(const SubjectFilter().hasActiveFilters, isFalse);
  });

  test('いずれかの条件を指定すると有効な条件を持つ', () {
    expect(const SubjectFilter(grades: [Grade.b1]).hasActiveFilters, isTrue);
    expect(
      const SubjectFilter(semesters: [Semester.q1]).hasActiveFilters,
      isTrue,
    );
  });

  test('条件のリストは変更できない', () {
    const filter = SubjectFilter(grades: [Grade.b1]);

    expect(() => filter.grades.add(Grade.b2), throwsUnsupportedError);
  });
}
