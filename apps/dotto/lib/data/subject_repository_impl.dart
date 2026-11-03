import 'package:connectrpc/connect.dart';
import 'package:dotto/data/api_client.dart';
import 'package:dotto/data/app_api_mapper.dart';
import 'package:dotto/data/domain_error_mapper.dart';
import 'package:dotto/data/subject_data_source.dart';
import 'package:dotto/domain/entity/cultural_subject_category.dart';
import 'package:dotto/domain/entity/domain_error.dart';
import 'package:dotto/domain/entity/subject.dart';
import 'package:dotto/domain/entity/subject_classification.dart';
import 'package:dotto/domain/entity/subject_eligible_attribute.dart';
import 'package:dotto/domain/entity/subject_feedback.dart';
import 'package:dotto/domain/entity/subject_filter.dart';
import 'package:dotto/domain/entity/subject_requirement.dart';
import 'package:dotto/domain/entity/subject_requirement_type.dart';
import 'package:dotto/domain/entity/subject_summary.dart';
import 'package:dotto/domain/entity/syllabus.dart';
import 'package:dotto/domain/repository/subject_repository.dart';
import 'package:dotto_app_api/app/v1/subject.connect.client.dart';
import 'package:dotto_app_api/app/v1/subject.pb.dart' as api;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'subject_repository_impl.g.dart';

@riverpod
SubjectRepository subjectRepository(Ref ref) => SubjectRepositoryImpl(
  ref.watch(apiClientProvider),
  ref.watch(subjectDataSourceProvider),
);

final class SubjectRepositoryImpl implements SubjectRepository {
  const new(this._transport, this._dataSource);

  final SubjectDataSource _dataSource;

  final Transport _transport;

  SubjectServiceClient get _client => SubjectServiceClient(_transport);

