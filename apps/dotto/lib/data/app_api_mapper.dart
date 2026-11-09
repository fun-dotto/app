import 'package:dotto/domain/entity/academic_area.dart';
import 'package:dotto/domain/entity/academic_class.dart';
import 'package:dotto/domain/entity/cultural_subject_category.dart';
import 'package:dotto/domain/entity/day_of_week.dart';
import 'package:dotto/domain/entity/domain_error.dart';
import 'package:dotto/domain/entity/faculty.dart';
import 'package:dotto/domain/entity/grade.dart';
import 'package:dotto/domain/entity/period.dart';
import 'package:dotto/domain/entity/semester.dart';
import 'package:dotto/domain/entity/subject_classification.dart';
import 'package:dotto/domain/entity/subject_faculty.dart';
import 'package:dotto/domain/entity/subject_requirement_type.dart';
import 'package:dotto/domain/entity/subject_summary.dart';
import 'package:dotto/domain/entity/timetable_slot.dart';
import 'package:dotto_app_api/app/v1/common.pbenum.dart' as api;
import 'package:dotto_app_api/app/v1/subject.pb.dart' as api;
import 'package:dotto_app_api/app/v1/timetable_item.pb.dart' as api;
import 'package:dotto_app_api/google/type/date.pb.dart' as api;
import 'package:dotto_app_api/google/type/dayofweek.pbenum.dart' as api;

/// app-api の Protobuf メッセージとドメインモデルの相互変換。

DomainError _invalid(String message) =>
    DomainError(type: DomainErrorType.invalidData, message: message);

// Date

api.Date toApiDate(DateTime date) =>
    api.Date(year: date.year, month: date.month, day: date.day);

DateTime fromApiDate(api.Date date) =>
    DateTime(date.year, date.month, date.day);

// Subject

SubjectFaculty fromApiSubjectFaculty(api.SubjectFaculty e) => SubjectFaculty(
  faculty: Faculty(
    id: e.faculty.id,
    name: e.faculty.name,
    email: e.faculty.email,
  ),
  isPrimary: e.isPrimary,
);

SubjectSummary fromApiSubjectSummary(api.Subject subject) => SubjectSummary(
  id: subject.id,
  name: subject.name,
  faculties: subject.faculties.map(fromApiSubjectFaculty).toList(),
);

// Grade

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

// Course

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

// Class

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

// Semester

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

// Subject classification / requirement / cultural category

api.SubjectClassification toApiSubjectClassification(SubjectClassification e) =>
    switch (e) {
      SubjectClassification.specialized =>
        api.SubjectClassification.SUBJECT_CLASSIFICATION_SPECIALIZED,
      SubjectClassification.cultural =>
        api.SubjectClassification.SUBJECT_CLASSIFICATION_CULTURAL,
      SubjectClassification.researchInstruction =>
        api.SubjectClassification.SUBJECT_CLASSIFICATION_RESEARCH_INSTRUCTION,
    };

api.SubjectRequirementType toApiSubjectRequirementType(
  SubjectRequirementType e,
) => switch (e) {
  SubjectRequirementType.required =>
    api.SubjectRequirementType.SUBJECT_REQUIREMENT_TYPE_REQUIRED,
  SubjectRequirementType.optional =>
    api.SubjectRequirementType.SUBJECT_REQUIREMENT_TYPE_OPTIONAL,
  SubjectRequirementType.optionalRequired =>
    api.SubjectRequirementType.SUBJECT_REQUIREMENT_TYPE_OPTIONAL_REQUIRED,
};

SubjectRequirementType fromApiSubjectRequirementType(
  api.SubjectRequirementType e,
) => switch (e) {
  api.SubjectRequirementType.SUBJECT_REQUIREMENT_TYPE_REQUIRED =>
    SubjectRequirementType.required,
  api.SubjectRequirementType.SUBJECT_REQUIREMENT_TYPE_OPTIONAL =>
    SubjectRequirementType.optional,
  api.SubjectRequirementType.SUBJECT_REQUIREMENT_TYPE_OPTIONAL_REQUIRED =>
    SubjectRequirementType.optionalRequired,
  _ => throw _invalid('Invalid requirement type: $e'),
};

api.SubjectCulturalSubjectCategory toApiCulturalSubjectCategory(
  CulturalSubjectCategory e,
) => switch (e) {
  CulturalSubjectCategory.society =>
    api
        .SubjectCulturalSubjectCategory
        .SUBJECT_CULTURAL_SUBJECT_CATEGORY_SOCIETY,
  CulturalSubjectCategory.human =>
    api.SubjectCulturalSubjectCategory.SUBJECT_CULTURAL_SUBJECT_CATEGORY_HUMAN,
  CulturalSubjectCategory.science =>
    api
        .SubjectCulturalSubjectCategory
        .SUBJECT_CULTURAL_SUBJECT_CATEGORY_SCIENCE,
  CulturalSubjectCategory.health =>
    api.SubjectCulturalSubjectCategory.SUBJECT_CULTURAL_SUBJECT_CATEGORY_HEALTH,
  CulturalSubjectCategory.communication =>
    api
        .SubjectCulturalSubjectCategory
        .SUBJECT_CULTURAL_SUBJECT_CATEGORY_COMMUNICATION,
};

// Period / DayOfWeek

Period fromApiPeriod(api.Period period) => switch (period) {
  api.Period.PERIOD_1 => Period.first,
  api.Period.PERIOD_2 => Period.second,
  api.Period.PERIOD_3 => Period.third,
  api.Period.PERIOD_4 => Period.fourth,
  api.Period.PERIOD_5 => Period.fifth,
  api.Period.PERIOD_6 => Period.sixth,
  _ => throw _invalid('Invalid period: $period'),
};

DayOfWeek fromApiDayOfWeek(api.DayOfWeek dayOfWeek) => switch (dayOfWeek) {
  api.DayOfWeek.MONDAY => DayOfWeek.monday,
  api.DayOfWeek.TUESDAY => DayOfWeek.tuesday,
  api.DayOfWeek.WEDNESDAY => DayOfWeek.wednesday,
  api.DayOfWeek.THURSDAY => DayOfWeek.thursday,
  api.DayOfWeek.FRIDAY => DayOfWeek.friday,
  api.DayOfWeek.SATURDAY => DayOfWeek.saturday,
  api.DayOfWeek.SUNDAY => DayOfWeek.sunday,
  _ => throw _invalid('Invalid day of week: $dayOfWeek'),
};

/// 時間割の枠を変換する。
///
/// 集中講義など曜日・時限が確定しない科目は枠が `UNSPECIFIED` で返るため、
/// 不正データとして扱わず枠なし (`null`) とする。
TimetableSlot? fromApiTimetableSlot(api.TimetableItemSlot slot) {
  if (slot.dayOfWeek == api.DayOfWeek.DAY_OF_WEEK_UNSPECIFIED ||
      slot.period == api.Period.PERIOD_UNSPECIFIED) {
    return null;
  }
  return TimetableSlot(
    dayOfWeek: fromApiDayOfWeek(slot.dayOfWeek),
    period: fromApiPeriod(slot.period),
  );
}
