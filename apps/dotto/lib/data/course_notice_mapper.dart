import 'package:dotto/domain/entity/faculty.dart';
import 'package:dotto/domain/entity/subject_faculty.dart';
import 'package:dotto/domain/entity/subject_summary.dart';
import 'package:openapi/openapi.dart' as api;

/// API の通知内にある科目をドメインに変換する。
SubjectSummary mapNoticeSubject(api.SubjectSummary subject) => SubjectSummary(
  id: subject.id,
  name: subject.name,
  faculties: subject.faculties
      .map(
        (faculty) => SubjectFaculty(
          faculty: Faculty(
            id: faculty.faculty.id,
            name: faculty.faculty.name,
            email: faculty.faculty.email,
          ),
          isPrimary: faculty.isPrimary,
        ),
      )
      .toList(),
);
int mapNoticePeriod(api.DottoFoundationV1Period period) => switch (period) {
  api.DottoFoundationV1Period.period1 => 1,
  api.DottoFoundationV1Period.period2 => 2,
  api.DottoFoundationV1Period.period3 => 3,
  api.DottoFoundationV1Period.period4 => 4,
  api.DottoFoundationV1Period.period5 => 5,
  api.DottoFoundationV1Period.period6 => 6,
  _ => throw FormatException('Invalid course period: $period'),
};