  @override
  Future<List<SubjectSummary>> getSubjects(
    String query,
    SubjectFilter filter,
  ) async {
    try {
      final response = await _client.listSubjects(
        api.ListSubjectsRequest(
          query: query,
          grades: filter.grades.map(toApiGrade),
          courses: filter.courses.map(toApiCourse),
          classes: filter.classes.map(toApiClass),
          classifications: filter.classifications.map(
            (e) => switch (e) {
              SubjectClassification.specialized =>
                api.SubjectClassification.SUBJECT_CLASSIFICATION_SPECIALIZED,
              SubjectClassification.cultural =>
                api.SubjectClassification.SUBJECT_CLASSIFICATION_CULTURAL,
              SubjectClassification.researchInstruction =>
                api
                    .SubjectClassification
                    .SUBJECT_CLASSIFICATION_RESEARCH_INSTRUCTION,
            },
          ),
          semesters: filter.semesters.map(toApiSemester),
          requirementTypes: filter.requirements.map(
            (e) => switch (e) {
              SubjectRequirementType.required =>
                api.SubjectRequirementType.SUBJECT_REQUIREMENT_TYPE_REQUIRED,
              SubjectRequirementType.optional =>
                api.SubjectRequirementType.SUBJECT_REQUIREMENT_TYPE_OPTIONAL,
              SubjectRequirementType.optionalRequired =>
                api
                    .SubjectRequirementType
                    .SUBJECT_REQUIREMENT_TYPE_OPTIONAL_REQUIRED,
            },
          ),
          culturalSubjectCategories: filter.culturalSubjectCategories.map(
            (e) => switch (e) {
              CulturalSubjectCategory.society =>
                api
                    .SubjectCulturalSubjectCategory
                    .SUBJECT_CULTURAL_SUBJECT_CATEGORY_SOCIETY,
              CulturalSubjectCategory.human =>
                api
                    .SubjectCulturalSubjectCategory
                    .SUBJECT_CULTURAL_SUBJECT_CATEGORY_HUMAN,
              CulturalSubjectCategory.science =>
                api
                    .SubjectCulturalSubjectCategory
                    .SUBJECT_CULTURAL_SUBJECT_CATEGORY_SCIENCE,
              CulturalSubjectCategory.health =>
                api
                    .SubjectCulturalSubjectCategory
                    .SUBJECT_CULTURAL_SUBJECT_CATEGORY_HEALTH,
              CulturalSubjectCategory.communication =>
                api
                    .SubjectCulturalSubjectCategory
                    .SUBJECT_CULTURAL_SUBJECT_CATEGORY_COMMUNICATION,
            },
          ),
        ),
      );
      return List<SubjectSummary>.unmodifiable(
        response.subjects.map(
          (e) => SubjectSummary(
            id: e.id,
            name: e.name,
            faculties: toSubjectFaculties(e.faculties),
            credit: e.credit,
            semester: fromApiSemester(e.semester),
          ),
        ),
      );
    } on DomainError {
      rethrow;
    } on Exception catch (e, stackTrace) {
      throw mapDomainError(e: e, stackTrace: stackTrace);
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
      final response = await _client.getSubject(api.GetSubjectRequest(id: id));
      if (!response.hasSubject()) {
        throw const DomainError(
          type: DomainErrorType.invalidResponse,
          message: 'Failed to get subject',
        );
      }
      final subject = response.subject;
      final syllabus = subject.syllabus;
      final pastExamId =
          await _dataSource.readPastExamId(syllabus.id) ?? syllabus.id;
      return Subject(
        id: subject.id,
        name: subject.name,
        faculties: toSubjectFaculties(subject.faculties),
        year: subject.year,
        semester:
            fromApiSemester(subject.semester) ??
            (throw DomainError(
              type: DomainErrorType.invalidData,
              message: 'Invalid semester: ${subject.semester}',
            )),
        credit: subject.credit,
        eligibleAttributes: subject.eligibleAttributes
            .map(
              (e) => SubjectEligibleAttribute(
                grade:
                    fromApiGrade(e.grade) ??
                    (throw DomainError(
                      type: DomainErrorType.invalidData,
                      message: 'Invalid grade: ${e.grade}',
                    )),
                class_: e.hasClass_2()
                    ? fromApiClass(e.class_2) ??
                          (throw DomainError(
                            type: DomainErrorType.invalidData,
                            message: 'Invalid class: ${e.class_2}',
                          ))
                    : null,
              ),
            )
            .toList(),
        requirements: subject.requirements
            .map(
              (e) => SubjectRequirement(
                course:
                    fromApiCourse(e.course) ??
                    (throw DomainError(
                      type: DomainErrorType.invalidData,
                      message: 'Invalid course: ${e.course}',
                    )),
                requirementType: switch (e.requirementType) {
                  api
                      .SubjectRequirementType
                      .SUBJECT_REQUIREMENT_TYPE_REQUIRED =>
                    SubjectRequirementType.required,
                  api
                      .SubjectRequirementType
                      .SUBJECT_REQUIREMENT_TYPE_OPTIONAL =>
                    SubjectRequirementType.optional,
                  api
                      .SubjectRequirementType
                      .SUBJECT_REQUIREMENT_TYPE_OPTIONAL_REQUIRED =>
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
          id: syllabus.id,
          name: syllabus.name,
          enName: syllabus.enName,
          grades: syllabus.grades,
          credit: syllabus.credit,
          facultyNames: syllabus.facultyNames,
          practicalHomeFacultyCategory: syllabus.practicalHomeFacultyCategory,
          multiplePersonTeachingForm: syllabus.multiplePersonTeachingForm,
          teachingForm: syllabus.teachingForm,
          summary: syllabus.summary,
          learningOutcomes: syllabus.learningOutcomes,
          assignments: syllabus.assignments,
          evaluationMethod: syllabus.evaluationMethod,
          textbooks: syllabus.textbooks,
          referenceBooks: syllabus.referenceBooks,
          prerequisites: syllabus.prerequisites,
          preLearning: syllabus.preLearning,
          postLearning: syllabus.postLearning,
          notes: syllabus.notes,
          keywords: syllabus.keywords,
          targetCourses: syllabus.targetCourses,
          targetAreas: syllabus.targetAreas,
          classifications: syllabus.classifications,
          teachingLanguage: syllabus.teachingLanguage,
          contentsAndSchedule: syllabus.contentsAndSchedule,
          teachingAndExamForm: syllabus.teachingAndExamForm,
          dsopSubject: syllabus.dsopSubject,
        ),
        pastExamId: pastExamId,
      );
    } on DomainError {
      rethrow;
    } on Exception catch (e, stackTrace) {
      throw mapDomainError(e: e, stackTrace: stackTrace);
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
      throw mapDomainError(e: e, stackTrace: stackTrace);
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
      throw mapDomainError(e: e, stackTrace: stackTrace);
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
