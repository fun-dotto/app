import 'package:built_collection/built_collection.dart';
import 'package:dotto/api/api_client.dart';
import 'package:dotto/data/subject_data_source.dart';
import 'package:dotto/domain/entity/academic_area.dart';
import 'package:dotto/domain/entity/academic_class.dart';
import 'package:dotto/domain/entity/cultural_subject_category.dart';
import 'package:dotto/domain/entity/domain_error.dart';
import 'package:dotto/domain/entity/faculty.dart';
import 'package:dotto/domain/entity/grade.dart';
import 'package:dotto/domain/entity/semester.dart';
import 'package:dotto/domain/entity/subject.dart';
import 'package:dotto/domain/entity/subject_classification.dart';
import 'package:dotto/domain/entity/subject_eligible_attribute.dart';
import 'package:dotto/domain/entity/subject_faculty.dart';
import 'package:dotto/domain/entity/subject_feedback.dart';
import 'package:dotto/domain/entity/subject_filter.dart';
import 'package:dotto/domain/entity/subject_requirement.dart';
import 'package:dotto/domain/entity/subject_requirement_type.dart';
import 'package:dotto/domain/entity/subject_summary.dart';
import 'package:dotto/domain/entity/syllabus.dart';
import 'package:dotto/domain/repository/subject_repository.dart';
import 'package:dotto/extension/iterable_extension.dart';
import 'package:openapi/openapi.dart'
    hide Faculty, SubjectFaculty, SubjectSummary;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'subject_repository_impl.g.dart';

@riverpod
SubjectRepository subjectRepository(Ref ref) => SubjectRepositoryImpl(
  ref.watch(apiClientProvider),
  ref.watch(subjectDataSourceProvider),
);

final class SubjectRepositoryImpl implements SubjectRepository {
  const new(this.apiClient, [this._dataSource = const SubjectDataSource()]);

  final SubjectDataSource _dataSource;

  final Openapi apiClient;

