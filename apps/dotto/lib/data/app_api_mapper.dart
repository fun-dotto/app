import 'package:dotto/domain/entity/academic_area.dart';
import 'package:dotto/domain/entity/academic_class.dart';
import 'package:dotto/domain/entity/day_of_week.dart';
import 'package:dotto/domain/entity/domain_error.dart';
import 'package:dotto/domain/entity/faculty.dart';
import 'package:dotto/domain/entity/grade.dart';
import 'package:dotto/domain/entity/period.dart';
import 'package:dotto/domain/entity/semester.dart';
import 'package:dotto/domain/entity/subject_faculty.dart';
import 'package:dotto/domain/entity/subject_summary.dart';
import 'package:dotto_app_api/app/v1/common.pbenum.dart' as api;
import 'package:dotto_app_api/app/v1/subject.pb.dart' as api;
import 'package:dotto_app_api/google/type/date.pb.dart' as api;
import 'package:dotto_app_api/google/type/dayofweek.pbenum.dart' as api;

/// [DateTime] の日付部分を API の Date に変換する。
api.Date toApiDate(DateTime date) =>
    api.Date(year: date.year, month: date.month, day: date.day);

/// API の Date を [DateTime] に変換する。
DateTime fromApiDate(api.Date date) =>
    DateTime(date.year, date.month, date.day);

/// API の科目をドメインの [SubjectSummary] に変換する。
SubjectSummary toSubjectSummary(api.Subject subject) => SubjectSummary(
  id: subject.id,
  name: subject.name,
  faculties: toSubjectFaculties(subject.faculties),
);

/// API の担当教員一覧をドメインに変換する。
List<SubjectFaculty> toSubjectFaculties(
  Iterable<api.SubjectFaculty> faculties,
) => faculties
    .map(
      (e) => SubjectFaculty(
        faculty: Faculty(
          id: e.faculty.id,
          name: e.faculty.name,
          email: e.faculty.email,
        ),
        isPrimary: e.isPrimary,
      ),
    )
    .toList();

api.SubjectSemester toApiSemester(Semester semester) => switch (semester) {
  Semester.h1 => api.SubjectSemester.SUBJECT_SEMESTER_H1,
  Semester.h2 => api.SubjectSemester.SUBJECT_SEMESTER_H2,
  Semester.allYear => api.SubjectSemester.SUBJECT_SEMESTER_ALL_YEAR,
  Semester.q1 => api.SubjectSemester.SUBJECT_SEMESTER_Q1,
  Semester.q2 => api.SubjectSemester.SUBJECT_SEMESTER_Q2,
  Semester.q3 => api.SubjectSemester.SUBJECT_SEMESTER_Q3,
  Semester.q4 => api.SubjectSemester.SUBJECT_SEMESTER_Q4,
  Semester.summerIntensive =>
    api.SubjectSemester.SUBJECT_SEMESTER_SUMMER_INTENSIVE,
  Semester.winterIntensive =>
    api.SubjectSemester.SUBJECT_SEMESTER_WINTER_INTENSIVE,
};

Semester? fromApiSemester(api.SubjectSemester semester) => switch (semester) {
  api.SubjectSemester.SUBJECT_SEMESTER_H1 => Semester.h1,
  api.SubjectSemester.SUBJECT_SEMESTER_H2 => Semester.h2,
  api.SubjectSemester.SUBJECT_SEMESTER_ALL_YEAR => Semester.allYear,
  api.SubjectSemester.SUBJECT_SEMESTER_Q1 => Semester.q1,
  api.SubjectSemester.SUBJECT_SEMESTER_Q2 => Semester.q2,
  api.SubjectSemester.SUBJECT_SEMESTER_Q3 => Semester.q3,
  api.SubjectSemester.SUBJECT_SEMESTER_Q4 => Semester.q4,
  api.SubjectSemester.SUBJECT_SEMESTER_SUMMER_INTENSIVE =>
    Semester.summerIntensive,
  api.SubjectSemester.SUBJECT_SEMESTER_WINTER_INTENSIVE =>
    Semester.winterIntensive,
  _ => null,
};

api.Grade toApiGrade(Grade grade) => switch (grade) {
  Grade.b1 => api.Grade.GRADE_B1,
  Grade.b2 => api.Grade.GRADE_B2,
  Grade.b3 => api.Grade.GRADE_B3,
  Grade.b4 => api.Grade.GRADE_B4,
  Grade.m1 => api.Grade.GRADE_M1,
  Grade.m2 => api.Grade.GRADE_M2,
  Grade.d1 => api.Grade.GRADE_D1,
  Grade.d2 => api.Grade.GRADE_D2,
  Grade.d3 => api.Grade.GRADE_D3,
};