  @override
  Future<List<SubjectSummary>> getSubjects(
    String query,
    SubjectFilter filter,
  ) async {
    try {
      final api = apiClient.getSubjectsApi();
      final response = await api.subjectsV1List(
        q: query,
        grades: filter.grades.mapToBuiltListOrNull(
          (e) => switch (e) {
            Grade.b1 => DottoFoundationV1Grade.B1,
            Grade.b2 => DottoFoundationV1Grade.B2,
            Grade.b3 => DottoFoundationV1Grade.B3,
            Grade.b4 => DottoFoundationV1Grade.B4,
            Grade.m1 => DottoFoundationV1Grade.M1,
            Grade.m2 => DottoFoundationV1Grade.M2,
            Grade.d1 => DottoFoundationV1Grade.D1,
            Grade.d2 => DottoFoundationV1Grade.D2,
            Grade.d3 => DottoFoundationV1Grade.D3,
          },
        ),
        courses: filter.courses.mapToBuiltListOrNull(
          (e) => switch (e) {
            AcademicArea.informationSystemCourse =>
              DottoFoundationV1Course.informationSystem,
            AcademicArea.informationDesignCourse =>
              DottoFoundationV1Course.informationDesign,
            AcademicArea.complexCourse => DottoFoundationV1Course.complexSystem,
            AcademicArea.intelligenceSystemCourse =>
              DottoFoundationV1Course.intelligentSystem,
            AcademicArea.advancedICTCourse =>
              DottoFoundationV1Course.advancedICT,
          },
        ),
        classes: filter.classes.isEmpty
            ? null
            : BuiltList<DottoFoundationV1Class>(
                filter.classes.map(
                  (e) => switch (e) {
                    AcademicClass.a => DottoFoundationV1Class.A,
                    AcademicClass.b => DottoFoundationV1Class.B,
                    AcademicClass.c => DottoFoundationV1Class.C,
                    AcademicClass.d => DottoFoundationV1Class.D,
                    AcademicClass.e => DottoFoundationV1Class.E,
                    AcademicClass.f => DottoFoundationV1Class.F,
                    AcademicClass.g => DottoFoundationV1Class.G,
                    AcademicClass.h => DottoFoundationV1Class.H,
                    AcademicClass.i => DottoFoundationV1Class.I,
                    AcademicClass.j => DottoFoundationV1Class.J,
                    AcademicClass.k => DottoFoundationV1Class.K,
                    AcademicClass.l => DottoFoundationV1Class.L,
                  },
                ),
              ),
        classifications: filter.classifications.isEmpty
            ? null
            : BuiltList<DottoFoundationV1SubjectClassification>(
                filter.classifications.map(
                  (e) => switch (e) {
                    SubjectClassification.specialized =>
                      DottoFoundationV1SubjectClassification.specialized,
                    SubjectClassification.cultural =>
                      DottoFoundationV1SubjectClassification.cultural,
                    SubjectClassification.researchInstruction =>
                      DottoFoundationV1SubjectClassification
                          .researchInstruction,
                  },
                ),
              ),
        semesters: filter.semesters.isEmpty
            ? null
            : BuiltList<DottoFoundationV1CourseSemester>(
                filter.semesters.map(
                  (e) => switch (e) {
                    Semester.h1 => DottoFoundationV1CourseSemester.H1,
                    Semester.h2 => DottoFoundationV1CourseSemester.H2,
                    Semester.allYear => DottoFoundationV1CourseSemester.allYear,
                    Semester.q1 => DottoFoundationV1CourseSemester.Q1,
                    Semester.q2 => DottoFoundationV1CourseSemester.Q2,
                    Semester.q3 => DottoFoundationV1CourseSemester.Q3,
                    Semester.q4 => DottoFoundationV1CourseSemester.Q4,
                    Semester.summerIntensive =>
                      DottoFoundationV1CourseSemester.summerIntensive,
                    Semester.winterIntensive =>
                      DottoFoundationV1CourseSemester.winterIntensive,
                  },
                ),
              ),
        requirementTypes: filter.requirements.isEmpty
            ? null
            : BuiltList<DottoFoundationV1SubjectRequirementType>(
                filter.requirements.map(
                  (e) => switch (e) {
                    SubjectRequirementType.required =>
                      DottoFoundationV1SubjectRequirementType.required_,
                    SubjectRequirementType.optional =>
                      DottoFoundationV1SubjectRequirementType.optional,
                    SubjectRequirementType.optionalRequired =>
                      DottoFoundationV1SubjectRequirementType.optionalRequired,
                  },
                ),
              ),
        culturalSubjectCategories: filter.culturalSubjectCategories.isEmpty
            ? null
            : BuiltList<DottoFoundationV1CulturalSubjectCategory>(
                filter.culturalSubjectCategories.map(
                  (e) => switch (e) {
                    CulturalSubjectCategory.society =>
                      DottoFoundationV1CulturalSubjectCategory.society,
                    CulturalSubjectCategory.human =>
                      DottoFoundationV1CulturalSubjectCategory.human,
                    CulturalSubjectCategory.science =>
                      DottoFoundationV1CulturalSubjectCategory.science,
                    CulturalSubjectCategory.health =>
                      DottoFoundationV1CulturalSubjectCategory.health,
                    CulturalSubjectCategory.communication =>
                      DottoFoundationV1CulturalSubjectCategory.communication,
                  },
                ),
              ),
      );
      if (response.statusCode != 200) {
        throw const DomainError(
          type: DomainErrorType.invalidResponse,
          message: 'Failed to get subjects',
        );
      }
      final data = response.data;
      if (data == null) {
        throw const DomainError(
          type: DomainErrorType.invalidResponse,
          message: 'Failed to get subjects',
        );
      }
      return List<SubjectSummary>.unmodifiable(
        data.subjects
            .map(
              (e) => SubjectSummary(
                id: e.id,
                name: e.name,
                faculties: e.faculties
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
                    .toList(),
                credit: e.credit,
                semester: switch (e.semester) {
                  DottoFoundationV1CourseSemester.H1 => Semester.h1,
                  DottoFoundationV1CourseSemester.H2 => Semester.h2,
                  DottoFoundationV1CourseSemester.allYear => Semester.allYear,
                  DottoFoundationV1CourseSemester.Q1 => Semester.q1,
                  DottoFoundationV1CourseSemester.Q2 => Semester.q2,
                  DottoFoundationV1CourseSemester.Q3 => Semester.q3,
                  DottoFoundationV1CourseSemester.Q4 => Semester.q4,
                  DottoFoundationV1CourseSemester.summerIntensive =>
                    Semester.summerIntensive,
                  DottoFoundationV1CourseSemester.winterIntensive =>
                    Semester.winterIntensive,
                  _ => null,
                },
              ),
            )
            .toList(),
      );
    } on DomainError {
      rethrow;
    } on Exception catch (e, stackTrace) {
      throw DomainError.fromException(e: e, stackTrace: stackTrace);
      // 型の不整合もキャッシュ/APIの不正なレスポンスとして扱う。
      // ignore: avoid_catching_errors
    } on TypeError catch (e, stackTrace) {
      throw DomainError(
        type: DomainErrorType.unknown,
        message: e.toString(),
        stackTrace: stackTrace,
      );
    }
  }

  @override
  Future<Subject> getSubject(String id) async {
    try {
      final api = apiClient.getSubjectsApi();
      final response = await api.subjectsV1Detail(id: id);
      if (response.statusCode != 200) {
        throw const DomainError(
          type: DomainErrorType.invalidResponse,
          message: 'Failed to get subject',
        );
      }
      final data = response.data;
      if (data == null) {
        throw const DomainError(
          type: DomainErrorType.invalidResponse,
          message: 'Failed to get subject',
        );
      }
      final subject = data.subject;
      final pastExamId =
          await _dataSource.readPastExamId(subject.syllabus.id) ??
          subject.syllabus.id;
      return Subject(
        id: subject.id,
        name: subject.name,
        faculties: subject.faculties
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
            .toList(),
        year: subject.year,
        semester: switch (subject.semester) {
          DottoFoundationV1CourseSemester.H1 => Semester.h1,
          DottoFoundationV1CourseSemester.H2 => Semester.h2,
          DottoFoundationV1CourseSemester.allYear => Semester.allYear,
          DottoFoundationV1CourseSemester.Q1 => Semester.q1,
          DottoFoundationV1CourseSemester.Q2 => Semester.q2,
          DottoFoundationV1CourseSemester.Q3 => Semester.q3,
          DottoFoundationV1CourseSemester.Q4 => Semester.q4,
          DottoFoundationV1CourseSemester.summerIntensive =>
            Semester.summerIntensive,
          DottoFoundationV1CourseSemester.winterIntensive =>
            Semester.winterIntensive,
          _ => throw DomainError(
            type: DomainErrorType.invalidData,
            message: 'Invalid semester: ${subject.semester}',
          ),
        },
        credit: subject.credit,
        eligibleAttributes: subject.eligibleAttributes
            .map(
              (e) => SubjectEligibleAttribute(
                grade: switch (e.grade) {
                  DottoFoundationV1Grade.B1 => Grade.b1,
                  DottoFoundationV1Grade.B2 => Grade.b2,
                  DottoFoundationV1Grade.B3 => Grade.b3,
                  DottoFoundationV1Grade.B4 => Grade.b4,
                  DottoFoundationV1Grade.M1 => Grade.m1,
                  DottoFoundationV1Grade.M2 => Grade.m2,
                  DottoFoundationV1Grade.D1 => Grade.d1,
                  DottoFoundationV1Grade.D2 => Grade.d2,
                  DottoFoundationV1Grade.D3 => Grade.d3,
                  _ => throw DomainError(
                    type: DomainErrorType.invalidData,
                    message: 'Invalid grade: ${e.grade}',
                  ),
                },
                class_: switch (e.class_) {
                  DottoFoundationV1Class.A => AcademicClass.a,
                  DottoFoundationV1Class.B => AcademicClass.b,
                  DottoFoundationV1Class.C => AcademicClass.c,
                  DottoFoundationV1Class.D => AcademicClass.d,
                  DottoFoundationV1Class.E => AcademicClass.e,
                  DottoFoundationV1Class.F => AcademicClass.f,
                  DottoFoundationV1Class.G => AcademicClass.g,
                  DottoFoundationV1Class.H => AcademicClass.h,
                  DottoFoundationV1Class.I => AcademicClass.i,
                  DottoFoundationV1Class.J => AcademicClass.j,
                  DottoFoundationV1Class.K => AcademicClass.k,
                  DottoFoundationV1Class.L => AcademicClass.l,
                  null => null,
                  _ => throw DomainError(
                    type: DomainErrorType.invalidData,
                    message: 'Invalid class: ${e.class_}',
                  ),
                },
              ),
            )
            .toList(),
        requirements: subject.requirements
            .map(
              (e) => SubjectRequirement(
                course: switch (e.course) {
                  DottoFoundationV1Course.informationSystem =>
                    AcademicArea.informationSystemCourse,
                  DottoFoundationV1Course.informationDesign =>
                    AcademicArea.informationDesignCourse,
                  DottoFoundationV1Course.complexSystem =>
                    AcademicArea.complexCourse,
                  DottoFoundationV1Course.intelligentSystem =>
                    AcademicArea.intelligenceSystemCourse,
                  DottoFoundationV1Course.advancedICT =>
                    AcademicArea.advancedICTCourse,
                  _ => throw DomainError(
                    type: DomainErrorType.invalidData,
                    message: 'Invalid course: ${e.course}',
                  ),
                },
                requirementType: switch (e.requirementType) {
                  DottoFoundationV1SubjectRequirementType.required_ =>
                    SubjectRequirementType.required,
                  DottoFoundationV1SubjectRequirementType.optional =>
                    SubjectRequirementType.optional,
                  DottoFoundationV1SubjectRequirementType.optionalRequired =>
                    SubjectRequirementType.optionalRequired,
                  _ => throw DomainError(
                    type: DomainErrorType.invalidData,
                    message: 'Invalid requirement type: ${e.requirementType}',
                  ),
                },
              ),
            )
            .toList(),
        syllabus: Syllabus(
          id: subject.syllabus.id,
          name: subject.syllabus.name,
          enName: subject.syllabus.enName,
          grades: subject.syllabus.grades,
          credit: subject.syllabus.credit,
          facultyNames: subject.syllabus.facultyNames,
          practicalHomeFacultyCategory:
              subject.syllabus.practicalHomeFacultyCategory,
          multiplePersonTeachingForm:
              subject.syllabus.multiplePersonTeachingForm,
          teachingForm: subject.syllabus.teachingForm,
          summary: subject.syllabus.summary,
          learningOutcomes: subject.syllabus.learningOutcomes,
          assignments: subject.syllabus.assignments,
          evaluationMethod: subject.syllabus.evaluationMethod,
          textbooks: subject.syllabus.textbooks,
          referenceBooks: subject.syllabus.referenceBooks,
          prerequisites: subject.syllabus.prerequisites,
          preLearning: subject.syllabus.preLearning,
          postLearning: subject.syllabus.postLearning,
          notes: subject.syllabus.notes,
          keywords: subject.syllabus.keywords,
          targetCourses: subject.syllabus.targetCourses,
          targetAreas: subject.syllabus.targetAreas,
          classifications: subject.syllabus.classifications,
          teachingLanguage: subject.syllabus.teachingLanguage,
          contentsAndSchedule: subject.syllabus.contentsAndSchedule,
          teachingAndExamForm: subject.syllabus.teachingAndExamForm,
          dsopSubject: subject.syllabus.dsopSubject,
        ),
        pastExamId: pastExamId,
      );
    } on DomainError {
      rethrow;
    } on Exception catch (e, stackTrace) {
      throw DomainError.fromException(e: e, stackTrace: stackTrace);
      // 型の不整合もキャッシュ/APIの不正なレスポンスとして扱う。
      // ignore: avoid_catching_errors
    } on TypeError catch (e, stackTrace) {
      throw DomainError(
        type: DomainErrorType.unknown,
        message: e.toString(),
        stackTrace: stackTrace,
      );
    }
  }