Grade? fromApiGrade(api.Grade grade) => switch (grade) {
  api.Grade.GRADE_B1 => Grade.b1,
  api.Grade.GRADE_B2 => Grade.b2,
  api.Grade.GRADE_B3 => Grade.b3,
  api.Grade.GRADE_B4 => Grade.b4,
  api.Grade.GRADE_M1 => Grade.m1,
  api.Grade.GRADE_M2 => Grade.m2,
  api.Grade.GRADE_D1 => Grade.d1,
  api.Grade.GRADE_D2 => Grade.d2,
  api.Grade.GRADE_D3 => Grade.d3,
  _ => null,
};

api.Course toApiCourse(AcademicArea course) => switch (course) {
  AcademicArea.informationSystemCourse => api.Course.COURSE_INFORMATION_SYSTEM,
  AcademicArea.informationDesignCourse => api.Course.COURSE_INFORMATION_DESIGN,
  AcademicArea.complexCourse => api.Course.COURSE_COMPLEX_SYSTEM,
  AcademicArea.intelligenceSystemCourse => api.Course.COURSE_INTELLIGENT_SYSTEM,
  AcademicArea.advancedICTCourse => api.Course.COURSE_ADVANCED_ICT,
};

AcademicArea? fromApiCourse(api.Course course) => switch (course) {
  api.Course.COURSE_INFORMATION_SYSTEM => AcademicArea.informationSystemCourse,
  api.Course.COURSE_INFORMATION_DESIGN => AcademicArea.informationDesignCourse,
  api.Course.COURSE_COMPLEX_SYSTEM => AcademicArea.complexCourse,
  api.Course.COURSE_INTELLIGENT_SYSTEM => AcademicArea.intelligenceSystemCourse,
  api.Course.COURSE_ADVANCED_ICT => AcademicArea.advancedICTCourse,
  _ => null,
};

api.Class toApiClass(AcademicClass class_) => switch (class_) {
  AcademicClass.a => api.Class.CLASS_A,
  AcademicClass.b => api.Class.CLASS_B,
  AcademicClass.c => api.Class.CLASS_C,
  AcademicClass.d => api.Class.CLASS_D,
  AcademicClass.e => api.Class.CLASS_E,
  AcademicClass.f => api.Class.CLASS_F,
  AcademicClass.g => api.Class.CLASS_G,
  AcademicClass.h => api.Class.CLASS_H,
  AcademicClass.i => api.Class.CLASS_I,
  AcademicClass.j => api.Class.CLASS_J,
  AcademicClass.k => api.Class.CLASS_K,
  AcademicClass.l => api.Class.CLASS_L,
};

AcademicClass? fromApiClass(api.Class class_) => switch (class_) {
  api.Class.CLASS_A => AcademicClass.a,
  api.Class.CLASS_B => AcademicClass.b,
  api.Class.CLASS_C => AcademicClass.c,
  api.Class.CLASS_D => AcademicClass.d,
  api.Class.CLASS_E => AcademicClass.e,
  api.Class.CLASS_F => AcademicClass.f,
  api.Class.CLASS_G => AcademicClass.g,
  api.Class.CLASS_H => AcademicClass.h,
  api.Class.CLASS_I => AcademicClass.i,
  api.Class.CLASS_J => AcademicClass.j,
  api.Class.CLASS_K => AcademicClass.k,
  api.Class.CLASS_L => AcademicClass.l,
  _ => null,
};

/// API の時限を [Period] に変換する。未定義の値は [DomainError] を投げる。
Period fromApiPeriod(api.Period period) => switch (period) {
  api.Period.PERIOD_1 => Period.first,
  api.Period.PERIOD_2 => Period.second,
  api.Period.PERIOD_3 => Period.third,
  api.Period.PERIOD_4 => Period.fourth,
  api.Period.PERIOD_5 => Period.fifth,
  api.Period.PERIOD_6 => Period.sixth,
  _ => throw DomainError(
    type: DomainErrorType.invalidData,
    message: 'Unsupported period: $period',
  ),
};

/// API の曜日を [DayOfWeek] に変換する。未定義の値は [DomainError] を投げる。
DayOfWeek fromApiDayOfWeek(api.DayOfWeek dayOfWeek) => switch (dayOfWeek) {
  api.DayOfWeek.MONDAY => DayOfWeek.monday,
  api.DayOfWeek.TUESDAY => DayOfWeek.tuesday,
  api.DayOfWeek.WEDNESDAY => DayOfWeek.wednesday,
  api.DayOfWeek.THURSDAY => DayOfWeek.thursday,
  api.DayOfWeek.FRIDAY => DayOfWeek.friday,
  api.DayOfWeek.SATURDAY => DayOfWeek.saturday,
  api.DayOfWeek.SUNDAY => DayOfWeek.sunday,
  _ => throw const DomainError(
    type: DomainErrorType.invalidData,
    message: 'Invalid day of week',
  ),
};