  @override
  Future<List<SubjectFeedback>> getFeedbacks(String lessonId) async {
    try {
      final records = await _dataSource.readFeedbacks(lessonId);
      final feedbacks = <SubjectFeedback>[];
      for (final doc in records) {
        final score = doc['score'] as num?;
        final comment = doc['detail'] as String?;
        if (score == null || comment == null) {
          continue;
        }
        feedbacks.add(SubjectFeedback(score: score.toInt(), comment: comment));
      }
      return List.unmodifiable(feedbacks);
    } on Exception catch (e, stackTrace) {
      throw DomainError.fromException(e: e, stackTrace: stackTrace);
      // 型の不整合もキャッシュ/APIの不正なレスポンスとして扱う。
      // ignore: avoid_catching_errors
    } on TypeError catch (e, stackTrace) {
      throw DomainError(
        type: DomainErrorType.unknown,
        message: e.toString(),
        stackTrace: stackTrace,
      );
    }
  }

  @override
  Future<void> createFeedback({
    required String userId,
    required String lessonId,
    required int score,
    required String comment,
  }) async {
    try {
      await _dataSource.writeFeedback(
        userId: userId,
        lessonId: lessonId,
        score: score,
        comment: comment,
      );
    } on Exception catch (e, stackTrace) {
      throw DomainError.fromException(e: e, stackTrace: stackTrace);
      // 型の不整合もキャッシュ/APIの不正なレスポンスとして扱う。
      // ignore: avoid_catching_errors
    } on TypeError catch (e, stackTrace) {
      throw DomainError(
        type: DomainErrorType.unknown,
        message: e.toString(),
        stackTrace: stackTrace,
      );
    }
  }
}
